//
//  LevelData.h
//  Mar
//
//  Created by Benjamin Humphries on 8/15/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelData : NSObject<NSCoding> {
    int level;
    NSMutableArray *ships;
    NSMutableArray *rocks;
    NSMutableArray *lighthouses;
}

+ (instancetype)sharedLevelData;
- (void)save;
+ (NSString*)filePath;

@property(nonatomic, assign) int level;
@property (nonatomic, retain)  NSMutableArray *ships;
@property (nonatomic, retain)  NSMutableArray *rocks;
@property (nonatomic, retain)  NSMutableArray *lighthouses;

@end
