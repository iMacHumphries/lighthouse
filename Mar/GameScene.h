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
#import "TouchBox.h"
#import "LightControlRail.h"

#define WIDTH 1024
#define HEIGHT 768
#define convertToScreenSpace(f) ((f / WIDTH * [[UIScreen mainScreen] bounds].size.width))

const uint32_t SPOT_LIGHT = 0x1<<0;
const uint32_t SHIP       = 0x1<<1;


@class ShipManager;
@interface GameScene : SKScene<SpawnerDelegate, SKPhysicsContactDelegate> {
    float width;
    float height;
    
    Spawner *spawner;
    ShipManager *shipManager;
    
    Background *background;
    Lighthouse *lighthouse;
    TouchBox *touchBox;
    LightControlRail *lightSlider;
}



@end
