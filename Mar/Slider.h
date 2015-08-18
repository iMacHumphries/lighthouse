//
//  Slider.h
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Slider : SKSpriteNode {
    SKSpriteNode *ball;
    float value;
    float minValue;
    float maxValue;
    
    BOOL isMoving;
}

- (id)initWithSize:(CGSize)size minValue:(float)min maxValue:(float)max;

@property (nonatomic, assign) float value;
@end
