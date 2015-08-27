//
//  EDFogPopUp.h
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDPopUpDetail.h"
#import "Fog.h"
#import "Switch.h"

@interface EDFogPopUp : EDPopUpDetail {
    Slider *strengthSlider;
    SKLabelNode *label;
    
    Slider *lifeSlider;
    SKLabelNode *lifeLabel;
    
    Fog *fog;
    
    Switch *displaySwitch;
}


- (void)setFog:(Fog *)_fog;

@property (nonatomic, assign) float strength;
@property (nonatomic, assign) float liveTime;

@end
