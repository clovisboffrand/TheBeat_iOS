//
//  Packet.h
//  iPhone-Radio
//
//  Created by ben on 27/04/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//


#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>

@interface Packet : NSObject {
	AudioStreamPacketDescription audioDescription;
	NSData						 *audioData;
}

-(AudioStreamPacketDescription)getDescription;
-(void)setDescription: (AudioStreamPacketDescription)description;
-(NSData*)getData;
-(void)setData: (NSData*)data;

@end
