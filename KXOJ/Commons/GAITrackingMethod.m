//
//  GAITrackingMethod.m
//  Roots
//
//  Created by Harry Tran on 3/13/15.
//  Copyright (c) 2015 HarryTran. All rights reserved.
//

#import "GAITrackingMethod.h"
#import "Header.h"


#define kGAITrackingTypeCategoryError           @"INTERNAL_ERROR"
#define kGAITrackingTypeCategoryNetworkError    @"EXTERNAL_ERROR"

BOOL GoogleTrackingBlock(id viewController, NSString *screenName)
{
    if (ALLOW_GOOGLE_TRACKING) {
        if ([viewController isKindOfClass:[UIViewController class]]) {
            id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
            [tracker set:kGAIScreenName value:screenName];
            [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
            return YES;
        }
    }
    return NO;
};

BOOL GoogleTrackingEventBlock(NSString *category, NSString *action, NSString *label, NSNumber *value, id sender)
{
    if (ALLOW_GOOGLE_TRACKING) {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *categoryType = category;
#ifdef DEBUG
        categoryType = [categoryType stringByAppendingString:@"-DEBUG-"];
#else
        categoryType = [categoryType stringByAppendingString:@"-RELEASE-"];
#endif
        categoryType = [categoryType stringByAppendingString:[UIApplication versionBuild]];
        
        NSString *newLabel;
        NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
        if(sender && [sender isKindOfClass:[AFHTTPRequestOperation class]])//tracking if AFHTTPRequestOperation
        {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)sender;
            NSString *strRequest = [operation.request.URL absoluteString];
            id body;
            if(operation.request.HTTPBody)
            {
                body = [NSJSONSerialization JSONObjectWithData:operation.request.HTTPBody options:NSJSONReadingAllowFragments error:nil];
            }
            if(!body)
            {
                body    = [NSNull null];
            }
            id response ;
            if(operation.responseData.length)
            {
                response = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
            }else if(operation.error)
            {
                response = operation.error.userInfo;
                if(!response)
                {
                    response = operation.responseObject;
                }
                if(!response)
                {
                    response = operation.error.description;
                }
            }
            if(!response)
            {
                response = [NSNull null];
            }
            newLabel = [NSString stringWithFormat:@"%@",[@{@"URL":strRequest,
                                                           @"BODY":body,
                                                           @"RESPONSE":response,
                                                           @"DATE":dateString} XMLString]];
        }else
        {
            newLabel = [NSString stringWithFormat:@"%@",[@{@"LOG":label,
                                                           @"DATE":dateString} XMLString]];
        }
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:categoryType
                                                              action:action
                                                               label:newLabel
                                                               value:value] build]];
        return YES;
    }
    return NO;
};


BOOL GoogleTrackingServiceBlock(AFHTTPRequestOperation *operation, NSDictionary *sender)
{
#ifdef DEBUG
    NSLog(@"AFHTTPRequestOperation --> %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
#endif
    if (ALLOW_GOOGLE_TRACKING)
    {
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        NSString *categoryType = @"";
#ifdef DEBUG
        categoryType = [categoryType stringByAppendingString:@"ERROR-DEBUG-"];
#else
        categoryType = [categoryType stringByAppendingString:@"ERROR-RELEASE-"];
#endif
        categoryType = [categoryType stringByAppendingString:[UIApplication versionBuild]];
        
        NSArray  *URLRequests      = [[operation.request.URL absoluteString] componentsSeparatedByString:@"?"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if(URLRequests.firstObject)
        {
            params[@"link"] = URLRequests.firstObject;
        }else{
            params[@"link"] = @"Unknow";
        }
        if(URLRequests.lastObject)
        {
            params[@"param"]= [[URLRequests lastObject] dictionaryQuery];
        }
        if(operation.request.HTTPMethod)
        {
            params[@"method"] = operation.request.HTTPMethod;
        }
        if(operation.request.HTTPBody)
        {
            NSDictionary *body = [NSJSONSerialization JSONObjectWithData:operation.request.HTTPBody options:NSJSONReadingMutableLeaves error:nil];
            if(body)
            {
                params[@"body"] = body;
            }
        }
        if(operation.request.allHTTPHeaderFields)
        {
            params[@"header"]= operation.request.allHTTPHeaderFields;
        }
        
        NSMutableDictionary *response = [NSMutableDictionary dictionary];
        if(operation.responseObject)
        {
            response[@"responseObject"] = operation.responseObject;
        }
        if(operation.error)
        {
            response[@"error"]    = operation.error.userInfo;
        }
        
        NSMutableDictionary *labelData = [NSMutableDictionary dictionary] ;
        UIDevice *device      = [UIDevice currentDevice];
        labelData[@"request"] = params;
        labelData[@"device"]  = @{
                                  @"iOS":device.systemVersion,
                                  @"platformModel":device.platformModel
                                  };
        labelData[@"response"] = response;
        labelData[@"time"]     = [[NSDate date] stringWithFormatter:@"EEEE, dd MMMM yyyy HH:mm:ss ZZZ" withLocale:[NSLocale localeWithLocaleIdentifier:@"en-us"]];
        if(sender && ([sender isKindOfClass:[NSDictionary class]] || [sender isKindOfClass:[NSString class]] || [sender isKindOfClass:[NSArray class]]))
        {
            labelData[@"sender"] = sender;
        }
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:categoryType
                                                              action:params[@"link"]
                                                               label:[labelData XMLString]
                                                               value:@(1)] build]];
        
        return YES;
    }
    return NO;
};
