//
//  BoxSelectScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/27/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "BoxSelectScene.h"
#import "PrefixHeader.pch"
#import "LevelSelectScene.h"
#import "LevelManager.h"

@implementation BoxSelectScene {
    SKSpriteNode *box;
    float BOX_LEFT_OFFSET;
}

#define BOX_SPACE WIDTH/2
#define DETECTION 30

- (void)didMoveToView:(SKView *)view {
    boxNodes = [[NSMutableArray alloc] init];
    
    box = [SKSpriteNode spriteNodeWithImageNamed:@"box.png"];
    [box setScale:SCALER];
    
    boxes = [self getBoxes];
    max = [boxes count];
    scrollView = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:
                  CGSizeMake(max*(box.size.width + BOX_SPACE), HEIGHT)];
    BOX_LEFT_OFFSET = -scrollView.size.width/2 + box.size.width;
    [scrollView setPosition:CGPointMake(scrollView.size.width/2, HEIGHT/2)];
    [self addChild:scrollView];
    
    [self createBoxes:boxes];
    [self focusOnBox:0 withDuration:0];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        CGPoint previous = [touch previousLocationInNode:self];
        
        float delta = location.x - previous.x;
        float newX = scrollView.position.x + delta;
        newX = MIN(newX, scrollView.size.width/2 + 100);
        newX = MAX(newX, -scrollView.size.width/2 + box.size.width/2);
        [scrollView setPosition:CGPointMake(newX, scrollView.position.y)];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentLocation = [scrollView position];
    CGPoint previousLocation = [self positionForBox:currentBox];
    float delta = previousLocation.x - currentLocation.x;
    if (delta < -DETECTION)
         [self focusOnBox:currentBox-1 withDuration:0.3];
    else if (delta > DETECTION)
         [self focusOnBox:currentBox+1 withDuration:0.3];
    else
        [self focusOnBox:currentBox withDuration:0.2];
    
    if (ABS(delta) < 1) {
        for (UITouch *touch in touches) {
            for (SKNode *node in [self nodesAtPoint:[touch locationInNode:self]]) {
                if ([self isBox:node]) {
                    Box *selectedBox = [[LevelManager sharedInstance] boxForID:currentBox+1];
                    LevelSelectScene *scene = [[LevelSelectScene alloc] initWithSize:self.size box:selectedBox];
                    [self.view presentScene:scene transition:[SKTransition fadeWithColor:[UIColor blackColor] duration:0.4]];
                
                }
            }
        }
    }
}

- (void)createBoxes:(NSArray *)_boxes {
    for (int i = 0; i < _boxes.count; i++) {
        Box *newBox = [_boxes objectAtIndex:i];
        NSString *boxName = [newBox name];
       
        box = [SKSpriteNode spriteNodeWithImageNamed:@"box.png"];
        [box setName:boxName];
        [box setScale:SCALER];
        [box setPosition:CGPointMake(i* (box.size.width + BOX_SPACE) + BOX_LEFT_OFFSET, 0)];
        [scrollView addChild:box];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithText:boxName]; // Temp
        [box addChild:label];
        
        [boxNodes addObject:box];
    }
}

- (void)focusOnBox:(int)i withDuration:(float)dur{
    i = MIN(i, max-1);
    i = MAX(i, 0);
    [scrollView removeAllActions];
    currentBox=i;
    //NSLog(@"focusing on %i",i);
    SKAction *move = [SKAction moveTo:[self positionForBox:i] duration:dur];
    
    SKAction *scaleUp = [SKAction scaleTo:SCALER +0.1 duration:0.2];
    SKAction *scaleDown = [SKAction scaleTo:SCALER - 0.1 duration:0.2];
    SKAction *scaleToNormal = [SKAction scaleTo:SCALER duration:0.1];
    
    SKSpriteNode *b = [self boxForID:i];
    [scrollView runAction:move];
    [b runAction:[SKAction sequence:@[[SKAction waitForDuration:dur],scaleUp,scaleDown,scaleToNormal]]];
}

- (CGPoint)positionForBox:(int)i {
    return CGPointMake(scrollView.size.width/2 - i* (box.size.width + BOX_SPACE), scrollView.position.y);
}

- (SKSpriteNode *)boxForID:(int)i {
    for (SKSpriteNode *b in boxNodes) {
        if ([self IDForBox:b] == i) {
            return b;
        }
    }
    return NULL;
}

- (int)IDForBox:(SKNode *)b {
    return [[b.name substringFromIndex:3] intValue]-1;
}

- (BOOL)isBox:(SKNode *)node{
    return ([[node.name substringToIndex:@"Box".length] isEqualToString:@"Box"]);
}

- (NSArray *)getBoxes {
    return [[LevelManager sharedInstance] boxes];
}

@end
