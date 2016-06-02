//
//  radio99AppDelegate.m
//  iRadio
//
//  Created by ben on 10/05/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import "Radio99AppDelegate.h"
#import "Header.h"

@implementation Radio99AppDelegate

@synthesize window;
@synthesize tabBarController;

#pragma mark - Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (ALLOW_GOOGLE_TRACKING)
    {
        //Google Analytics
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        
        // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
        [GAI sharedInstance].dispatchInterval = 20;
        
        // Optional: set Logger to VERBOSE for debug information.
        [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelInfo];
        
        // Initialize tracker.
        [[GAI sharedInstance] trackerWithTrackingId:kGoogle_Tracking_ID];
        
        // End
    }
    
    if (UIDeviceModelIsIphone4()) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    tabBarController.delegate = self;
    tabBarController.tabBar.tintColor = UIColorFromString(TINT_DEF_COLR, 1);
    
    sleep(2);
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

@end

