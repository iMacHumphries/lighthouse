//
//  LightControlRail.h
//  Mar
//
//  Created by Benjamin Humphries on 8/12/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Lighthouse.h"

@interface LightControlRail : SKSpriteNode {
    Lighthouse *lighthouse;
    SKSpriteNode *ball;
    SKSpriteNode *track;
    float radius;
    float minRadius;

}

- (id)initWithLightHouse:(Lighthouse *)lh;

@end
