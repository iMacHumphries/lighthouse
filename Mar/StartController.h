//
//  StartController.h
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static float STAR_SPACING = 5.0f;
static float X_OFFSET = 15.0f;
static float Y_OFFSET = 5.0f;

@interface StartController : SKSpriteNode {
    SKSpriteNode *star;
    SKSpriteNode *emptyStar;
    
    NSMutableArray *stars;
}

- (void)removeStar;
- (int)starCount;

@end
