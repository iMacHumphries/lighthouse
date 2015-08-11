//
//  Background.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Background.h"
#import "GameScene.h"

@implementation Background

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setNormalTexture:[SKTexture textureWithImage:[UIImage imageNamed:name]]];
        [self setSize:CGSizeMake(WIDTH, HEIGHT)];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self setLightingBitMask:1];
        [self setZPosition:0];
    
    }
    return self;
}

@end
