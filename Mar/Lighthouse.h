//
//  Lighthouse.h
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpotLight.h"

@interface Lighthouse : SKSpriteNode {
    SpotLight *spotLight;
}

@property (nonatomic, retain) SpotLight *spotLight;
@end
