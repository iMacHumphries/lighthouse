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
        [self setSize:size];
        minValue = min;
        maxValue = max;
        
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        [self addChild:ball];
        
    }
    return self;
}

- (void)calculateValue {
    value = ( (ball.position.x + self.size.width/2) * (1/self.size.width) ) * (maxValue - minValue) + minValue;
    NSLog(@"value = %f",value);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (isMoving) {
            [ball setPosition:CGPointMake(location.x, ball.position.y)];
            [self calculateValue];
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
