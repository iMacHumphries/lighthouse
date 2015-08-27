//
//  Wave.h
//  Mar
//
//  Created by Benjamin Humphries on 8/19/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Wave : SKSpriteNode {
    SKShader *shader;
    float moveFactor;
}
- (void)update:(NSTimeInterval)currentTime;
- (void)move;
@end
