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

 NSString * const  NORMAL_SHIP = @"normal_ship";
NSString * const  LIGHTHOUSE = @"lighthouse";

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
    
    const float TOP_OFFSET = 10.0f;
    const float SPACE = 50.0f;
    const float SPACING = 10.0f;
    
    SKSpriteNode *boat = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [boat setName:NORMAL_SHIP];
    [boat setZPosition:11];
    SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:@"ship.png"];
    [ship setName:NORMAL_SHIP];
    [ship setScale:0.5f];
    [boat addChild:ship];
    [boat setPosition:CGPointMake(-self.size.width/2 + SPACE, self.size.height/2 - SPACE - TOP_OFFSET)];
    [self addChild:boat];
    
    
    SKSpriteNode *lightHouse = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [lightHouse setName:LIGHTHOUSE];
    [lightHouse setZPosition:11];
    SKSpriteNode *house = [SKSpriteNode spriteNodeWithImageNamed:@"lighthouse.png"];
    [house setName:LIGHTHOUSE];
    [house setScale:0.3f];
    [lightHouse addChild:house];
    [lightHouse setPosition:CGPointMake(boat.position.x + SPACING + lightHouse.size.width, boat.position.y)];
    [self addChild:lightHouse];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:NORMAL_SHIP]) {
            Ship *ship =[[Ship alloc] init];
            [ship hault];
            selectedNode = ship;
            [selectedNode setName:node.name];
            [delegate selectionEndedWithNode:selectedNode];
        } else if ([node.name isEqualToString:LIGHTHOUSE]) {
            Lighthouse *light =[[Lighthouse alloc] initWithImageNamed:@"lighthouse.png"];
            [light setTouchEnabled:NO];
            selectedNode = light;
            [selectedNode setName:node.name];
            [delegate selectionEndedWithNode:selectedNode];
        }
    }
}



@end
