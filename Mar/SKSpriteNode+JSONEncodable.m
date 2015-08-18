//
//  SKSpriteNode+JSONEncodable.m
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "SKSpriteNode+JSONEncodable.h"

@implementation SKSpriteNode (JSONEncodable)

static NSString* const X_POS_KEY = @"x";
static NSString* const Y_POS_KEY = @"y";
static NSString* const Z_POS_KEY = @"z";
static NSString* const SCALE_KEY = @"scale";
static NSString* const IMAGE_KEY = @"image";
static NSString* const Z_ROTATION_KEY = @"rotation";

- (NSDictionary *)encodeJSON {
    NSMutableDictionary *jsonDictionary = [[NSMutableDictionary alloc] init];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.position.x] forKey:X_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.position.y] forKey:Y_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.zPosition] forKey:Z_POS_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.zRotation] forKey:Z_ROTATION_KEY];
    [jsonDictionary setValue:[NSNumber numberWithFloat:self.xScale] forKey:SCALE_KEY];
    [jsonDictionary setValue:[NSString stringWithFormat:@"%@.png",self.name] forKey:IMAGE_KEY];
    
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
    }
    return self;
}

@end
