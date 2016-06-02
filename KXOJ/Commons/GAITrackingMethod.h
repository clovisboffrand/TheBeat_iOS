//
//  GAITrackingMethod.h
//  Roots
//
//  Created by Harry Tran on 3/13/15.
//  Copyright (c) 2015 HarryTran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAITracker.h>
#import <GoogleAnalytics/GAIFields.h>
#import "XMLConverter.h"
#import "XMLDictionary.h"

@class AFHTTPRequestOperation;

#if TARGET_IPHONE_SIMULATOR
#define ALLOW_GOOGLE_TRACKING 0
#else
#ifdef DEBUG
#define ALLOW_GOOGLE_TRACKING 0
#else
#define ALLOW_GOOGLE_TRACKING 1
#endif
#endif

BOOL GoogleTrackingBlock(id viewController, NSString *screenName) ;

BOOL GoogleTrackingEventBlock(NSString *category, NSString *action, NSString *label, NSNumber *value, id sender) ;
BOOL GoogleTrackingServiceBlock(AFHTTPRequestOperation *operation, NSDictionary *sender);