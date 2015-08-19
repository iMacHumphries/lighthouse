//
//  Slider.m
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Slider.h"

@implementation Slider
@synthesize value;

- (id)initWithSize:(CGSize)size minValue:(float)min maxValue:(float)max {
    if  (self = [super initWithImageNamed:@"timeLine.png"]) {
        [self setName:@"ui"];
        [self setSize:size];
        self.color = [SKColor blackColor];
        self.colorBlendFactor = 1.0;
    
        minValue = min;
        maxValue = max;
        
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        [ball setName:@"ui"];
        [self addChild:ball];
        
    }

    return self;
}

- (void)calculateValue {
    value = ( (ball.position.x + self.size.width/2) * (1/self.size.width) ) * (maxValue - minValue) + minValue;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (isMoving) {
            float x =location.x;
            if (x >= -self.size.width/2 && x <= self.size.width/2) {
                [ball setPosition:CGPointMake(location.x, ball.position.y)];
                [self calculateValue];
            }
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node isEqualToNode:ball]) {
            isMoving = true;
        } else isMoving = false;
    }
}

@end
