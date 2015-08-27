//
//  Spawner.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Spawner.h"
#import "PrefixHeader.pch"

@implementation Spawner
@synthesize delegate,waitTime,timeRange,nodesToSpawn,spawnShips,spawnSubs;

static NSString *const WAIT_TIME_KEY = @"waitTime";
static NSString *const TIME_RANGE_KEY = @"timeRange";
static NSString *const NODES_TO_SPAWN_KEY = @"nodesToSpawn";
static NSString *const SPAWN_SHIP = @"isShip";
static NSString *const SPAWN_SUB = @"isSub";

- (id)init {
    if (self = [super initWithImageNamed:@"tempButton.png"]) {
        [self setName:@"spawner"];
        [self setZPosition:11];
        SKSpriteNode *spawn = [SKSpriteNode spriteNodeWithImageNamed:@"spawner.png"];
        [spawn setScale:0.7f];
        [self addChild:spawn];
        self.spawnSubs = true;
        self.spawnShips = false;
    }
    return self;
}

- (void)start {
    SKAction *wait = [SKAction waitForDuration:waitTime];
    [self runAction:wait completion:^{
        [self startSpawning];
    }];
}

- (void)startSpawning {
    float time = timeRange/(float)nodesToSpawn;
    SKAction *wait = [SKAction waitForDuration:time];
    SKAction *spawn = [SKAction runBlock:^{
        [self timerFinished:[self controlledRandomType]];
    }];
    SKAction *sequence = [SKAction sequence:@[wait,spawn]];
    
    [self runAction:[SKAction repeatAction:sequence count:nodesToSpawn]];
}

- (NSUInteger)randomType{
    return arc4random() % shipTypeCount;
}

- (NSUInteger)controlledRandomType {
    recursionCount++;
    NSUInteger random = arc4random() % shipTypeCount;
    NSLog(@"random %i",random);
    if (recursionCount > 10) return random;
    if (!spawnShips) {
        if (random == NORMAL) {
            NSLog(@"new random because it is a ship %i",random);
            random = [self controlledRandomType];
        }
    }
    if (!spawnSubs) {
        if (random == SUBMARINE) {
            NSLog(@"new random because it is a sub %i",random);
            random = [self controlledRandomType];
        }
    }
    recursionCount = 0;
    return random;
}

- (void)timerFinished:(NSUInteger)responce{
    [delegate spawnType:responce];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        if ([dictionary objectForKey:WAIT_TIME_KEY])
            self.waitTime = [[dictionary objectForKey:WAIT_TIME_KEY] floatValue];
        if ([dictionary objectForKey:TIME_RANGE_KEY])
            self.timeRange = [[dictionary objectForKey:TIME_RANGE_KEY] floatValue];
        if ([dictionary objectForKey:NODES_TO_SPAWN_KEY])
            self.nodesToSpawn = [[dictionary objectForKey:NODES_TO_SPAWN_KEY] intValue];
        if ([dictionary objectForKey:SPAWN_SHIP])
            self.spawnShips = [[dictionary objectForKey:SPAWN_SHIP] boolValue];
        if ([dictionary objectForKey:SPAWN_SUB])
            self.spawnSubs = [[dictionary objectForKey:SPAWN_SUB] boolValue];
    }
    return self;
}

- (NSDictionary *)encodeJSON {
    NSDictionary *dictionary = [super encodeJSON];
    [dictionary setValue:[NSNumber numberWithFloat:self.waitTime] forKey:WAIT_TIME_KEY];
    [dictionary setValue:[NSNumber numberWithFloat:self.timeRange] forKey:TIME_RANGE_KEY];
    [dictionary setValue:[NSNumber numberWithInt:self.nodesToSpawn] forKey:NODES_TO_SPAWN_KEY];
    [dictionary setValue:[NSNumber numberWithBool:self.spawnShips] forKey:SPAWN_SHIP];
    [dictionary setValue:[NSNumber numberWithBool:self.spawnSubs] forKey:SPAWN_SUB];
    
    return dictionary;
}

@end
