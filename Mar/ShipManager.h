//
//  ShipManager.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ship.h"

@class Ship;
@interface ShipManager : NSObject {
    NSMutableArray *ships;
    NSMutableArray *shipsToRemove;
    
}
- (void)addShip:(Ship*)ship;
- (void)update:(CFTimeInterval)currentTime;
@end
