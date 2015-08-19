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


- (id)initWithSize:(CGSize)size andFile:(NSString *)file {
    if (self = [super initWithSize:size]) {
        [self loadLevelFromFile:file];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {

}

- (void)loadLevelFromFile:(NSString *)fileName {
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
    shipManager = [[NodeManager alloc] init];
    lighthouseManager = [[NodeManager alloc] init];
    
    background = [[Background alloc] initWithImageNamed:@"water.png"];
    [self addChild:background];
    
    rocks = [[Rock alloc] initWithImageNamed:@"rocks.png"];
    [self addChild:rocks];

    starController = [[StarController alloc] init];
    [self addChild:starController];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSError *jsonError;
    NSData *objectData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    if (jsonError)
        NSLog(@"error %@",[jsonError localizedDescription]);
    
    
    LevelData *levelData = [[LevelData alloc] initWithDictionary:json];
    
    for (Ship *ship in levelData.ships) {
        [shipManager addNode:ship];
        [self addChild:ship];
        [ship move];
    }
    
    for (Lighthouse *light in levelData.lighthouses) {
        [lighthouseManager addNode:light];
        [light setTouchEnabled:YES];
        [self addChild:light];
    }
    
    for (Spawner *spawner in levelData.spawners){
        [spawner setDelegate:self];
        [spawner setScale:0];
        [self addChild:spawner];
        [spawner start];
    }
    
    pause = [SKSpriteNode spriteNodeWithImageNamed:@"pause.png"];
    [pause setName:@"pause"];
    [pause setPosition:CGPointMake(WIDTH - pause.size.width - 10, HEIGHT - pause.size.width -10)];
    [pause setZPosition:20];
    [self addChild:pause];
    
}

- (void)togglePause {
    NSLog(@"pause");
    self.scene.view.paused = !self.scene.view.paused;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouseManager touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if (node == pause) {
            [self togglePause];
        }
    }
   
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouseManager touchesMoved:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouseManager touchesEnded:touches withEvent:event];
}

- (void)update:(CFTimeInterval)currentTime {
    [shipManager update:currentTime];
    [background update:currentTime];
    
}

- (void)spawnType:(NSUInteger)type{
    Ship *ship = NULL;
    switch (type) {
        case NORMAL:
            ship = [[Ship alloc] init];
            break;
            
        default:
            ship = [[Ship alloc] init];
            break;
    }
    if (ship != NULL) {
        [shipManager addNode:ship];
        [self addChild:ship];
        [ship move];
    } else {
        NSLog(@"null ship");
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
