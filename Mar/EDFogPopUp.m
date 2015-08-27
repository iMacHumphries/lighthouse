//
//  EDFogPopUp.m
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDFogPopUp.h"

@implementation EDFogPopUp
@synthesize strength,liveTime;

static const int MAX_STRENGTH = 50;
static const int MIN_STRENGTH = 0;

static const int MAX_TIME = 60;
static const int MIN_TIME = 0;

- (id)init {
    if (self = [super init]) {
        [self setPosition:CGPointMake(0, self.size.height/2)];
    }
    return self;
}

- (void)setFog:(Fog *)_fog {
    fog = _fog;
}

// override
- (void)addDetails {
    [self setScale:1.5f];
    
    label = [SKLabelNode labelNodeWithText:@"Strength  "];
    [label setName:UI];
    [label setPosition:CGPointMake(-self.size.width/2 + OFF, self.size.height/2 - OFF)];
    [self addChild:label];
    strengthSlider = [[Slider alloc] initWithSize:CGSizeMake(self.size.width - label.frame.size.width- SPACE, 10) minValue:MIN_STRENGTH maxValue:MAX_STRENGTH];
    [strengthSlider setPosition:CGPointMake(label.position.x + label.frame.size.width + SPACE, label.position.y)];
    [strengthSlider setName:UI];
    [strengthSlider setZPosition:self.zPosition+1];
    [self addChild:strengthSlider];
    
    
    lifeLabel = [SKLabelNode labelNodeWithText:@"lifeTime  "];
    [lifeLabel setPosition:CGPointMake(label.position.x, label.position.y - lifeLabel.frame.size.height - SPACE)];
    [lifeLabel setName:UI];
    [self addChild:lifeLabel];
    lifeSlider = [[Slider alloc] initWithSize:strengthSlider.size minValue:MIN_TIME maxValue:MAX_TIME];
    [lifeSlider setPosition:CGPointMake(strengthSlider.position.x, strengthSlider.position.y - lifeSlider.size.height - SPACE)];
    [lifeSlider setZPosition:self.zPosition+1];
    [lifeSlider setName:UI];
    [self addChild:lifeSlider];
    
    displaySwitch = [[Switch alloc] init];
    [displaySwitch setPosition:CGPointMake(0, lifeSlider.position.y - displaySwitch.size.height - SPACE)];
    [self addChild:displaySwitch];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [strengthSlider touchesBegan:touches withEvent:event];
    [lifeSlider touchesBegan:touches withEvent:event];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if (node == displaySwitch) {
            [displaySwitch toggle];
            [fog setHidden:displaySwitch.isOn];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [strengthSlider touchesMoved:touches withEvent:event];
    [lifeSlider touchesMoved:touches withEvent:event];
    
    strength = strengthSlider.value;
    [fog.emitter setParticleBirthRate:strength];
    liveTime = lifeSlider.value;
    [fog setLifeTime:liveTime];
    
    [label setText:[NSString stringWithFormat:@"Strength %i",(int)strength]];
    [lifeLabel setText:[NSString stringWithFormat:@"lifeTime %i",(int)liveTime]];

}


@end
