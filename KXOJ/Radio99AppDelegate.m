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
    if (UIDeviceModelIsIphone4()) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.tintColor = UIColorFromString(TINT_DEF_COLR, 1);
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

@end

