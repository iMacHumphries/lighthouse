//
//  Ship.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Ship.h"
#import "PrefixHeader.pch"

@implementation Ship

- (id)init {
    if (self = [super init]) {
        self.imageName = @"ship.png";
        self.brokenImageName = @"brokenShip.png";
        [self setName:@"ship"];
        [self setTexture:[SKTexture textureWithImage:[UIImage imageWithContentsOfFile:PATH_FOR(@"ship.png")]]];
    }
    return self;
}

- (void)move {
    [super move];
    [self addWaterEffect];
}
@end
