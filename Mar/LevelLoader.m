//
//  LevelLoader.m
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelLoader.h"
#import "LevelData.h"

@implementation LevelLoader

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (LevelManager *)loadLevelsFromRootFile:(NSString *)fileName {
    // 1. Create a new Singleton LevelManager
    LevelManager *manager = [LevelManager sharedInstance];
    
    // 2. Load boxes from root fileName
    NSError *error = nil;
    NSArray  *boxes = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:
                       [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName]
                                                                        error:&error];
    if (error)
        NSLog(@"%@",error.localizedDescription);
    error = nil;
    
    // 3. Iterate over boxes in file creating new Boxes for the LevelManager
    for (int i = 0; i < boxes.count; i++) {
        // - 1 Create Box data
        NSString *boxName = [boxes objectAtIndex:i];
        int boxID = [Box IDFromName:boxName];
        
        // - 2 Iterate over levels in the box.
        NSArray  *levelsInBox = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:
                           [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",fileName,boxName]] error:&error];
        if (error)
            NSLog(@"%@",error.localizedDescription);
        NSMutableArray *levels = [[NSMutableArray alloc] init];

        // - 3 Create Levels to store in the box from files.
        for (int i = 0; i < levelsInBox.count; i++) {
            // - 4 Create Level data
            NSString *levelName = [levelsInBox objectAtIndex:i];
            BOOL isUnlocked = false;
            if ([levelName intValue] == 1)
                isUnlocked = true;
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@/%@",fileName,boxName,levelName] ofType:@""];
            NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            NSData *objectData = [content dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                    options:NSJSONReadingMutableContainers
                                                    error:&error];
            if (error)
                NSLog(@"error %@",[error localizedDescription]);
            
            Level *level = [[Level alloc] initWithID:[levelName intValue] isUnlocked:isUnlocked stars:0 boxID:boxID data:[[LevelData alloc] initWithDictionary:json]];
            [levels addObject:level];
        }
        
        // 4. Create Box with all its levels and glory
        BOOL boxIsUnlocked = false;
        if ([Box IDFromName:boxName] == 1)
            boxIsUnlocked = true;
        Box *box = [[Box alloc] initWithLevels:levels isUnlocked:boxIsUnlocked ID:boxID name:boxName];
        
        // 5. add boxes to the manager
        [manager.boxes addObject:box];
    }
    
    NSLog(@"%@",manager.toString);
    
    // 6. Return that bad boy
    return manager;
}

@end
