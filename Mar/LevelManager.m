//
//  StarManager.m
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager
@synthesize boxes,totalStarsUnlocked;

static NSString * const BOX_KEY = @"boxes";

static LevelManager *sharedManager = NULL;
+ (id)sharedInstance {
    if (!sharedManager)
        sharedManager = [[LevelManager alloc] init];
    return sharedManager;
}

- (id)init {
    if (self = [super init]) {
        boxes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)updateLevel:(int)lvlID withStars:(int)stars {
    Level *level = [self levelForID:lvlID];
    if (level.stars < stars) {
        level.stars = stars;
    }
}

- (void)updateStars {
    int starCount = 0;
    for (Box *box in boxes) {
        starCount += [box starsInBox];
    }
    totalStarsUnlocked = starCount;
}

- (Level *)levelForID:(int)ID {
    Level *result = NULL;
    for (Box *box in boxes) {
        for (Level *level in box.levels) {
            if (level.ID == ID) {
                result = level;
                break;
            }
        }
    }
    return result;
}

- (Box *)boxForID:(int)ID {
    Box *result = NULL;
    for (Box *box in boxes) {
        if (box.ID == ID) {
            result = box;
            break;
        }
    }
    return result;
}

- (NSString*)toString {
    NSString *result = @"";
    for (Box *box in boxes) {
         result = [result stringByAppendingString:[box toString]];
    }
    return result;
}

@end
