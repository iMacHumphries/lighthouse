//
//  SKSpriteNode+JSONEncodable.h
//  Mar
//
//  Created by Benjamin Humphries on 8/17/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (JSONEncodable)
- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)encodeJSON;
- (void)scaleDown;
- (void)scaleUp;
@end
