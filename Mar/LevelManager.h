//
//  StarManager.h
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"
#import "Level.h"

@interface LevelManager : NSObject
+ (id)sharedInstance;
- (void)updateLevel:(int)lvlID withStars:(int)stars;
- (Box *)boxForID:(int)ID;
- (Level *)levelForID:(int)ID;
- (NSString*)toString;
@property (nonatomic, retain) NSMutableArray *boxes;
@property (nonatomic, assign) int totalStarsUnlocked;
@end
