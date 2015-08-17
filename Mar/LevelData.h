//
//  LevelData.h
//  Mar
//
//  Created by Benjamin Humphries on 8/15/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelData : NSObject {
    int level;
    NSMutableArray *ships;
    NSMutableArray *rocks;
    NSMutableArray *lighthouses;
}

- (NSString *)encodeJSON;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@property(nonatomic, assign) int level;
@property (nonatomic, retain)  NSMutableArray *ships;
@property (nonatomic, retain)  NSMutableArray *rocks;
@property (nonatomic, retain)  NSMutableArray *lighthouses;

@end
