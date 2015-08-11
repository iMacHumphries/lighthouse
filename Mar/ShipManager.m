//
//  ShipManager.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "ShipManager.h"

@implementation ShipManager

- (id) init{
    if (self = [super init]) {
        ships = [[NSMutableArray alloc]init];
        shipsToRemove = [[NSMutableArray alloc]init];

    }
    return self;
}

- (void)addShip:(Ship*)ship {
    [ships addObject:ship];
}

- (void)removeShip:(Ship *)targetShip{
    [targetShip destroy];
    [shipsToRemove addObject:targetShip];
}

- (void)update:(CFTimeInterval)currentTime {
    for (Ship *ship in ships)
        if ([ship isOffScreen])
            [self removeShip:ship];
    for (Ship *ship in shipsToRemove)
        [ships removeObject:ship];
    [shipsToRemove removeAllObjects];
}

@end
