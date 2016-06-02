//
//  ICTColorRandom.h
//  Roots
//
//  Created by HarryTran on 11/23/14.
//  Copyright (c) 2014 HarryTran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ICTColorRandom : NSObject
{
    @package
    NSMutableDictionary *_randomColors;
}

+ (instancetype) instance;

- (UIColor *) randomColorAtIndex:(NSInteger)index;

@end
