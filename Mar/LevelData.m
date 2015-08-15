//
//  LevelData.m
//  Mar
//
//  Created by Benjamin Humphries on 8/15/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelData.h"

@implementation LevelData
@synthesize level,ships,rocks,lighthouses;

static NSString* const LEVEL_KEY = @"level";
static NSString* const SHIPS_KEY = @"ships";
static NSString* const ROCKS_KEY = @"rocks";
static NSString* const LIGHTHOUSES_KEY = @"lighthouses";
// encode
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:level forKey:LEVEL_KEY];
    [encoder encodeObject:ships forKey:SHIPS_KEY];
    [encoder encodeObject:rocks forKey:ROCKS_KEY];
    [encoder encodeObject:lighthouses forKey:LIGHTHOUSES_KEY];
    
}

// decode
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [self init]) {
        level = [decoder decodeIntForKey:LEVEL_KEY];
        ships = [decoder decodeObjectForKey:SHIPS_KEY];
        rocks = [decoder decodeObjectForKey:ROCKS_KEY];
        lighthouses = [decoder decodeObjectForKey:LIGHTHOUSES_KEY];
    }
    return self;
    
}

//save
-(void)save {
    NSError *error;
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[LevelData filePath] atomically:YES];
    [encodedData writeToFile:[LevelData filePath] options:0 error:&error];
    
    if (error){
        NSLog(@"error : %@", [error localizedDescription]);
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:@"/Users/Ben/Desktop/Level1.txt" contents:encodedData attributes:nil];
    
}

// load
+ (instancetype)sharedLevelData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

+(instancetype)loadInstance {
    NSData* decodedData = [NSData dataWithContentsOfFile: [LevelData filePath]];
    if (decodedData) {
        LevelData* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return gameData;
    }
    
    return [[LevelData alloc] init];
    
}

// location
+(NSString*)filePath {
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:@"level"];
    }
    return filePath;
}

@end
