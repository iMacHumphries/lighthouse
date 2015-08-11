//
//  TouchBox.h
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Lighthouse.h"

@interface TouchBox : SKSpriteNode {
    float rotation;
    Lighthouse *lighthouse;
}

- (id)initWithLighthouse:(Lighthouse *)_lighthouse;

@property (nonatomic, assign) float rotation;
@end
