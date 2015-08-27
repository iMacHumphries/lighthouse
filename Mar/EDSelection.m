//
//  EDSelection.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EDSelection.h"
#import "Ship.h"
#import "Lighthouse.h"
#import "Spawner.h"
#import "Rock.h"
#import "BottomRocks.h"
#import "Sub.h"
#import "Fog.h"

@implementation EDSelection
@synthesize selectedNode, delegate;

static NSString * const NORMAL_SHIP = @"ship";
static NSString * const LIGHTHOUSE = @"lighthouse";
static NSString * const SPAWNER = @"spawner";
static NSString * const BOT_ROCKS = @"rocks";
static NSString * const ROCK = @"rock";
static NSString * const SUB = @"subYellow";
static NSString * const FOG = @"fog";

- (id)initWithImageNamed:(NSString *)name {
    if (self = [super initWithImageNamed:name]) {
        [self setName:@"edSelection"];
        [self setZPosition:20];
        [self setPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
        [self addSelections];
        [self setScale:0.5f * SCALER];
        
    }
    return self;
}

- (void)addSelections {
    [self addNewButtons:[NSArray arrayWithObjects:NORMAL_SHIP, SUB, SPAWNER, LIGHTHOUSE, BOT_ROCKS, ROCK, FOG, nil]];
}

- (void)addNewButtons:(NSArray *)buttons {
    const float TOP_OFFSET = 10.0f;
    const float SPACING = 10.0f;
    float y = self.size.height/2 - SPACE - TOP_OFFSET;
    float x = -self.size.width/2 + SPACE;
    for (int i =0; i< buttons.count; i++) {
        NSString *name =[buttons objectAtIndex:i];
        SKSpriteNode *button = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [button setName:name];
        [button setZPosition:11];
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:name];
        [image setScale:0.3f];
        if ([name isEqualToString:SPAWNER])
            [image setScale:0.7f];
        else if ([name isEqualToString:BOT_ROCKS])
            [image setScale:0.2f];
        [button addChild:image];
        [button setPosition:CGPointMake(x + (SPACING * i) + (button.size.width *i), y)];
        [self addChild:button];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        if (![self containsPoint:[touch locationInNode:self.parent]])return;
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        while (node.parent != NULL && node.parent != self && node.parent != self.parent)
        {
            node = node.parent;
        }
        NSLog(@"tapped %@", node.name);
        
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
            Spawner *spawner = [[Spawner alloc] init];
            [spawner setName:SPAWNER];
            selectedNode = spawner;
        } else if ([node.name isEqualToString:BOT_ROCKS]) {
            BottomRocks *rocks = [[BottomRocks alloc] init];
            selectedNode = rocks;
        } else if ([node.name isEqualToString:ROCK]) {
            Rock *rock = [[Rock alloc] init];
            selectedNode = rock;
        } else if ([node.name isEqualToString:SUB]) {
            Sub *sub = [[Sub alloc] init];
            selectedNode = sub;
        } else if ([node.name isEqualToString:FOG]) {
            Fog *fog = [[Fog alloc] init];
            selectedNode = fog;
        } else {
            foundOne = false;
        }
        
        if (foundOne)
             [delegate selectionEndedWithNode:selectedNode];
    }
}



@end
