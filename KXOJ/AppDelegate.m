//
//  Radio99AppDelegate.m
//  iRadio
//
//  Created by ben on 10/05/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"

@implementation AppDelegate

#pragma mark - Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (UIDeviceModelIsIphone4()) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    // Battery monitor
    [self registerForBatteryStateChanges];
    
    // Force updates at first time
    [self batteryStateDidChange];
    
    self.tabBarController.tabBar.tintColor = UIColorFromString(TINT_DEF_COLR, 1);
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Battery Status Monitor

- (void)registerForBatteryStateChanges {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    // Start tracking battery state
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryStateDidChange)
                                                 name:UIDeviceBatteryStateDidChangeNotification object:nil];
}

- (void)batteryStateDidChange {
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    //UIDeviceBatteryStateCharging - plugged in, less than 100%
    //UIDeviceBatteryStateFull - plugged in, at 100%
    if ((batteryState == UIDeviceBatteryStateCharging) || (batteryState == UIDeviceBatteryStateFull)) {
        // DON'T let the device go to sleep
        // a trick, you must set it NO before, it's apple's bug in some iOS versions
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
        [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    } else {
        [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    }
}

@end

