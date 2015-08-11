//
//  TouchBox.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "TouchBox.h"
#import "GameScene.h"

@implementation TouchBox
@synthesize rotation;

- (id)initWithLighthouse:(Lighthouse *)_lighthouse {
    if (self = [super init]){
        lighthouse = _lighthouse;
        //[self setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"beam.png"]]];
        [self setSize:CGSizeMake(WIDTH, HEIGHT/3)];
        [self setPosition:CGPointMake(self.size.width/2, self.size.height/2)];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self.scene];
        
        if ([self containsPoint:location]){
            [self calculateRotation:location.x];
            [[lighthouse spotLight] rotateToAngle:rotation];
        }
    }
}

- (void)calculateRotation:(float)x {
    rotation = (x/WIDTH) * 180.0f;
}

@end
