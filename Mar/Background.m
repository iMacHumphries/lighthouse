//
//  Background.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Background.h"
#import "GameScene.h"

@implementation Background

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setLightingBitMask:1];
        [self setNormalTexture:[SKTexture textureWithImage:[UIImage imageNamed:name]]];
        
        [self setSize:CGSizeMake(WIDTH, HEIGHT)];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self setZPosition:0];
        
        [self addWaterShader];
    
    }
    return self;
}

- (void)addWaterShader {
   
    shader = [SKShader shaderWithFileNamed:@"waterShader.fsh"];
    [self loadUniforms];
    self.shader = shader;

}

- (void)loadUniforms {
    shader.uniforms = @[
                        [SKUniform uniformWithName:@"u_dudvMap" texture:[SKTexture textureWithImage:[UIImage imageNamed:@"waterDUDV.png"]]],
                        [SKUniform uniformWithName:@"u_myTexture" texture:self.texture],
                        [SKUniform uniformWithName:@"u_moveFactor" float:moveFactor],
                        ];
}


- (void)update:(NSTimeInterval)currentTime {
    float WAVE_SPEED = .00000001f;
    moveFactor += WAVE_SPEED * currentTime;
    moveFactor = fmodf(moveFactor, 1.0f);
   [self loadUniforms];
}

@end
