//
//  MainViewController.h
//  radio99
//
//  Created by ben on 10/05/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Header.h"

@interface MainViewController : UIViewController <UIWebViewDelegate, AVAudioSessionDelegate, NSXMLParserDelegate> {
    IBOutlet UIView *volumeSlider;
    IBOutlet UIButton *playpausebutton;
}

@property (nonatomic, strong) AVPlayer *radiosound;
@property (nonatomic, strong) UIButton *playpausebutton;
@property (nonatomic, strong) NSTimer *timer;

@end
