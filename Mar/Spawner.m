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
@synthesize delegate,waitTime,timeRange,nodesToSpawn;

static NSString *const WAIT_TIME_KEY = @"waitTime";
static NSString *const TIME_RANGE_KEY = @"timeRange";
static NSString *const NODES_TO_SPAWN_KEY = @"nodesToSpawn";

- (id)init {
    if (self = [super initWithImageNamed:@"tempButton.png"]){
        [self setName:@"spawner"];
        [self setZPosition:11];
        SKSpriteNode *spawn = [SKSpriteNode spriteNodeWithImageNamed:@"spawner.png"];
        [spawn setScale:0.7f];
        [self addChild:spawn];
    }
    return self;
}

- (void)start {
    NSLog(@"start %f",waitTime);
    SKAction *wait = [SKAction waitForDuration:waitTime];
    [self runAction:wait completion:^{
         NSLog(@"called1");
        [self startSpawning];
        NSLog(@"called");
    }];
}

- (void)startSpawning {
    float time = timeRange/(float)nodesToSpawn;
    SKAction *wait = [SKAction waitForDuration:time];
    SKAction *spawn = [SKAction runBlock:^{
        [self timerFinished:[self randomType]];
    }];
    SKAction *sequence = [SKAction sequence:@[wait,spawn]];
    
    [self runAction:[SKAction repeatAction:sequence count:nodesToSpawn]];
}

- (void)stop {
   
}

- (NSUInteger)randomType{
    return arc4random() % shipTypeCount;
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
    }
    return self;
}

- (NSDictionary *)encodeJSON {
    NSDictionary *dictionary = [super encodeJSON];
    [dictionary setValue:[NSNumber numberWithFloat:self.waitTime] forKey:WAIT_TIME_KEY];
    [dictionary setValue:[NSNumber numberWithFloat:self.timeRange] forKey:TIME_RANGE_KEY];
    [dictionary setValue:[NSNumber numberWithInt:self.nodesToSpawn] forKey:NODES_TO_SPAWN_KEY];
    return dictionary;
}

@end
