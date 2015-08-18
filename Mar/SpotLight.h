//
//  SpotLight.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKSpriteNode+JSONEncodable.h"

@interface SpotLight : SKSpriteNode {
    SKLightNode *light;
}

- (void)rotateToAngle:(float)angle;

@end
