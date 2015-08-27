//
//  LevelData.m
//  Mar
//
//  Created by Benjamin Humphries on 8/15/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelData.h"
#import "Ship.h"
#import "Lighthouse.h"
#import "Spawner.h"
#import "Rock.h"
#import "Sub.h"
#import "Fog.h"

@implementation LevelData
@synthesize level,ships,rocks,lighthouses,spawners, subs, fogs;

static NSString* const LEVEL_KEY = @"level";
static NSString* const SHIPS_KEY = @"ships";
static NSString* const ROCKS_KEY = @"rocks";
static NSString* const LIGHTHOUSES_KEY = @"lighthouses";
static NSString* const SPAWNERS_KEY = @"spawners";
static NSString* const SUBS_KEY = @"subs";
static NSString* const FOGS_KEY = @"fogs";

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.ships = [[NSMutableArray alloc]init];
        self.rocks= [[NSMutableArray alloc] init];
        self.lighthouses = [[NSMutableArray alloc] init];
        self.spawners = [[NSMutableArray alloc] init];
        self.subs = [[NSMutableArray alloc] init];
        self.fogs = [[NSMutableArray alloc] init];
        
        //level
        if ([dictionary objectForKey:LEVEL_KEY])
            self.level = [[dictionary objectForKey:LEVEL_KEY] intValue];
        
        //ships
        if ([dictionary objectForKey:SHIPS_KEY]) {
            NSMutableArray *arrayOfShipData = [dictionary objectForKey:SHIPS_KEY];
            for (int i=0; i<arrayOfShipData.count;i++) {
                Ship *ship = [[Ship alloc] initWithDictionary:[arrayOfShipData objectAtIndex:i]];
                [self.ships addObject:ship];
            }
        }
        
        //lighthouses
        if ([dictionary objectForKey:LIGHTHOUSES_KEY]) {
            NSMutableArray *arrayOfLightData = [dictionary objectForKey:LIGHTHOUSES_KEY];
            for (int i=0; i<arrayOfLightData.count;i++) {
                Lighthouse *lighthouse = [[Lighthouse alloc] initWithDictionary:[arrayOfLightData objectAtIndex:i]];
                [self.lighthouses addObject:lighthouse];
            }
        }
        
        //spawners
        if ([dictionary objectForKey:SPAWNERS_KEY]) {
            NSMutableArray *spawnersArray = [dictionary objectForKey:SPAWNERS_KEY];
            for (int i=0; i<spawnersArray.count;i++) {
                Spawner *spawner = [[Spawner alloc] initWithDictionary:[spawnersArray objectAtIndex:i]];
                [self.spawners addObject:spawner];
            }
        }
        
        //rocks
        if ([dictionary objectForKey:ROCKS_KEY]) {
            NSMutableArray *rocksArray = [dictionary objectForKey:ROCKS_KEY];
            for (int i=0; i<rocksArray.count;i++) {
                Rock *rock = [[Rock alloc] initWithDictionary:[rocksArray objectAtIndex:i]];
                [self.rocks addObject:rock];
            }
        }
        
        //subs
        if ([dictionary objectForKey:SUBS_KEY]) {
            NSMutableArray *subsArray = [dictionary objectForKey:SUBS_KEY];
            for (int i=0; i<subsArray.count;i++) {
                Sub *sub = [[Sub alloc] initWithDictionary:[subsArray objectAtIndex:i]];
                [self.subs addObject:sub];
            }
        }
        
        //fogs
        if ([dictionary objectForKey:FOGS_KEY]) {
            NSMutableArray *fogsArray = [dictionary objectForKey:FOGS_KEY];
            for (int i=0; i<fogsArray.count;i++) {
                Fog *fog = [[Fog alloc] initWithDictionary:[fogsArray objectAtIndex:i]];
                [self.fogs addObject:fog];
            }
        }
        
    }
    return self;
}

- (NSString *)encodeJSON {
    NSError *error;
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    
    // level
    [jsonDictionary setObject:[NSNumber numberWithInt:level] forKey:LEVEL_KEY];
    
    //ships
    NSMutableArray *shipsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < ships.count; i++) {
        [shipsArray addObject:[[ships objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:shipsArray forKey:SHIPS_KEY];
    
    //lighthouses
    NSMutableArray *lightsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < lighthouses.count; i++) {
        [lightsArray addObject:[[lighthouses objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:lightsArray forKey:LIGHTHOUSES_KEY];
    
    //spawners
    NSMutableArray *spawnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < spawners.count; i++) {
        [spawnArray addObject:[[spawners objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:spawnArray forKey:SPAWNERS_KEY];
    
    //rocks
    NSMutableArray *rockArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < rocks.count; i++) {
        [rockArray addObject:[[rocks objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:rockArray forKey:ROCKS_KEY];

    //subs
    NSMutableArray *subArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < subs.count; i++) {
        [subArray addObject:[[subs objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:subArray forKey:SUBS_KEY];
    
    //fogs
    NSMutableArray *fogsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < fogs.count; i++) {
        [fogsArray addObject:[[fogs objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:fogsArray forKey:FOGS_KEY];
    
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    if (error)
        NSLog(@"Error : %@",[error localizedDescription]);
    
    NSLog(@"jsonData as string:\n%@", jsonString);
    return jsonString;
}

@end
