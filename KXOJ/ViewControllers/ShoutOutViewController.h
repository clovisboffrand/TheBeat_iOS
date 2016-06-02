//
//  ShoutOutViewController.h
//  WJRS
//
//  Created by admin_user on 3/7/16.
//
//

#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface ShoutOutViewController : UIViewController<UIScrollViewDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIWebViewDelegate>
{
    IBOutlet UIActivityIndicatorView *activityIndicator;
    AVAudioRecorder *audioRecorder;
    int recordEncoding;
    BOOL isRecording;
    enum
    {
        ENC_AAC = 1,
        ENC_ALAC = 2,
        ENC_IMA4 = 3,
        ENC_ILBC = 4,
        ENC_ULAW = 5,
        ENC_PCM = 6,
        ENC_MP3 = 7,
    } encodingTypes;
    AVAudioPlayer *theAudio;
}

@property(nonatomic, strong) IBOutlet UIWebView *webview;
@property(nonatomic, strong) IBOutlet UIView *slideview;
@property(nonatomic, strong) IBOutlet UIScrollView *scrSlide;
@property(nonatomic, strong) NSMutableArray *arrSlide;
@property(nonatomic, strong) IBOutlet UIButton *btRecord;
@property(nonatomic, strong) IBOutlet UIButton *btnPreview;
@property(nonatomic, strong) IBOutlet UIButton *btnSample;
@property(nonatomic, strong) IBOutlet UIButton *btnSend;
@property(nonatomic, strong) IBOutlet UINavigationBar *nav;

- (IBAction)goBack:(id)sender;
- (IBAction)goNext:(id)sender;
- (IBAction)doReload:(id)sender;
- (IBAction)doRecord:(id)sender;
- (IBAction)doPreview:(id)sender;
- (IBAction)doSend:(id)sender;
- (IBAction)doSample:(id)sender;
- (void)startRecording;
- (void)stopRecording;

@end
