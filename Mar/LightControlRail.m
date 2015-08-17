//
//  LightControlRail.m
//  Mar
//
//  Created by Benjamin Humphries on 8/12/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LightControlRail.h"


@implementation LightControlRail

- (id)initWithLightHouse:(Lighthouse *)lh {
    if (self = [super init]) {
        lighthouse = lh;
        track = [SKSpriteNode spriteNodeWithImageNamed:@"blackTrack.png"];
        
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
       
        [self addChild:track];
        [track addChild:ball];
  
        radius = track.size.width/2;
        minRadius = radius - 1;
        NSLog(@"radius %f",radius);
        
       // [self setPosition:CGPointMake(WIDTH/2, 0)];
    
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:track];
        CGPoint newLocation = location;
        
        float distance = [self distance:location :CGPointMake(0, 0)];
        if (distance > radius) {
            float x = location.x * radius / distance + 0;
            float y = location.y * radius / distance + 0;
            newLocation = CGPointMake(x, y);
        } else if (distance < minRadius) {
            float x = location.x * minRadius / distance + 0;
            float y = location.y * minRadius / distance + 0;
            newLocation = CGPointMake(x, y);
        }
        
        [ball setPosition:newLocation];
        [[lighthouse spotLight] rotateToAngle:[self calculateRotation:newLocation.x]];
        
    }
}

- (float)calculateRotation:(float)x {
     return -(x/radius) * 90.0f;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (float)distance:(CGPoint)p1 :(CGPoint)p2 {
    return sqrtf(powf(p2.x- p1.x, 2) + powf(p2.y - p1.y, 2));
}

@end
