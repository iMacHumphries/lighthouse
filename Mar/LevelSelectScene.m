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

- (void)didMoveToView:(SKView *)view {
    NSArray  *contents = [self getContentOfLevelsFile];
    for (int i = 0; i < contents.count; i++) {
        NSString *file = [contents objectAtIndex:i];
        SKSpriteNode *block = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [block setName:LEVEL];
        [block setPosition:CGPointMake(i * (block.size.width + LVL_SPACING) + LEFT_OFFSET, WIDTH/2)];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithText:file];
        [label setName:LEVEL];
        //[label setPosition:CGPointMake(0, -block.size.height/2)];
        [block addChild:label];
        [self addChild:block];
        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:LEVEL]) {
            NSString *fileName =[NSString stringWithFormat:@"levels/%@",[self getLevelNameFromNode:node]];
            NSLog(@"filename : %@", fileName);
            GameScene *game = [[GameScene alloc] initWithSize:self.size andFile:fileName];
            SKTransition *door = [SKTransition doorwayWithDuration:0.4f];
            [self.view presentScene:game transition:door];
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
