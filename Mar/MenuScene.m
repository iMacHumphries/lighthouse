//
//  MenuScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "LevelSelectScene.h"

@implementation MenuScene

NSString * const PLAY = @"play";
NSString * const EDITOR = @"editor";

- (void)didMoveToView:(SKView *)view {
    playButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [playButton setName:PLAY];
    [playButton setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
    [playButton addChild:[SKLabelNode labelNodeWithText:@"Play"]];
    [self addChild:playButton];
    
    editorButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [editorButton setName:EDITOR];
    [editorButton setPosition:CGPointMake(WIDTH/2, HEIGHT/2 + editorButton.size.height + 10)];
    SKLabelNode *label =[SKLabelNode labelNodeWithText:@"Editor"];
    [label setName:EDITOR];
    [editorButton addChild:label];
    [self addChild:editorButton];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:PLAY]) {
            LevelSelectScene *scene = [[LevelSelectScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:scene transition:doors];
        } else if ([node.name isEqualToString:EDITOR]) {
            EditorScene *edit = [[EditorScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:edit transition:doors];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)update:(NSTimeInterval)currentTime {
    
}

@end
