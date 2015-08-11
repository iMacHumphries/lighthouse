//
//  Spawner.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SpawnerDelegate
- (void)spawnType:(NSUInteger)type;
@end

typedef enum : NSUInteger {
    NORMAL,
    
    shipTypeCount
} ShipType;

@interface Spawner : NSObject {
    NSTimer *mainTimer;
    id delegate;
    float timeInterval;
}

- (void)start;
- (void)stop;

@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) float timeInterval;

@end
