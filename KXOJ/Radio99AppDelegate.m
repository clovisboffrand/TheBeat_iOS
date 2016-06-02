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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationReloadNavigationBarTabbar object:nil];
}

#pragma mark - Application lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
    
    if (UIDeviceModelIsIphone4())
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadColor:) name:kNotificationReloadNavigationBarTabbar object:nil];
    
    tabBarController.delegate = self;
    tabBarController.tabBar.tintColor = UIColorFromString(TINT_DEF_COLR, 1);
    
    sleep(2);
    
    // Override point for customization after application launch.
    
    /*	// ----------- background -----------
     // Set AudioSession
     NSError *sessionError = nil;
     [[AVAudioSession sharedInstance] setDelegate:self];
     [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
     
     // Pick any one of them
     // 1. Overriding the output audio route
     //UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
     //AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
     
     // 2. Changing the default output audio route
     UInt32 doChangeDefaultRoute = 1;
     AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
     // --------- end Background ----------*/
    
    // Set the tab bar controller as the window's root view controller and display.
    //    UIImageView *any = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,self.window.frame.size.width,self.window.frame.size.height)];
    //	self.xImageView = any;
    //    self.xImageView.alpha = 1.0;
    //    self.xImageView.backgroundColor=[UIColor blackColor];
    //
    //    [self downloadSplash];
    
    //	[self.window addSubview:self.tabBarController.view];
    //	[self.window insertSubview:self.tabBarController.view];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - Notification

- (void)reloadColor:(NSNotification *)notification {
    if (TINT_COLOR) {
        tabBarController.tabBar.tintColor = UIColorFromString(TINT_COLOR, 1);
        for (UINavigationController *navi in self.tabBarController.viewControllers) {
            [navi.navigationBar custom];
        }
    }
}

#pragma mark - UITabBarControllerDelegate methods

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}

#pragma mark - Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}

@end

