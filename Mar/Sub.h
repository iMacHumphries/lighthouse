//
//  Sub.h
//  Mar
//
//  Created by Benjamin Humphries on 8/20/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Ship.h"

@interface Sub : FloatingNode {
    SKEmitterNode *bubbles;
}

@property (nonatomic, assign) BOOL isUnderWater;

- (void)hide;
- (void)reveal;
- (void)setBubbleTarget:(SKNode *)node;

@end
