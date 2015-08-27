//
//  LoadingScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LoadingScene.h"
#import "PrefixHeader.pch"
@implementation LoadingScene
@synthesize sceneToShow;

- (void)didMoveToView:(SKView *)view {
    
    float customScale = WIDTH/1024;
    float ballSpeed = 2;
    float titleFadeSpeed = 0.5;
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"loadingBackground.png"];
    [background setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
    [background setSize:CGSizeMake(WIDTH, HEIGHT)];
    [self addChild:background];
    
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"lightBall.png"];
    [ball setAlpha:0.8];
    [ball setScale:customScale];
    [ball setPosition:CGPointMake(-ball.size.width, HEIGHT/2)];
    [self addChild:ball];
    
    SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"title.png"];
    [title setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
    [title setAlpha:0.0];
    [title setScale:customScale];
    [self addChild:title];
    
    SKSpriteNode *logo = [SKSpriteNode spriteNodeWithImageNamed:@"marzSoftware.png"];
    [logo setScale:customScale];
    [logo setPosition:CGPointMake(-background.size.width/2+logo.size.width/2, -background.size.height/2 + logo.size.height/2)];
    [background addChild:logo];
    
    SKAction *wait = [SKAction waitForDuration:1.3];
    SKAction *halfSec = [SKAction waitForDuration:0.5];
    SKAction *moveRight = [SKAction moveTo:CGPointMake(WIDTH + ball.size.width, HEIGHT/2) duration:ballSpeed];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:titleFadeSpeed];
    //SKAction *moveLeft  = [SKAction moveTo:CGPointMake(-ball.size.width, HEIGHT/2) duration:ballSpeed];
    
    SKAction *ballAction = [SKAction sequence:@[halfSec,moveRight,halfSec]];
    SKAction *titleAction = [SKAction sequence:@[wait, fadeIn]];
    
    [title runAction:titleAction];
    [ball runAction:ballAction completion:^{
        [self.view presentScene:sceneToShow transition:[SKTransition doorsOpenVerticalWithDuration:0.5]];
    }];
}

@end
