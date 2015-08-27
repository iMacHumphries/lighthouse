//
//  Fog.h
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PrefixHeader.pch"
#import "SKSpriteNode+JSONEncodable.h"

@interface Fog : SKSpriteNode

- (void)setStrength:(float)strength;
- (void)start;
- (void)editorFog;
- (void)setTargetNode:(SKNode *)node;

@property (nonatomic, assign) float waitTime;
@property (nonatomic, assign) float lifeTime;
@property (nonatomic, retain) SKEmitterNode *emitter;

@end
