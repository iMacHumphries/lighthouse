//
//  LevelSelectScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "LevelSelectScene.h"
#import "GameScene.h"
#import "PrefixHeader.pch"
#import "BoxSelectScene.h"
#import "Level.h"

@implementation LevelSelectScene

static const float LVL_SPACING = 10;
static const float LEFT_OFFSET = 50;
static NSString *const LEVEL = @"level";
static NSString *const MENU = @"menu";

- (id)initWithSize:(CGSize)size box:(Box *)box {
    if (self = [super initWithSize:size]) {
        currentBox = box;
        for (int i = 0; i < box.levels.count; i++) {
            Level *level = [box.levels objectAtIndex:i];
            int index = level.ID;
    
            SKSpriteNode *block = [SKSpriteNode spriteNodeWithImageNamed:@"lvlButton.png"];
            [block setName:LEVEL];
            [block setPosition:CGPointMake((index-1) * (block.size.width + LVL_SPACING) + LEFT_OFFSET, HEIGHT/2)];
            
            SKLabelNode *label = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%i",level.ID]];
            [label setFontColor:[UIColor blueColor]];
            [label setZPosition:block.zPosition+1];
            [label setName:LEVEL];
            [block addChild:label];
            [self addChild:block];
            
            SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
            [menu setName:MENU];
            [menu setPosition:CGPointMake(WIDTH - menu.size.width - LVL_SPACING, HEIGHT - menu.size.height - LVL_SPACING)];
            [self addChild:menu];
            
        }
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        while (node.parent != NULL && node.parent != self)
            node = node.parent;
        
        if ([node.name isEqualToString:LEVEL]) {
            int ID = [[self getLevelNameFromNode:node] intValue];
            GameScene *game = [[GameScene alloc] initWithSize:self.size level:[currentBox levelWithID:ID]];
            SKTransition *door = [SKTransition doorwayWithDuration:0.4f];
            [self.view presentScene:game transition:door];
        } else if ([node.name isEqualToString:MENU]) {
            BoxSelectScene *scene = [BoxSelectScene sceneWithSize:self.size];
            [self.view presentScene:scene];
        }
    }
}

- (NSString *)getLevelNameFromNode:(SKNode *)node {
    NSString *result = @"";
    
    for (SKNode *child in node.children) {
        if ([child isKindOfClass:[SKLabelNode class]]) {
            SKLabelNode *label = (SKLabelNode *)child;
            result = label.text;
            break;
        }
    }
    
    return result;
}

- (NSArray *)getContentOfLevelsFile:(NSString *)file {
    NSError *error = nil;
    NSString *folderPath = [[[NSBundle mainBundle] resourcePath]
                            stringByAppendingPathComponent:file];
    
   return [[NSFileManager defaultManager]
           contentsOfDirectoryAtPath:folderPath error:&error];
}

@end
