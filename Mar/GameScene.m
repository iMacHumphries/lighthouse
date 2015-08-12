//
//  GameScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "GameScene.h"
#import "Ship.h"

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
    
    lighthouse = [[Lighthouse alloc] initWithImageNamed:@"lighthouse.png"];
    [self addChild:lighthouse];
    
    touchBox = [[TouchBox alloc] initWithLighthouse:lighthouse];
    [self addChild:touchBox];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [touchBox touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:background];
}
   
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [touchBox touchesMoved:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:background];
       
    }
}

- (void)update:(CFTimeInterval)currentTime {
    [shipManager update:currentTime];
    
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
    
     NSLog(@"contact!");
    if ((firstBody.categoryBitMask & SPOT_LIGHT) != 0)
    {
        NSLog(@"got one!");
        ship = (Ship*)secondBody.node;
        [ship turnAround];
    }
}

@end
