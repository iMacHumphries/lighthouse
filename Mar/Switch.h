//
//  Switch.h
//  Mar
//
//  Created by Benjamin Humphries on 8/26/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Switch : SKSpriteNode

- (void)toggle;
@property (nonatomic, assign) BOOL isOn;
@end
