//
//  Lighthouse.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Lighthouse.h"
#import "GameScene.h"

@implementation Lighthouse
@synthesize spotLight;

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setPosition:CGPointMake(WIDTH/2, self.size.height/3)];
        
        spotLight = [[SpotLight alloc] initWithImageNamed:@"beam.png"];
        [spotLight setPosition:CGPointMake(0, self.size.height/2)];
        [self addChild:spotLight];
        
        lightSlider = [[LightControlRail alloc] initWithLightHouse:self];
        [self addChild:lightSlider];
        
    }
    return self;
}



@end
