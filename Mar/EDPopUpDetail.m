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
        Slider *shipAmountSlider = [[Slider alloc] initWithSize:CGSizeMake(self.size.width - 5, 10) minValue:1 maxValue:50];
        [self addChild:shipAmountSlider];
    }
    return self;
}


@end
