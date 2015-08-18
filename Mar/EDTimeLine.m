//
//  EDTimeLine.m
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDTimeLine.h"
#import "PrefixHeader.pch"
#import "Ship.h"

@implementation EDTimeLine

const float START_TIME = 0;
const float MAX_TIME = 120;

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"ui"];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/4)];
        [self setSize:CGSizeMake(WIDTH, self.size.height)];
        
        SKLabelNode *min = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%i",(int)START_TIME]];
        [min setPosition:CGPointMake(-WIDTH/2 + min.frame.size.width, 0)];
        [min setName:@"ui"];
        [self addChild:min];
        
        SKLabelNode *max = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%i",(int)MAX_TIME]];
        [max setPosition:CGPointMake(WIDTH/2- max.frame.size.width, 0)];
        [max setName:@"ui"];
        [self addChild:max];
        
    }
    return self;
}

- (void)addNodeOnTimeLine:(SKNode *)node {
    SKNode *copy = [node copy];
    [copy setPosition:CGPointMake(0, 0)];
    [copy setName:@"copy"];
    [self addChild:copy];
    if ([copy isKindOfClass:[Ship class]]) {
        Ship *ship = (Ship *)copy;
        [ship hault];
    }
   
    
}


@end
