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
#import "StartController.h"
#import "Rock.h"
#import "PrefixHeader.pch"
#import "LevelData.h"

@class ShipManager;
@interface GameScene : SKScene<SpawnerDelegate, SKPhysicsContactDelegate> {
    
    //Spawner *spawner;
    NodeManager *shipManager;
    NodeManager *lighthouseManager;
    
    Background *background;
    
    Rock *rocks;
    
    StartController *starController;

}

- (id)initWithSize:(CGSize)size andFile:(NSString *)file;

- (void)loadLevelFromFile:(NSString *)fileName;

@end
