//
//  FloatingNode.m
//  Mar
//
//  Created by Benjamin Humphries on 8/20/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "FloatingNode.h"
#import "PrefixHeader.pch"

@implementation FloatingNode
@synthesize waitTime, imageName;

static NSString* const WAIT_TIME_KEY = @"waitTime";

- (id)init {
    if (self = [super initWithImageNamed:@"ship.png"]) {
        imageName = @"ship.png";
        self.lightingBitMask = 1;
        
        [self setPosition:[self randomTopPosition]];
        [self setZPosition:10];
        
        [self addPhysics];
    }
    return self;
}

- (void)addPhysics {
    [self setPhysicsBody:[SKPhysicsBody bodyWithTexture:self.texture alphaThreshold:0.5 size:self.size]];
    [self.physicsBody setAffectedByGravity:NO];
    [self.physicsBody setUsesPreciseCollisionDetection:YES];
    [self.physicsBody setCategoryBitMask:SHIP]; // This is a ship
    [self.physicsBody setCollisionBitMask:ROCKS];
    [self.physicsBody setContactTestBitMask:SPOT_LIGHT | ROCKS];    //we test for contact with spotlights and rocks

}

- (CGPoint)randomTopPosition {
    int x = arc4random() % (int)WIDTH;
    return CGPointMake(x, HEIGHT + self.frame.size.height*2);
}

- (void)move {
    direction = CGVectorMake(0, -HEIGHT*2);
    SKAction *move = [SKAction moveBy:direction duration:10];
    SKAction *wait = [SKAction waitForDuration:waitTime];
    [self runAction:[SKAction sequence:@[wait, move]]];
}

- (void)hault {
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
    [self removeAllChildren];
    [self removeFromParent];
}

- (void)explode {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *explode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    [explode setZPosition:10];
    explode.position = self.position;
    [self.parent addChild:explode];
    [self destroy];
}

- (void)addWaterEffect {
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"shipEffect" ofType:@"sks"];
    waterEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    [waterEffect setZPosition:self.zPosition-2];
    waterEffect.position = CGPointMake(0, self.size.height/2);
    [waterEffect setTargetNode:self.parent];
    [self addChild:waterEffect];
}

- (void)removeWaterEffect {
    [waterEffect setParticleBirthRate:0.00];
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
