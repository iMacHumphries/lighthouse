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
        [self addDetails];
    }
    return self;
}

- (void)addDetails {  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

@end
