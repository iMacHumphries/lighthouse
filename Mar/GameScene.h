//
//  GameScene.h
//  Mar
//

//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NodeManager.h"
#import "Spawner.h"
#import "Background.h"
#import "Lighthouse.h"
#import "LightControlRail.h"
#import "StarController.h"
#import "Rock.h"
#import "PrefixHeader.pch"
#import "LevelData.h"
#import "PauseMenu.h"
#import "Level.h"
#import "Box.h"

@class ShipManager;
@interface GameScene : SKScene<SpawnerDelegate, SKPhysicsContactDelegate> {
    
    NodeManager *shipManager;
    NodeManager *lighthouseManager;
    StarController *starController;
    
    Background *background;
    SKSpriteNode *pause;
    PauseMenu *pauseMenu;
    BOOL isPaused;
    
    Level *currentLevel;
    Box *currentBox;
    
}

- (id)initWithSize:(CGSize)size level:(Level *)_level;
- (void)togglePause;

- (void)moveToLevelSelection;

@end
