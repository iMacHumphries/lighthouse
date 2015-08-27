//
//  EDTimeLine.h
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EDTimeLine : SKSpriteNode {
    NSMutableArray *timeNodes;
    NSMutableArray *realNodes;
    SKLabelNode *timeLabel;
}

- (void)updateTextForNode:(SKNode *)node;
- (void)addNodeOnTimeLine:(SKNode *)node;
- (void)addNodeOnTimeLine:(SKNode *)node withTime:(float)time;
- (float)getTimeForNode:(SKNode *)node;
- (float)timeForNode:(SKNode *)node onTimeLine:(BOOL)onTimeLine;
- (SKNode *)getRealNodeForTimeLineNode:(SKNode*)timeLineNode;
@end
