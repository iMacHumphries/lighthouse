//
//  Sub.m
//  Mar
//
//  Created by Benjamin Humphries on 8/20/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Sub.h"
#import "PrefixHeader.pch"

@implementation Sub
@synthesize isUnderWater;

- (id)init {
    if (self = [super initWithImageNamed:@"subYellow.png"]) {
        [self setName:@"subYellow"];
        [self setImageName:@"yellowSub.png"];
        [self setBrokenImageName:@"brokenYellowSub.png"];
        bubbles = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"bubbles" ofType:@"sks"]];
        [bubbles setZPosition:self.zPosition];
        bubbles.position = CGPointMake(0, 0);
        [self hide];
        [self addPhysics];
    }
    return self;
}

- (void)setBubbleTarget:(SKNode *)node {
     [bubbles setTargetNode:node];
}

- (void)hide {
    [self removeWaterEffect];
    isUnderWater = true;
    [bubbles removeFromParent];
    [self addChild:bubbles];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.1 duration:0.5];
    SKAction *switchTexture = [SKAction setTexture:[SKTexture textureWithImage:[UIImage imageWithContentsOfFile:PATH_FOR(@"subShadow.png")]]];
    SKAction *fadein = [SKAction fadeAlphaTo:1 duration:0.1];
    SKAction *sequence = [SKAction sequence:@[fadeOut, switchTexture,fadein]];
    [self runAction:sequence];
}

- (void)reveal {
    [self addWaterEffect];
    isUnderWater = false;
    [self setAlpha:0.1];
    [bubbles removeFromParent];
    SKAction *switchTexture = [SKAction setTexture:[SKTexture textureWithImage:[UIImage imageWithContentsOfFile:PATH_FOR(@"subYellow.png")]]];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:0.2];
    SKAction *sequence = [SKAction sequence:@[switchTexture, fadeIn]];
    [self runAction:sequence];
}

- (void)turnAround {
    [super turnAround];
    SKAction *wait = [SKAction waitForDuration:1];
    [self runAction:[SKAction sequence:@[wait, [SKAction runBlock:^{[self hide];}]]]];
}

- (void)destroy {
    [super destroy];
    [bubbles removeFromParent];
    [self removeAllChildren];
}

@end
