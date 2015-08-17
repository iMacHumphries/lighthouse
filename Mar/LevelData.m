//
//  LevelData.m
//  Mar
//
//  Created by Benjamin Humphries on 8/15/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelData.h"
#import "Ship.h"

@implementation LevelData
@synthesize level,ships,rocks,lighthouses;

static NSString* const LEVEL_KEY = @"level";
static NSString* const SHIPS_KEY = @"ships";
static NSString* const ROCKS_KEY = @"rocks";
static NSString* const LIGHTHOUSES_KEY = @"lighthouses";


- (id)initWithLevel:(int)lvl ships:(NSMutableArray *)shipArray rocks:(NSMutableArray *)rocksArray lighthouses:(NSMutableArray *)lightHouseArray {
    if (self =[super init]) {
        self.level = lvl;
        self.ships = shipArray;
        self.rocks = rocksArray;
        self.lighthouses = lightHouseArray;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.ships = [[NSMutableArray alloc]init];
        self.rocks= [[NSMutableArray alloc] init];
        self.lighthouses = [[NSMutableArray alloc] init];
        
        if ([dictionary objectForKey:LEVEL_KEY])
            self.level = [[dictionary objectForKey:LEVEL_KEY] intValue];
        if ([dictionary objectForKey:SHIPS_KEY]) {
            NSMutableArray *arrayOfShipData = [dictionary objectForKey:SHIPS_KEY];
            NSLog(@"here is the array of ship data %@",arrayOfShipData);
            for (int i=0; i<arrayOfShipData.count;i++) {
                NSLog(@"creating new ship");
                Ship *ship = [[Ship alloc] initWithDictionary:[arrayOfShipData objectAtIndex:i]];
                [ship hault];
                [self.ships addObject:ship];
            }
                
        }
    }
    return self;
}

- (NSString *)encodeJSON {
    NSError *error;
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    [jsonDictionary setObject:[NSNumber numberWithInt:level] forKey:LEVEL_KEY];
    
    NSMutableArray *shipsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < ships.count; i++) {
        [shipsArray addObject:[[ships objectAtIndex:i] encodeJSON]];
    }
    [jsonDictionary setObject:shipsArray forKey:SHIPS_KEY];

    
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    if (error)
        NSLog(@"Error : %@",[error localizedDescription]);
    
    NSLog(@"jsonData as string:\n%@", jsonString);
    return jsonString;
}

@end
