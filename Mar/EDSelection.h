//
//  EDSelection.h
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@protocol EDSelectionDelegate

- (void)selectionEndedWithNode:(SKNode *)node;

@end

@interface EDSelection : SKSpriteNode {
    SKNode *selectedNode;
}

@property (nonatomic, retain) SKNode *selectedNode;
@property (nonatomic, assign) id delegate;
@end
