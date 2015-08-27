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

- (id)init {
    if (self = [super initWithImageNamed:@"rock.png"]) {
        [self setName:@"rock"];
        [self addPhysics];
    }
    return self;
}

- (void)addPhysics {
    [self setPhysicsBody:[SKPhysicsBody bodyWithTexture:self.texture alphaThreshold:0.5 size:self.size]];
    [self.physicsBody setDynamic:NO];
    [self.physicsBody setUsesPreciseCollisionDetection:YES];
    [self.physicsBody setAffectedByGravity:NO];
    [self.physicsBody setCategoryBitMask:ROCKS];
    [self.physicsBody setCollisionBitMask:0];
    [self.physicsBody setContactTestBitMask:0];
}

@end
