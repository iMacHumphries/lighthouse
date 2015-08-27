//
//  NodeManager.m
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "NodeManager.h"
#import "Wave.h"

@implementation NodeManager
- (id)init {
    if (self = [super init]) {
        nodes = [[NSMutableArray alloc]init];
        nodesToRemove = [[NSMutableArray alloc]init];
        
    }
    return self;
}

- (void)addNode:(SKNode*)node {
    [nodes addObject:node];
}

- (void)destroyAll {
    nodes = [[NSMutableArray alloc]init];
    nodesToRemove = [[NSMutableArray alloc]init];
}

- (void)removeNode:(SKNode *)targetNode {
   // if (![targetNode isKindOfClass:[Wave class]]) {
        [targetNode removeFromParent];
        [nodesToRemove addObject:targetNode];
    //}
    
}

- (void)update:(CFTimeInterval)currentTime {
    for (SKNode *node in nodes) {
        if ([node isKindOfClass:[Wave class]]) {
            Wave *wave = (Wave *)node;
            [wave update:currentTime];
        }
    }
    for (SKNode *node in nodes)
        if ([node isOffScreen])
            [self removeNode:node];
    for (SKNode *node in nodesToRemove)
        [nodes removeObject:node];
    [nodesToRemove removeAllObjects];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (SKNode *node in nodes) {
        [node touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (SKNode *node in nodes) {
        [node touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (SKNode *node in nodes) {
        [node touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (SKNode *node in nodes) {
        [node touchesCancelled:touches withEvent:event];
    }
}

@end
