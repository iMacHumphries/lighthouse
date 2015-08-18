//
//  Ship.h
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKSpriteNode+JSONEncodable.h"
#import "GameScene.h"

@interface Ship : SKSpriteNode {
    CGVector direction;
    BOOL hasTurnedAround;
    NSString *imageName;

}

- (void)turnAround;
- (void)destroy;
- (void)explode;
- (BOOL)isOffScreen;
- (void)hault;
//- (NSDictionary *)encodeJSON;
//- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
