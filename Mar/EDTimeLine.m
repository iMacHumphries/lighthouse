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
const float MAX_TIME = 60;

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
        
        timeNodes = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)addNodeOnTimeLine:(SKNode *)node {
    [self addNodeOnTimeLine:node withTime:MAX_TIME/2];
}

- (void)addNodeOnTimeLine:(SKNode *)node withTime:(float)time {
    SKNode *copy = [node copy];
    [copy setPosition:[self getPositionForTime:time]];
    [copy setName:@"onTimeLine"];
    [copy setScale:0.5];
    [self.parent addChild:copy];
    if ([copy isKindOfClass:[Ship class]]) {
        Ship *ship = (Ship *)copy;
        [ship hault];
    }
    [timeNodes addObject:node];
}

- (float)getTimeForNode:(SKNode *)node {
    SKNode *timeNode = [self getTwinNodeOnTimeLine:node];
    if (!timeNode) return -1;
    return timeNode.position.x*(1/WIDTH) * MAX_TIME;
}

- (SKNode *)getTwinNodeOnTimeLine:(SKNode *)node {
    SKLabelNode *nodeLabel = (SKLabelNode *)[node.children objectAtIndex:0];
    
    for (SKNode *timeNode in timeNodes) {
        for (SKNode *child in timeNode.children) {
            if ([child isKindOfClass:[SKLabelNode class]]) {
                SKLabelNode *timeLabel = (SKLabelNode *)child;
                if ([nodeLabel.text isEqualToString:timeLabel.text]) {
                    return timeNode;
                }
            }
        }
    }
    return NULL;
}

- (CGPoint)getPositionForTime:(float)time {
    return CGPointMake(time*(1/MAX_TIME) * WIDTH, self.position.y);
}

@end
