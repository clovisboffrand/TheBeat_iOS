//
//  ShoutOutViewController.m
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import "ShoutOutViewController.h"

#import "ShoutOutViewController.h"
#import "Header.h"
#import "SlideObj.h"

@interface ShoutOutViewController()

@end

#define SAMPLE_LINK     @"http://www.radioserversapps.com/wqme/shoutout.mp3"
#define IMAGE_URL       @"http://radioserversapps.com/wqme/shoutout.png"
#define UPLOAD_LINK     @"http://radioserversapps.com/wqme/app/upload.php"

@implementation ShoutOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNib];
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    GoogleTrackingBlock(self, CLASS_VC);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:IMAGE_URL]]];
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playRadio" object:nil];
    
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - Method
- (void)loadNib {
    INIT_INDICATOR;
    isRecording=NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
}

#pragma mark - Button Action Methods

-(IBAction)goBack:(id)sender {
    [self.webview goBack];
}

- (IBAction)goNext:(id)sender {
    [self.webview goForward];
}

- (IBAction)doReload:(id)sender {
    if (!activityIndicator.isAnimating)
        [self.webview reload];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int pageWidth = self.scrSlide.frame.size.width;
    int offset=self.scrSlide.contentOffset.x/pageWidth;
    [self.scrSlide setContentOffset:CGPointMake(offset*pageWidth, 0)];
}

- (IBAction)tapButton:(id)sender {
    UIButton *btn = (UIButton*)sender;
    SlideObj *obj = self.arrSlide[btn.tag];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:obj.slideLinkURL]];
}

- (void)startRecording {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pauseRadio" object:nil];
    [self initRecord];
    
    self.navigationController.navigationBar.userInteractionEnabled=NO;
    NSLog(@"startRecording");
    [self.btRecord setImage:[UIImage imageNamed:@"stopbutton.png"] forState:UIControlStateNormal];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    
    // Start recording
    [audioRecorder record];
    isRecording=YES;
    self.btnPreview.enabled=NO;
    self.btnSample.enabled=NO;
    self.btnSend.enabled=NO;
    NSLog(@"recording");
}

- (void)stopRecording {
    [self.btRecord setImage:[UIImage imageNamed:@"recordbutton.png"] forState:UIControlStateNormal];
    
    NSLog(@"stopRecording");
    isRecording=NO;
    [audioRecorder stop];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    [audioSession setActive:NO error:nil];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    self.btnPreview.enabled = YES;
    self.btnSample.enabled = YES;
    self.btnSend.enabled = YES;
}

- (IBAction)doRecord:(id)sender {
    if (isRecording)
        [self stopRecording];
    else
        [self startRecording];
}

- (IBAction)doPreview:(id)sender {
    if (isRecording)
        [self stopRecording];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.m4a", recDir,@"Record"]];
    NSError *error;
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    [theAudio setDelegate:self];
    [theAudio setNumberOfLoops:0];
    [theAudio play];
}

- (void)playMusic {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pauseRadio" object:nil];
    [theAudio play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"ERROR %@", error.localizedDescription);
}

- (IBAction)doSend:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.m4a", recDir,@"Record"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
        SHOW_INDICATOR(self.navigationController.view);
        
        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableURLRequest *request = [requestSerializer multipartFormRequestWithMethod:@"POST" URLString:UPLOAD_LINK parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"file.wav" mimeType:@"audio/wav"];
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSProgress *progress = nil;
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"THANK YOU!" message:@"Thanks for sharing! Listen to 98.7 The Song and you might hear yourself on the radio!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            HIDE_INDICATOR(YES);
        }];
        
        [uploadTask resume];
        
        // Observe fractionCompleted using KVO
        [progress addObserver:self
                   forKeyPath:@"fractionCompleted"
                      options:NSKeyValueObservingOptionNew
                      context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
    }
}

- (IBAction)doSample:(id)sender {
    if (theAudio.isPlaying)
        return;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pauseRadio" object:nil];
    if (isRecording) {
        [self stopRecording];
    }
    
    NSURL *url = [NSURL URLWithString:SAMPLE_LINK];
    NSData *soundData = [NSData dataWithContentsOfURL:url];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"sound.caf"];
    [soundData writeToFile:filePath atomically:YES];
    
    NSError *error;
    theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:filePath] error:&error];
    if (error) {
        NSLog(@"error %@", error.localizedDescription);
    }
    
    [theAudio setDelegate:self];
    [theAudio setNumberOfLoops:0];
    [theAudio play];
}

- (void)initRecord {
    audioRecorder = nil;
    
    // Init audio with record capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:0];
    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatMPEG4AAC] forKey: AVFormatIDKey];
    [recordSettings setObject:[NSNumber numberWithFloat:16000.0] forKey: AVSampleRateKey];
    [recordSettings setObject:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [recordSettings setObject:[NSNumber numberWithInt: AVAudioQualityMedium] forKey: AVEncoderAudioQualityKey];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *recDir = [paths objectAtIndex:0];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.m4a", recDir, @"Record"]];
    
    NSLog(@"URL: %@",[url path]);
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    audioRecorder.delegate = self;
    audioRecorder.meteringEnabled = YES;
    [audioRecorder prepareToRecord];
}

@end
