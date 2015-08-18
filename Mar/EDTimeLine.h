//
//  EDTimeLine.h
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EDTimeLine : SKSpriteNode

- (void)addNodeOnTimeLine:(SKNode *)node;
- (float)getTimeForNode:(SKNode *)node;
@end
