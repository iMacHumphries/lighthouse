//
//  FloatingNode.h
//  Mar
//
//  Created by Benjamin Humphries on 8/20/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKSpriteNode+JSONEncodable.h"

@interface FloatingNode : SKSpriteNode {
    CGVector direction;
    BOOL hasTurnedAround;
    SKEmitterNode *waterEffect;
}

@property (nonatomic, assign) float waitTime;
@property (nonatomic, retain)  NSString *imageName;
@property (nonatomic, retain) NSString *brokenImageName;

- (void)addPhysics;
- (void)move;
- (void)turnAround;
- (void)destroy;
- (void)explode;
- (BOOL)isOffScreen;
- (void)hault;
- (void)addWaterEffect;
- (void)removeWaterEffect;
- (CGPoint)randomTopPosition;

@end
