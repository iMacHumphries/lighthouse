//
//  Level.h
//  Mar
//
//  Created by Benjamin Humphries on 8/13/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Spawner.h"

@interface Level : NSObject {
    int number;
    NSMutableArray *ships;
    NSMutableArray *spawners;
}

@property (nonatomic, assign) int number;
@property (nonatomic, retain) NSMutableArray *ships;
@property (nonatomic, retain) NSMutableArray *spawners;

@end
