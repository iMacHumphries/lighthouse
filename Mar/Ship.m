//
//  Ship.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Ship.h"

@implementation Ship {

}

- (id)init {
    if (self = [super initWithImageNamed:@"ship.png"]) {
        self.lightingBitMask = 1;
        //self.shadowedBitMask = 1;
        //self.shadowCastBitMask = 1;
        
        [self setPosition:[self randomTopPosition]];
        self.zPosition = 1;
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithTexture:self.texture alphaThreshold:0.5 size:self.size]];
        [self.physicsBody setAffectedByGravity:NO];
        [self.physicsBody setUsesPreciseCollisionDetection:YES];
        [self.physicsBody setDynamic:NO];
        
        [self.physicsBody setCategoryBitMask:SHIP]; // This is a ship
        //[self.physicsBody setCollisionBitMask:SPOT_LIGHT];
        [self.physicsBody setContactTestBitMask:SPOT_LIGHT];    //we test for contact with spotlights
       
        
        [self move];
    }
    return self;
}

- (CGPoint)randomTopPosition{
    int x = arc4random() % (int)WIDTH;
    return CGPointMake(x, HEIGHT + self.frame.size.height*2);
}

- (void)move {
    direction = CGVectorMake(0, -HEIGHT*2);
    [self runAction:[SKAction moveBy:direction duration:10]];
}

- (void)turnAround {
    [self removeAllActions];
    SKAction *turn = [SKAction rotateByAngle:M_PI duration:0.4];
    direction = CGVectorMake(-direction.dx, -direction.dy);
    SKAction *move = [SKAction moveBy:direction duration:10];
    [self runAction:[SKAction sequence:@[turn, move]]];
}

- (BOOL)isOffScreen {
    float offset = 5;
    return (self.position.x > WIDTH + offset || self.position.x < 0 - offset ||
            self.position.y > HEIGHT + offset + self.frame.size.height*2 || self.position.y < 0 - offset);
}

- (void)destroy {
    [self removeAllActions];
    [self removeFromParent];
}

@end
