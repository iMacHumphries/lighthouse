//
//  EDSpawnerPopUp.m
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDSpawnerPopUp.h"

@implementation EDSpawnerPopUp
@synthesize time,nodes;
static const int MAX_NODES = 50;
static const int MIN_NODES = 1;
static const float MAX_TIME = 60.0f;
static const float MIN_TIME = 1.0f;

- (id)init {
    if (self = [super init]) {
        [self setPosition:CGPointMake(0, self.size.height/2)];
    }
    return self;
}

- (void)setSpawner:(Spawner *)_spawner {
    spawner = _spawner;
}

// override
- (void)addDetails {
    [self setScale:1.5f];
    
    nodesLabel = [SKLabelNode labelNodeWithText:@"nodes  "];
    [nodesLabel setName:UI];
    [nodesLabel setPosition:CGPointMake(-self.size.width/2 + OFF, self.size.height/2 - OFF)];
    [self addChild:nodesLabel];
    nodesSlider = [[Slider alloc] initWithSize:CGSizeMake(self.size.width - nodesLabel.frame.size.width- SPACE, 10) minValue:MIN_NODES maxValue:MAX_NODES];
    [nodesSlider setPosition:CGPointMake(nodesLabel.position.x + nodesLabel.frame.size.width + SPACE, nodesLabel.position.y)];
    [nodesSlider setName:UI];
    [self addChild:nodesSlider];
    
    timeLabel = [SKLabelNode labelNodeWithText:@"time  "];
    [timeLabel setPosition:CGPointMake(nodesLabel.position.x, nodesLabel.position.y - timeLabel.frame.size.height - SPACE)];
    [timeLabel setName:UI];
    [self addChild:timeLabel];
    timeSlider = [[Slider alloc] initWithSize:nodesSlider.size minValue:MIN_TIME maxValue:MAX_TIME];
    [timeSlider setPosition:CGPointMake(nodesSlider.position.x, nodesSlider.position.y - timeSlider.size.height - SPACE)];
    [timeSlider setName:UI];
    [self addChild:timeSlider];
    
    shipSwitch = [[Switch alloc] init];
    SKSpriteNode *s = [SKSpriteNode spriteNodeWithImageNamed:@"ship"];
    [s setName:UI];
    [s setZPosition:shipSwitch.zPosition+1];
    [s setScale:0.6];
    [shipSwitch addChild:s];
    [shipSwitch setPosition:CGPointMake(-self.size.width/2 + OFF, timeSlider.position.y -SPACE - shipSwitch.size.height)];
    [self addChild:shipSwitch];
    
    subSwitch = [[Switch alloc] init];
    SKSpriteNode *sub = [SKSpriteNode spriteNodeWithImageNamed:@"subYellow"];
    [sub setName:UI];
    [sub setZPosition:subSwitch.zPosition+1];
    [sub setScale:0.6];
    [subSwitch addChild:sub];
    [subSwitch setPosition:CGPointMake(shipSwitch.position.x + subSwitch.size.width, shipSwitch.position.y)];
    [self addChild:subSwitch];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [nodesSlider touchesBegan:touches withEvent:event];
    [timeSlider touchesBegan:touches withEvent:event];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];    
        for (SKNode *node in [self nodesAtPoint:location]) {
            if (node == shipSwitch) {
                [shipSwitch toggle];
                spawner.spawnShips = [shipSwitch isOn];
            
            } else if (node == subSwitch) {
                [subSwitch toggle];
                spawner.spawnSubs = [subSwitch isOn];
            }
        }
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [nodesSlider touchesMoved:touches withEvent:event];
    [timeSlider touchesMoved:touches withEvent:event];
    
    time  = timeSlider.value;
    nodes = (int)nodesSlider.value;
    
    [nodesLabel setText:[NSString stringWithFormat:@"nodes %i",nodes]];
    [timeLabel setText:[NSString stringWithFormat:@"time  %f",time]];
}
@end
