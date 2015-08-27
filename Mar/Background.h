//
//  Background.h
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NodeManager.h"

@interface Background : SKSpriteNode {
    SKShader *shader;
    float moveFactor;
    NodeManager *waveManager;
    
}
- (void)update:(NSTimeInterval)currentTime;
- (void)addWaves;
@end
