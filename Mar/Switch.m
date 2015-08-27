//
//  Switch.m
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Switch.h"

@implementation Switch
@synthesize isOn;

- (id)init {
    if (self = [super initWithImageNamed:@"lvlButton.png"]) {
        [self setName:@"ui"];
        [self setColorBlendFactor:0.8f];
        [self setColor:[UIColor redColor]];
    }
    return self;
}

- (void)toggle {
    [self setColorBlendFactor:0.8f];
    if (isOn) {
        [self setColor:[UIColor redColor]];
    } else {
        [self setColor:[UIColor greenColor]];
    }
    isOn = !isOn;
}
@end
