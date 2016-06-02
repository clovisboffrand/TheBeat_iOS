//
//  Packet.m
//  iPhone-Radio
//
//  Created by ben on 27/04/11.
//  Copyright 2011 Ingravitymedia.com. All rights reserved.
//
//

#import "Packet.h"

@implementation Packet
-(AudioStreamPacketDescription)getDescription {
	return audioDescription;
}
-(void)setDescription: (AudioStreamPacketDescription)description {
	audioDescription = description;
}
-(NSData*)getData {
	return audioData;
}

-(void)setData: (NSData*)data {
	audioData = data;
}


@end
