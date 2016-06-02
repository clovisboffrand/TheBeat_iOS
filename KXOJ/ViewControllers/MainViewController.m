//
//  MainViewController.m
//  iRadio
//
//  Created by ben on 10/05/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Header.h"
#import "NSString+HTML.h"

@interface MainViewController()
{
    IBOutlet UIWebView *_adWebView;
}

@end

@implementation MainViewController

@synthesize radiosound;
@synthesize playpausebutton;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self reloadRadioStreaming:nil];
    
    // Register self for remote notifications of play/pause toggle
    // (i.e. when user backgrounds app, double-taps home,
    // then swipes right to reveal multimedia control buttons).
    // See MyWindow.h for more info.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbutton)
                                                 name:@"TogglePlayPause"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reOpenApp)
                                                 name:@"reOpenApp"
                                               object:nil];
    
    // Add notification methods
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didSetAlarm)
                                                 name:@"setAlarm"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didWakeup)
                                                 name:@"didWakeup"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateStream)
                                                 name:@"updateStream"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playRadio)
                                                 name:@"playRadio"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseRadio)
                                                 name:@"pauseRadio"
                                               object:nil];
    
    [self updatebuttonstatus];
    
    [self addBanner];
}

- (void)viewDidAppear:(BOOL)animated
{
    GoogleTrackingBlock(self, CLASS_VC);
    [super viewDidAppear:animated];
}

- (void)addBanner
{
    [_adWebView loadHTMLString:[CommonHelpers HTMLBodyOfBannerView] baseURL:nil];
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    
    if (inType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)playRadio
{
    if ([self.playpausebutton.imageView.image isEqual:[UIImage imageNamed:@"play.png"]]) {
        [self playCurrentTrack];
    }
}

- (void)pauseRadio
{
    [self pauseCurrentTrack];
}

- (void)reOpenApp
{
    if ([self.radiosound rate] == 0.0) {
        [self playCurrentTrack];
    }
}

- (void)buffering {
}

- (void)didSetAlarm
{
    [self pauseCurrentTrack];
}

- (void)updateStream
{
    if (radiosound.rate == 1.0) {
        [self pauseCurrentTrack];
    }
    else {
        [self playCurrentTrack];
    }
}

- (void)didWakeup
{
    [self playCurrentTrack];
}

- (void)updatebuttonstatus
{
    if (radiosound.rate == 1.0) {
        [self.playpausebutton setImage:[UIImage imageNamed:@"pause.png"]
                              forState:UIControlStateNormal];
    } else {
        [self.playpausebutton setImage:[UIImage imageNamed:@"play.png"]
                              forState:UIControlStateNormal];
    }
}

- (IBAction)playbutton {
    if (radiosound.rate == 1.0) {
        [self pauseCurrentTrack];
    } else {
        [self playCurrentTrack];
    }
}

- (void)playCurrentTrack
{
    [self.radiosound play];
    
    // Update image states to reflect "Pause" option
    [self.playpausebutton setImage:[UIImage imageNamed:@"pause"]
                          forState:UIControlStateNormal];
}

- (IBAction)stopTapped:(id)sender
{
    [self pauseCurrentTrack];
}

- (void)pauseCurrentTrack
{
    [self.radiosound pause];
    
    // Update image states to reflect "Play" option
    [self.playpausebutton setImage:[UIImage imageNamed:@"play"]
                          forState:UIControlStateNormal];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
}

#pragma mark - Notification Stream Radio
- (void)reloadRadioStreaming:(NSNotification *)notification
{
    /* Pick any one of them */
    // 1. Overriding the output audio route
    //UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    //AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    
    // 2. Changing the default output audio route
    //    UInt32 doChangeDefaultRoute = 1;
    //    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    
    BOOL success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&setCategoryError];
    if (!success) {
    }
    
    NSURL *url = [NSURL URLWithString:STREAM_URL];
    radiosound = [[AVPlayer alloc] initWithURL:url];
    [radiosound play];
    
    // Volume control
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:volumeSlider.bounds];
    [volumeSlider addSubview:volumeView];
    [volumeView sizeToFit];
    
    // share instance for audio remote control
    // Registers this class as the delegate of the audio session.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(interruption:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];
    
    // Allow the app sound to continue to play when the screen is locked.
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)interruption:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSUInteger interuptionType = (NSUInteger)[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey];
    
    if (interuptionType == AVAudioSessionInterruptionTypeBegan) {
        [self beginInterruption];
    }
#if __CC_PLATFORM_IOS >= 40000
    else if (interuptionType == AVAudioSessionInterruptionTypeEnded) {
        [self endInterruptionWithFlags:(NSUInteger)[interuptionDict valueForKey:AVAudioSessionInterruptionOptionKey]];
    }
#else
    else if (interuptionType == AVAudioSessionInterruptionTypeEnded) {
        [self endInterruption];
    }
#endif
    
}

@end
