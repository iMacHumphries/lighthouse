//
//  EDSelection.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDSelection.h"
#import "Ship.h"

@implementation EDSelection
@synthesize selectedNode, delegate;

static NSString * const  NORMAL_SHIP = @"ship.png";
static NSString * const  LIGHTHOUSE = @"lighthouse.png";
static NSString * const  SPAWNER = @"spawner.png";

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"edSelection"];
        [self setZPosition:20];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self addSelections];
        
    }
    return self;
}

- (void)addSelections {
    [self addNewButtons:[NSArray arrayWithObjects:NORMAL_SHIP,LIGHTHOUSE,SPAWNER, nil]];
}

- (void)addNewButtons:(NSArray *)buttons {
    const float TOP_OFFSET = 10.0f;
    const float SPACE = 50.0f;
    const float SPACING = 10.0f;
    float y = self.size.height/2 - SPACE - TOP_OFFSET;
    float x = -self.size.width/2 + SPACE;
    for (int i =0; i< buttons.count; i++) {
        NSString *name =[buttons objectAtIndex:i];
        SKSpriteNode *button = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [button setName:name];
        [button setZPosition:11];
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:name];
        [image setName:name];
        [image setScale:0.4f];
        [button addChild:image];
        [button setPosition:CGPointMake(x + (SPACING * i) + (button.size.width *i), y)];
        [self addChild:button];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        while (node.parent != NULL && node.parent != self)
        {
            node = node.parent;
        }
        
        BOOL foundOne = true;
        if ([node.name isEqualToString:NORMAL_SHIP]) {
            Ship *ship =[[Ship alloc] init];
            [ship hault];
            selectedNode = ship;
            [selectedNode setName:node.name];
        } else if ([node.name isEqualToString:LIGHTHOUSE]) {
            Lighthouse *light =[[Lighthouse alloc] initWithImageNamed:@"lighthouse.png"];
            [light setTouchEnabled:NO];
            selectedNode = light;
            [selectedNode setName:node.name];
        } else if ([node.name isEqualToString:SPAWNER]) {
            selectedNode = [node copy];
        } else {
            foundOne = false;
        }
        
        if (foundOne)
             [delegate selectionEndedWithNode:selectedNode];
    }
}



@end
