//
//  GameScene.h
//  Mar
//

//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ShipManager.h"
#import "Spawner.h"
#import "Background.h"
#import "Lighthouse.h"
#import "LightControlRail.h"
#import "StartController.h"
#import "PrefixHeader.pch"

//#define WIDTH 1024
//#define HEIGHT 768

const uint32_t SPOT_LIGHT = 0x1<<0;
const uint32_t ROCKS      = 0x1<<1;
const uint32_t SHIP       = 0x1<<2;


@class ShipManager;
@interface GameScene : SKScene<SpawnerDelegate, SKPhysicsContactDelegate> {
    
    Spawner *spawner;
    ShipManager *shipManager;
    
    Background *background;
    Lighthouse *lighthouse;
    
    SKSpriteNode *rocks;
    
    StartController *starController;

}



@end
