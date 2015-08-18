//
//  Lighthouse.m
//  Mar
//
//  Created by Benjamin Humphries on 8/11/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Lighthouse.h"
#import "PrefixHeader.pch"

@implementation Lighthouse
@synthesize spotLight, touchEnabled;

- (id)init {
    if (self = [super initWithImageNamed:@"lighthouse.png"]) {
        [self setName:@"lighthouse"];
        [self setScale:0.5f * SCALER];
        [self setPosition:CGPointMake(WIDTH/2, self.size.height/2)];
        
        [self addSpotLightAndLightConroller];
        
    }
    return self;
}

- (void)addSpotLightAndLightConroller {
    spotLight = [[SpotLight alloc] initWithImageNamed:@"beam.png"];
    [spotLight setPosition:CGPointMake(0, self.size.height/2)];
    [self addChild:spotLight];
    
    lightSlider = [[LightControlRail alloc] initWithLightHouse:self];
    [self addChild:lightSlider];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchEnabled)
        [lightSlider touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchEnabled)
        [lightSlider touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touchEnabled)
        [lightSlider touchesEnded:touches withEvent:event];
}

@end
