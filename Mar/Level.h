//
//  Level.h
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelData.h"

@interface Level : NSObject

- (id)initWithID:(int)_ID isUnlocked:(BOOL)_unlocked stars:(int)_stars boxID:(int)_boxID data:(LevelData *)_data;
- (NSString *)toString;

@property (nonatomic, assign) int stars;
@property (nonatomic, assign) int ID;
@property (nonatomic, assign) BOOL isUnlocked;
@property (nonatomic, assign) int boxID;
@property (nonatomic, retain) LevelData *data;
@end
