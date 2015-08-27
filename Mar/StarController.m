//
//  StartController.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "StarController.h"
#import "GameScene.h"

@implementation StarController

- (id)init {
    if (self = [super init]) {
        [self setZPosition:15];
        star = [SKSpriteNode spriteNodeWithImageNamed:@"starFill.png"];
        emptyStar = [SKSpriteNode spriteNodeWithImageNamed:@"starFrame.png"];
        
        [self setPosition:CGPointMake(X_OFFSET, HEIGHT - star.size.height/2 - Y_OFFSET)];
        
        stars = [[NSMutableArray alloc] init];
        [self addThreeStars];
    }
    return self;
}

- (void)addThreeStars {
    for (int i = 0; i < 3; i++) {
        SKSpriteNode *newStar = [star copy];
        [newStar setPosition:CGPointMake((i * star.size.width) + STAR_SPACING, 0)];
        [stars addObject:newStar];
        [self addChild:newStar];
    }
}

- (void)removeStar {
    if ([stars count] <= 0) return;
    [[stars lastObject] runAction:[SKAction setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"starFrame.png"]]]];
    [stars removeLastObject];
}

- (int)starCount {
    return (int)[stars count];
}

@end
