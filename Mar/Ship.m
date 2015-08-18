//
//  Ship.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Ship.h"

@implementation Ship
@synthesize waitTime;

 static NSString* const WAIT_TIME_KEY = @"waitTime";

- (id)init {
    if (self = [super initWithImageNamed:@"ship.png"]) {
        imageName = @"ship.png";
        [self setName:@"ship"];
        [self setScale:0.7f * SCALER];
        self.lightingBitMask = 1;
        //self.shadowedBitMask = 1;
        //self.shadowCastBitMask = 1;
        
        [self setPosition:[self randomTopPosition]];
        [self setZPosition:2];
        
        [self setPhysicsBody:[SKPhysicsBody bodyWithTexture:self.texture alphaThreshold:0.5 size:self.size]];
        [self.physicsBody setAffectedByGravity:NO];
        [self.physicsBody setUsesPreciseCollisionDetection:YES];
               
        [self.physicsBody setCategoryBitMask:SHIP]; // This is a ship
        [self.physicsBody setCollisionBitMask:0];
        [self.physicsBody setContactTestBitMask:SPOT_LIGHT | ROCKS];    //we test for contact with spotlights and rocks
       
        //[self move];
    }
    return self;
}

- (CGPoint)randomTopPosition{
    int x = arc4random() % (int)WIDTH;
    return CGPointMake(x, HEIGHT + self.frame.size.height*2);
}

- (void)move {
    NSLog(@"move!");
    direction = CGVectorMake(0, -HEIGHT*2);
    SKAction *move = [SKAction moveBy:direction duration:10];
    SKAction *wait = [SKAction waitForDuration:waitTime];
    [self runAction:[SKAction sequence:@[wait, move]]];
}

- (void)hault {
    NSLog(@"hault!");

    [self removeAllActions];
}

- (void)turnAround {
    if (!hasTurnedAround) {
        hasTurnedAround = true;
        [self removeAllActions];
        SKAction *turn = [SKAction rotateByAngle:M_PI duration:0.4];
        direction = CGVectorMake(-direction.dx, -direction.dy);
        SKAction *move = [SKAction moveBy:direction duration:10];
        [self runAction:[SKAction sequence:@[turn, move]]];
        
    }
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

- (void)explode {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *explode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    [explode setZPosition:10];
    explode.position = CGPointMake(self.position.x ,self.position.y);
    [self.parent addChild:explode];
    SKAction *rem = [SKAction removeFromParent];
    [self runAction:rem];
}

- (NSDictionary *)encodeJSON {
    NSDictionary * dictionary = [super encodeJSON];
    [dictionary setValue:[NSNumber numberWithFloat:self.waitTime] forKey:WAIT_TIME_KEY];
    return dictionary;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        
        if ([dictionary objectForKey:WAIT_TIME_KEY])
            self.waitTime = [[dictionary objectForKey:WAIT_TIME_KEY] floatValue];
      
    }
    return self;
}

@end
