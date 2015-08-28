//
//  Lighthouse.h
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpotLight.h"
#import "LightControlRail.h"
#import "SKSpriteNode+JSONEncodable.h"

@class LightControlRail;
@interface Lighthouse : SKSpriteNode {
    LightControlRail *lightSlider;
}

@property (nonatomic, retain) SpotLight *spotLight;
@property (nonatomic, assign) BOOL touchEnabled;
@end
