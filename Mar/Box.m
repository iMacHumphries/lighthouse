//
//  Box.m
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Box.h"

@implementation Box
@synthesize levels,isUnlocked,ID,name;

- (id)initWithLevels:(NSMutableArray *)_levels isUnlocked:(BOOL)_unlocked ID:(int)_ID name:(NSString *)_name {
    if (self = [super init]) {
        self.levels = _levels;
        self.isUnlocked = _unlocked;
        self.ID = _ID;
        self.name = _name;
    }
    return self;
}

- (int)starsInBox {
    int starCount = 0;
    for (Level *level in levels) {
        starCount += level.stars;
    }
    return starCount;
}

- (Level*)levelWithID:(int)_ID {
    Level *result = NULL;
    for (Level *level in levels) {
        if (level.ID == _ID) {
            result = level;
            break;
        }
    }
    return result;
}

+ (int)IDFromName:(NSString *)name {
    // box#
    return [[name substringFromIndex:3] intValue];
}

- (NSString *)toString {
    NSString *result = @"";
    for (Level *level in levels) {
        result = [result stringByAppendingString:[level toString]];
    }
    return result;
}

@end
