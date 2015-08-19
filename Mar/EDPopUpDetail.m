//
//  PopUpDetail.m
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDPopUpDetail.h"
#import "Slider.h"

@implementation EDPopUpDetail

- (id)init {
    if (self = [super initWithImageNamed:@"popUpDetail.png"]) {
        [self setName:@"ui"];
        [self setAlpha:0.7f];
        [self setPosition:CGPointMake(0, self.size.height/2)];
        
        nodesSlider = [[Slider alloc] initWithSize:CGSizeMake(self.size.width - 5, 10) minValue:1 maxValue:50];
        [nodesSlider setName:@"ui"];
        [self addChild:nodesSlider];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [nodesSlider touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [nodesSlider touchesMoved:touches withEvent:event];
}

@end
