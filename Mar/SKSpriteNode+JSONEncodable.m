//
//  SKSpriteNode+JSONEncodable.m
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "SKSpriteNode+JSONEncodable.h"
#import "PrefixHeader.pch"

@implementation SKSpriteNode (JSONEncodable)

static NSString* const X_POS_KEY = @"x";
static NSString* const Y_POS_KEY = @"y";
static NSString* const Z_POS_KEY = @"z";
static NSString* const SCALE_KEY = @"scale";
static NSString* const IMAGE_KEY = @"image";
static NSString* const Z_ROTATION_KEY = @"rotation";
static NSString* const NAME_KEY = @"name";
static NSString* const WIDTH_KEY = @"width";
static NSString* const HEIGHT_KEY = @"height";

- (void)scaleDown {
    NSLog(@"scaling down by %f", GAME_SCALE_DOWN_WIDTH);
    [self setScale:[self xScale] * GAME_SCALE_DOWN_WIDTH];
    [self setPosition:CGPointMake(self.position.x *GAME_SCALE_DOWN_WIDTH, self.position.y *GAME_SCALE_DOWN_HEIGHT)];
}

- (void)scaleUp {
    NSLog(@"scaling up by %f", GAME_SCALE_UP_WIDTH);
    [self setScale:[self xScale] * GAME_SCALE_UP_WIDTH];
    [self setPosition:CGPointMake(self.position.x *GAME_SCALE_UP_WIDTH, self.position.y *GAME_SCALE_UP_HEIGHT)];
}

- (NSDictionary *)encodeJSON {
    [self scaleDown];
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.position.x] forKey:X_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.position.y] forKey:Y_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.zPosition] forKey:Z_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.zRotation] forKey:Z_ROTATION_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.xScale] forKey:SCALE_KEY];
    [jsonDictionary setValue:[NSString stringWithFormat:@"%@.png",self.name] forKey:IMAGE_KEY];
    [jsonDictionary setValue:self.name forKey:NAME_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.size.width] forKey:WIDTH_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.size.height] forKey:HEIGHT_KEY];
    
    [self scaleUp];
    return jsonDictionary;
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [self init]) {
        if ([dictionary valueForKey:X_POS_KEY])
            [self setPosition:CGPointMake([[dictionary valueForKey:X_POS_KEY] floatValue], self.position.y)];
        if ([dictionary valueForKey:Y_POS_KEY])
            [self setPosition:CGPointMake(self.position.x, [[dictionary valueForKey:Y_POS_KEY] floatValue])];
        if ([dictionary valueForKey:Z_POS_KEY])
            [self setZPosition:[[dictionary valueForKey:Z_POS_KEY] floatValue]];
        if ([dictionary objectForKey:Z_ROTATION_KEY])
            [self setZRotation:[[dictionary objectForKey:Z_ROTATION_KEY] floatValue]];
        if ([dictionary objectForKey:SCALE_KEY])
            [self setScale:[[dictionary objectForKey:SCALE_KEY] floatValue]];
        if ([dictionary objectForKey:IMAGE_KEY])
            [self setTexture:[SKTexture textureWithImage:[UIImage imageNamed:[dictionary objectForKey:IMAGE_KEY]]]];
        if ([dictionary objectForKey:NAME_KEY])
            [self setName:[dictionary objectForKey:NAME_KEY]];
        if ([dictionary objectForKey:WIDTH_KEY] && [dictionary objectForKey:HEIGHT_KEY]) {
            [self setSize:CGSizeMake([[dictionary objectForKey:WIDTH_KEY] floatValue], [[dictionary objectForKey:HEIGHT_KEY] floatValue])];
        }
        [self scaleUp];
    }
    return self;
}

@end
