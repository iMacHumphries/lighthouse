//
//  Rock.m
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Rock.h"
#import "PrefixHeader.pch"

@implementation Rock

- (id)initWithImageNamed:(NSString *)name; {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"rocks"];
        [self setSize:CGSizeMake(WIDTH, 50*WIDTH/568)];
        [self setPhysicsBody:[SKPhysicsBody bodyWithTexture:self.texture alphaThreshold:0.5 size:self.size]];
        [self.physicsBody setUsesPreciseCollisionDetection:YES];
        [self.physicsBody setAffectedByGravity:NO];
        [self.physicsBody setCategoryBitMask:ROCKS];
        [self.physicsBody setCollisionBitMask:0];
        [self.physicsBody setContactTestBitMask:SHIP];
        [self setPosition:CGPointMake(WIDTH/2, self.size.height/2)];
      
    }
    return self;
}

@end
