//
//  Box.h
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"

@interface Box : NSObject {
    int starsRequired;
}

- (id)initWithLevels:(NSMutableArray *)_levels isUnlocked:(BOOL)_unlocked ID:(int)_ID name:(NSString *)_name;

+ (int)IDFromName:(NSString *)name;
- (int)starsInBox;
- (Level*) levelWithID:(int)ID;
- (NSString *)toString;
@property (nonatomic, retain) NSMutableArray *levels;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) BOOL isUnlocked;
@property (nonatomic, assign) int ID;

@end
