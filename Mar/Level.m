//
//  Level.m
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Level.h"

@implementation Level
@synthesize ID,stars,isUnlocked,boxID,data;

- (id)initWithID:(int)_ID isUnlocked:(BOOL)_unlocked stars:(int)_stars boxID:(int)_boxID data:(LevelData *)_data {
    if (self = [super init]) {
        self.stars = _stars;
        self.ID = _ID;
        self.isUnlocked = _unlocked;
        self.boxID = _boxID;
        self.data = _data;
    }
    return self;
}

- (NSString *)toString {
    NSString *result = @"";
    result = [result stringByAppendingString:[NSString stringWithFormat:@"level:%i\n",ID]];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"stars:%i\n",stars]];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"isUnlocked:%i\n",isUnlocked]];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"boxID:%i\n",boxID]];
    result = [result stringByAppendingString:[NSString stringWithFormat:@"it has data... ok...\n\n"]];
    return result;
}

@end
