//
//  MyWindow.m
//
//  Created by ben on 10/05/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//
//  Subclass of UIWindow for reliably receiving and forwarding
//  remote control events for audio backgrounding.
//  MainWindow.xib must also be modified to use this subclass.
//

#import "MyWindow.h"


@implementation MyWindow

- (void)makeKeyAndVisible {
    [super makeKeyAndVisible];
    
    //#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
    UIDevice* device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)]) {
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
    }
    //#endif
}

///////////////////////////////////////////////////////////////////////////////
//#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0

- (void)remoteControlReceivedWithEvent:(UIEvent *)theEvent {
    
    if (theEvent.type == UIEventTypeRemoteControl)	{
        switch(theEvent.subtype)		{
            case UIEventSubtypeRemoteControlPlay:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            case UIEventSubtypeRemoteControlPause:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            case UIEventSubtypeRemoteControlStop:
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayPause" object:nil];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NextTrack" object:nil];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PreviousTrack" object:nil];
                break;
            default:
                return;
        }
    }
}

//#endif


@end
