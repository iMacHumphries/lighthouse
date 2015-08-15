//
//  GameScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "GameScene.h"
#import "Ship.h"
#import "BrokenShip.h"

@implementation GameScene

- (void)didMoveToView:(SKView *)view {
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
    spawner = [[Spawner alloc] init];
    [spawner setDelegate:self];
    [spawner start];
    
    shipManager = [[ShipManager alloc] init];
    
    background = [[Background alloc] initWithImageNamed:@"water.png"];
    [self addChild:background];
    
    rocks = [SKSpriteNode spriteNodeWithImageNamed:@"rocks.png"];
    [rocks setName:@"rocks"];
    [rocks setSize:CGSizeMake(WIDTH, 50*WIDTH/568)];
    [rocks setPhysicsBody:[SKPhysicsBody bodyWithTexture:rocks.texture alphaThreshold:0.5 size:rocks.size]];
    [rocks.physicsBody setUsesPreciseCollisionDetection:YES];
    [rocks.physicsBody setAffectedByGravity:NO];
    [rocks.physicsBody setCategoryBitMask:ROCKS];
    [rocks.physicsBody setCollisionBitMask:0];
    [rocks.physicsBody setContactTestBitMask:SHIP];
    [rocks setPosition:CGPointMake(WIDTH/2, rocks.size.height/2)];
    [self addChild:rocks];

    lighthouse = [[Lighthouse alloc] initWithImageNamed:@"lighthouse.png"];
    [self addChild:lighthouse];
    
    starController = [[StartController alloc] init];
    [self addChild:starController];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouse touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:background];
}
   
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [lighthouse touchesMoved:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
       // [rocks setPosition:location];
       // NSLog(@"%f,%f",location.x, location.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouse touchesEnded:touches withEvent:event];
}

- (void)update:(CFTimeInterval)currentTime {
    [shipManager update:currentTime];
    [background update:currentTime];
    
}

- (void)spawnType:(NSUInteger)type{
    Ship *ship = NULL;
    switch (type) {
        case NORMAL:
            ship = [[Ship alloc]init];
            break;
            
        default:
            break;
    }
    if (ship != NULL) {
        [shipManager addShip:ship];
        [self addChild:ship];
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    Ship *ship;
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & SPOT_LIGHT) != 0)
    {
        ship = (Ship*)secondBody.node;
        [ship turnAround];
    } else if ((firstBody.categoryBitMask & ROCKS) != 0)
    {
        ship = (Ship*)secondBody.node;
        [ship explode];
        BrokenShip *broken =[[BrokenShip alloc] initWithImageNamed:@"brokenShip.png"];
        [broken setPosition:contact.contactPoint];
        [self addChild:broken];
        [starController removeStar];
        
    } else {
        [self logContact:contact];
    }
}

- (void)logContact:(SKPhysicsContact *)contact {
    NSLog(@"contact: %@ and %@",contact.bodyA.node.name, contact.bodyB.node.name);
}

@end
