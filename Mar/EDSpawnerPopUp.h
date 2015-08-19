//
//  EDSpawnerPopUp.h
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDPopUpDetail.h"

@interface EDSpawnerPopUp : EDPopUpDetail {
    Slider *nodesSlider;
    SKLabelNode *nodesLabel;
    
    Slider *timeSlider;
    SKLabelNode *timeLabel;
}

@property (nonatomic, assign) float time;
@property (nonatomic, assign) int nodes;

@end
