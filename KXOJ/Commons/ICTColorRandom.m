//
//  ICTColorRandom.m
//  Roots
//
//  Created by HarryTran on 11/23/14.
//  Copyright (c) 2014 HarryTran. All rights reserved.
//

#import "ICTColorRandom.h"
#import "Header.h"

@implementation ICTColorRandom

+ (instancetype) instance
{
    return [[ICTColorRandom alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        _randomColors = [NSMutableDictionary dictionary];
    }
    return self;
}

- (UIColor *) randomColorAtIndex:(NSInteger)index
{
    NSString *key = [@(index) stringValue];
    if (!_randomColors[key]) {
        UIColor *color = [UIColor randomColor];
        _randomColors[[@(index) stringValue]] = color;
    }
    return _randomColors[key];
}

@end
