//
//  Queue.m
//  iPhone-Radio
//
//  Created by ben on 27/04/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//

#import "Queue.h"


@implementation Queue

// Initialize a empty mutable array for queue items
// which we can fill
-(id) init
{
	self = [super init];
	{
		mItemArray = [NSMutableArray arrayWithCapacity:0];
	}
	
	return self;
}

// Returns (and removes) the oldest item in the queue
-(id)returnAndRemoveOldest
{
	id anObject = nil;
	
	anObject = [mItemArray lastObject];
	if (anObject)
	{
		[mItemArray removeLastObject];    
	}
	
	return anObject;  
}

// Peak at the next item in the queue
-(id)peak
{
	return [mItemArray lastObject];
}

// Adds the specified item to the queue
-(void)addItem:(id)anItem
{
	[mItemArray insertObject:anItem atIndex:0];
}

-(int)size
{
	return [mItemArray count];
}

-(void)empty
{
	[mItemArray removeAllObjects];
}


@end
