//
//  BottomRocks.m
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "BottomRocks.h"
#import "PrefixHeader.pch"

@implementation BottomRocks

- (id)init {
    if (self = [super initWithImageNamed:@"rocks.png"]) {
        [self setName:@"rocks"];
        [self setSize:CGSizeMake(WIDTH, 50*WIDTH/568)];
        [self setPosition:CGPointMake(WIDTH/2, self.size.height/2)];
        [self addPhysics];
    }
    return self;
}


@end
