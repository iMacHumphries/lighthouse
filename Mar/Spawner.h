//
//  Spawner.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKSpriteNode+JSONEncodable.h"

@protocol SpawnerDelegate
- (void)spawnType:(NSUInteger)type;
@end

typedef enum : NSUInteger {
    NORMAL,
    SUBMARINE,
    
    shipTypeCount
} ShipType;

@interface Spawner : SKSpriteNode {
    int recursionCount;
}

- (void)start;

@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) int nodesToSpawn;
@property (nonatomic, assign) float timeRange;
@property (nonatomic, assign) float waitTime;
@property (nonatomic, assign) BOOL spawnSubs;
@property (nonatomic, assign) BOOL spawnShips;

@end
