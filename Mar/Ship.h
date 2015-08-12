//
//  Ship.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface Ship : SKSpriteNode {
    CGVector direction;
    BOOL hasTurnedAround;
}

- (void)turnAround;
- (void)destroy;
- (BOOL)isOffScreen;

@end
