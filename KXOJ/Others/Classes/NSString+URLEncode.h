//
//  NSString+URLEncode.h
//  NAF
//
//  Created by Tom on 6/18/14.
//  Copyright (c) 2014 Phuc Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)
- (NSString *)stringForHTTPRequest;

@end
