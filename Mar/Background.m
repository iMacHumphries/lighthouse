//
//  Background.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Background.h"
#import "PrefixHeader.pch"
#import "Wave.h"

@implementation Background

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"background"];
        [self setLightingBitMask:1];
        [self setNormalTexture:[SKTexture textureWithImage:[UIImage imageWithContentsOfFile:PATH_FOR(name)]]];
        
        [self setSize:CGSizeMake(WIDTH, HEIGHT)];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self setZPosition:-11];
        
        waveManager = [[NodeManager alloc] init];
        //[self addWaves];
    }
    return self;
}

- (void)addWaves {
    SKAction *wait = [SKAction waitForDuration:2.3];
    SKAction *addWave = [SKAction runBlock:^{
        Wave *wave = [[Wave alloc] init];
        [self.parent addChild:wave];
        [waveManager addNode:wave];
    }];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[wait,addWave]]]];
}


- (void)update:(NSTimeInterval)currentTime {
    [waveManager update:currentTime];
}

@end
