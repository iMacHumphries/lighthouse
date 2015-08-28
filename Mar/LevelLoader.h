//
//  LevelLoader.h
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelManager.h"

@interface LevelLoader : NSObject
+ (LevelManager *)loadLevelsFromRootFile:(NSString *)fileName;
@end
