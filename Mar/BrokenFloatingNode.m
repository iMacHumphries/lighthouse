//
//  BrokenFloatingNode.m
//  Mar
//
//  Created by Benjamin Humphries on 8/20/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "BrokenFloatingNode.h"
#import "Ship.h"

@implementation BrokenFloatingNode

- (id)initWithNode:(FloatingNode *)node {
    if (self = [super initWithImageNamed:node.brokenImageName]) {
        [self setZPosition:10];
        [self setScale:node.xScale];
        [self setZRotation:node.zRotation];
        [self addSmoke];
    }
    return self;
}

- (void)addSmoke {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"smoke" ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    smoke.position = CGPointMake(self.position.x ,self.position.y);
    [self addChild:smoke];
}

@end
