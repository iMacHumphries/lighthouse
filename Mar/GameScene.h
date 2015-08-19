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

@class ShipManager;
@interface GameScene : SKScene<SpawnerDelegate, SKPhysicsContactDelegate> {
    
    NodeManager *shipManager;
    NodeManager *lighthouseManager;
    StarController *starController;
    
    Background *background;
    Rock *rocks;
    SKSpriteNode *pause;
    
}

- (id)initWithSize:(CGSize)size andFile:(NSString *)file;

- (void)loadLevelFromFile:(NSString *)fileName;

@end
