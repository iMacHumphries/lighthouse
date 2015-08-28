//
//  NodeManager.h
//  Mar
//
//  Created by Benjamin Humphries on 8/18/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "SKNode+OffScreenAwareness.h"

@interface NodeManager : NSObject {
    NSMutableArray *nodes;
    NSMutableArray *nodesToRemove;
    
}
- (void)removeNode:(SKNode *)targetNode;
- (void)destroyAll;
- (void)addNode:(SKNode*)node;
- (void)update:(CFTimeInterval)currentTime;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
- (NSMutableArray *)nodes;
@end
