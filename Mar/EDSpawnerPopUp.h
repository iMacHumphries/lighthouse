//
//  EDSpawnerPopUp.h
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDPopUpDetail.h"
#import "Spawner.h"

@interface EDSpawnerPopUp : EDPopUpDetail {
    Spawner *spawner;
    
    Slider *nodesSlider;
    SKLabelNode *nodesLabel;
    
    Slider *timeSlider;
    SKLabelNode *timeLabel;
    
    Switch *shipSwitch;
    Switch *subSwitch;
}
- (void)setSpawner:(Spawner *)_spawner;

@property (nonatomic, assign) float time;
@property (nonatomic, assign) int nodes;

@end
