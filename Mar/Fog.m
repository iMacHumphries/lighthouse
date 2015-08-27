//
//  Fog.m
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Fog.h"

@implementation Fog
@synthesize emitter, waitTime, lifeTime;

static NSString * const STRENGTH_KEY = @"strength";
static NSString * const WAIT_KEY = @"wait";
static NSString * const LIFE_TIME_KEY = @"lifeTime";

- (id)init {
    if (self = [super initWithImageNamed:@"tempButton.png"]) {
        [self setName:@"fog"];
        NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"fog" ofType:@"sks"];
        emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        [emitter setZPosition:5];
        
        SKSpriteNode *fogNode = [SKSpriteNode spriteNodeWithImageNamed:@"fog.png"];
        [fogNode setName:UI];
        [self addChild:fogNode];
    }
    return self;
}

- (void)setTargetNode:(SKNode *)node {
    [emitter setTargetNode:node];
}

- (void)editorFog {
    [self addChild:emitter];
}

- (void)start {
    SKAction *wait = [SKAction waitForDuration:waitTime];
    SKAction *addFog = [SKAction runBlock:^{
        [self addChild:emitter];
    }];
    SKAction *live = [SKAction waitForDuration:lifeTime];
    SKAction *remove = [SKAction removeFromParent];
    
    [self runAction:[SKAction sequence:@[wait, addFog, live, remove]]];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        if ([dictionary objectForKey:STRENGTH_KEY]) {
            [self setStrength:[[dictionary objectForKey:STRENGTH_KEY] floatValue]];
        }
        if ([dictionary objectForKey:WAIT_KEY]) {
            waitTime = [[dictionary objectForKey:WAIT_KEY] floatValue];
        }
        if ([dictionary objectForKey:LIFE_TIME_KEY]) {
            lifeTime = [[dictionary objectForKey:LIFE_TIME_KEY] floatValue];
        }
    }
    return self;
}

- (NSDictionary *)encodeJSON {
    NSDictionary *dictionary = [super encodeJSON];
    [dictionary setValue:[NSNumber numberWithFloat:emitter.particleBirthRate] forKey:STRENGTH_KEY];
    [dictionary setValue:[NSNumber numberWithFloat:self.waitTime] forKey:WAIT_KEY];
    [dictionary setValue:[NSNumber numberWithFloat:self.lifeTime] forKey:LIFE_TIME_KEY];
    [dictionary setValue:@"fog" forKey:@"name"];
    [dictionary setValue:@"fog.png" forKey:@"image"];
    return dictionary;
}

- (void)setStrength:(float)strength {
    [emitter setParticleBirthRate:strength];
}

@end
