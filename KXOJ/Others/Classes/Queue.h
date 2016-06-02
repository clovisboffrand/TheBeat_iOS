//
//  Queue.h
//  iPhone-Radio
//
//  Created by ben on 27/04/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Queue : NSObject {
	NSMutableArray *mItemArray;
}

-(id)returnAndRemoveOldest;
-(void)addItem:(id)anItem;
-(int)size;
-(void)empty;
-(id)peak;

@end
