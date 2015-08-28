//
//  BoxSelectScene.h
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BoxSelectScene : SKScene {
    SKSpriteNode *scrollView;
    CGPoint initialBox;
    int currentBox;
    int max;
    NSMutableArray *boxNodes;
    NSArray *boxes;
}

@end
