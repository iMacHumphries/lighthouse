//
//  PauseMenu.m
//  Mar
//
//  Created by Benjamin Humphries on 8/19/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "PauseMenu.h"
#import "GameScene.h"
#import "MenuScene.h"

@implementation PauseMenu

- (id)init {
    if (self = [super initWithImageNamed:@"selectionMenu.png"]) {
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self setZPosition:20];
        [self setName:NOT_AFFECTED_BY_PAUSE];
        
        resume = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [resume setName:self.name];
        [resume setPosition:CGPointMake(-resume.size.width/2 - 5, 0)];
        [resume setColorBlendFactor:0.8f];
        [resume setColor:[SKColor greenColor]];
        [resume addChild:[SKLabelNode labelNodeWithText:@"Resume"]];
        [resume setZPosition:self.zPosition+1];
        [self addChild:resume];
        
        exit = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [exit setName:self.name];
        [exit setPosition:CGPointMake(exit.size.width/2 +5, 0)];
        [exit setColorBlendFactor:0.8f];
        [exit setColor:[SKColor redColor]];
        [exit addChild:[SKLabelNode labelNodeWithText:@"exit"]];
        [exit setZPosition:self.zPosition+1];
        [self addChild:exit];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        while (node.parent != self && node.parent)
            node = node.parent;
        
        GameScene *scene = (GameScene *)self.parent;
        
        if (node == resume) {
            [scene togglePause];
        } else if (node == exit) {
            NSLog(@"exiting");
            [scene moveToLevelSelection];
        }
    }
}

@end
