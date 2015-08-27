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

@implementation LevelSelectScene

static const float LVL_SPACING = 10;
static const float LEFT_OFFSET = 50;
static NSString *const LEVEL = @"level";
static NSString *const MENU = @"menu";

- (void)didMoveToView:(SKView *)view {
    NSArray  *contents = [self getContentOfLevelsFile];
    for (int i = 0; i < contents.count; i++) {
        NSString *file = [contents objectAtIndex:i];
        int index = [file intValue];

        SKSpriteNode *block = [SKSpriteNode spriteNodeWithImageNamed:@"lvlButton.png"];
        [block setName:LEVEL];
        [block setPosition:CGPointMake((index-1) * (block.size.width + LVL_SPACING) + LEFT_OFFSET, HEIGHT/2)];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithText:file];
        [label setFontColor:[UIColor blueColor]];
        [label setZPosition:block.zPosition+1];
        [label setName:LEVEL];
        //[label setPosition:CGPointMake(0, -block.size.height/2)];
        [block addChild:label];
        [self addChild:block];
        
        SKSpriteNode *menu = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [menu setName:MENU];
        [menu setPosition:CGPointMake(WIDTH - menu.size.width - LVL_SPACING, HEIGHT - menu.size.height - LVL_SPACING)];
        [self addChild:menu];
        
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        while (node.parent != NULL && node.parent != self)
            node = node.parent;
        
        if ([node.name isEqualToString:LEVEL]) {
            NSString *fileName =[NSString stringWithFormat:@"levels/%@",[self getLevelNameFromNode:node]];
            NSLog(@"filename : %@", fileName);
            GameScene *game = [[GameScene alloc] initWithSize:self.size andFile:fileName];
            SKTransition *door = [SKTransition doorwayWithDuration:0.4f];
            [self.view presentScene:game transition:door];
        } else if ([node.name isEqualToString:MENU]) {
            MenuScene *scene = [MenuScene sceneWithSize:self.size];
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

- (NSArray *)getContentOfLevelsFile {
    NSError *error = nil;
    NSString *folderPath = [[[NSBundle mainBundle] resourcePath]
                            stringByAppendingPathComponent:@"levels"];
    
   return [[NSFileManager defaultManager]
           contentsOfDirectoryAtPath:folderPath error:&error];
}

@end
