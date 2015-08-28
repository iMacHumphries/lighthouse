//
//  LevelSelectScene.h
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MenuScene.h"
#import "Box.h"

@interface LevelSelectScene : SKScene {
    Box *currentBox;
}
- (id)initWithSize:(CGSize)size box:(Box *)box;
@end
