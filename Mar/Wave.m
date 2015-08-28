//
//  Wave.m
//  Mar
//
//  Created by Benjamin Humphries on 8/19/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Wave.h"
#import "PrefixHeader.pch"

@implementation Wave

- (id)init {
    if (self = [super initWithImageNamed:@"wave0.png"]) {
        [self setSize:CGSizeMake(WIDTH, self.size.height)];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT + self.size.height/2)];
        
        [self animate];
        [self move];
    }
    return self;
}

- (void)move {
    SKAction *move = [SKAction moveTo:CGPointMake(WIDTH/2,-self.size.height) duration:10];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:3];
    SKAction *fadeIn = [SKAction fadeAlphaTo:0.5 duration:2];
    SKAction *fadeSequence = [SKAction repeatActionForever:[SKAction sequence:@[fadeOut,fadeIn]]];
    
    SKAction *group = [SKAction group:@[move,fadeSequence]];
    
    [self runAction:group completion:^{
        [self removeFromParent];
    }];
}

- (void)animate {
    NSMutableArray *waves = [NSMutableArray array];
    SKTextureAtlas *waveAtlas = [SKTextureAtlas atlasNamed:@"wave"];
    
    NSInteger numImages = waveAtlas.textureNames.count;
    for (int i=0; i < numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"wave%i.png", i];
        SKTexture *temp = [waveAtlas textureNamed:textureName];
        [waves addObject:temp];
    }
    
    [self runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:waves
                                      timePerFrame:0.1f
                                            resize:NO
                                           restore:YES]]];
}

- (void)addShader {
    shader = [SKShader shaderWithFileNamed:@"waveShader.fsh"];
    [self loadUniforms];
    self.shader = shader;
}

- (void)loadUniforms {
    shader.uniforms = @[
                        [SKUniform uniformWithName:@"u_dudvMap" texture:[SKTexture textureWithImage:[UIImage imageWithContentsOfFile:PATH_FOR(@"waterDUDV.png")]]],
                        [SKUniform uniformWithName:@"u_myTexture" texture:self.texture],
                        [SKUniform uniformWithName:@"u_moveFactor" float:moveFactor],
                        ];
}


- (void)update:(NSTimeInterval)currentTime {
//    float WAVE_SPEED = .00000001f;
//    moveFactor += WAVE_SPEED * currentTime;
//    moveFactor = fmodf(moveFactor, 1.0f);
//    [self loadUniforms];
}

@end
