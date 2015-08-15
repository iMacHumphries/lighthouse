//
//  BrokenShip.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "BrokenShip.h"
#import "GameScene.h"

@implementation BrokenShip

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setScale:0.7 * SCALER];
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
