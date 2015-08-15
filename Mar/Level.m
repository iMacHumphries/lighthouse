//
//  Level.m
//  Mar
//
//  Created by Benjamin Humphries on 8/13/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Level.h"

@implementation Level
@synthesize number,ships,spawners;

- (id)initWithLevelNumber:(int)_number ships:(NSMutableArray *)_ships spawners:(NSMutableArray *)_spawners {
    if (self = [super init]) {
        self.number = _number;
        self.ships = _ships;
        self.spawners = _spawners;
    }
    return self;
}

- (void)startLevel {
    for (Spawner *spawner in spawners) {
        [spawner start];
    }
}

@end
