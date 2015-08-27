//
//  GameScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "GameScene.h"
#import "Ship.h"
#import "BrokenFloatingNode.h"
#import "Wave.h"
#import "Sub.h"
#import "LevelSelectScene.h"

@implementation GameScene

- (id)initWithSize:(CGSize)size andFile:(NSString *)file {
    if (self = [super initWithSize:size]) {
        [self loadLevelFromFile:file];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    background = [[Background alloc] initWithImageNamed:@"sea2.png"];
    [self addChild:background];
    //[background addWaves];
}

- (void)loadLevelFromFile:(NSString *)fileName {
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;
    
    shipManager = [[NodeManager alloc] init];
    lighthouseManager = [[NodeManager alloc] init];

    pauseMenu = [[PauseMenu alloc] init];
    
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
    
    for (Rock *rock in levelData.rocks) {
        [self addChild:rock];
    }
    
    for (Sub *submarine in levelData.subs) {
        [shipManager addNode:submarine];
        [self addChild:submarine];
        [submarine setBubbleTarget:self];
        [submarine move];
        NSLog(@"added sub %@",submarine);
    }
    
    for (Fog *fog in levelData.fogs) {
        [self addChild:fog];
        [fog start];
    }
    
    NSLog(@"level Data %@",levelData);
    
    pause = [SKSpriteNode spriteNodeWithImageNamed:@"pause.png"];
    [pause setName:@"pause"];
    [pause setPosition:CGPointMake(WIDTH - pause.size.width - 10, HEIGHT - pause.size.width -10)];
    [pause setZPosition:20];
    [self addChild:pause];
}

- (void)togglePause {
    if (isPaused){
        NSLog(@"remove pauseMenu");
        [pauseMenu removeFromParent];
    } else {
        NSLog(@"add pausemenu");
        [self addChild:pauseMenu];
    }
    isPaused =!isPaused;
    
    for (SKNode *node in self.children) {
        if (![node.name isEqualToString:NOT_AFFECTED_BY_PAUSE])
            [node setPaused:isPaused];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouseManager touchesBegan:touches withEvent:event];
    [pauseMenu touchesBegan:touches withEvent:event];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
         NSLog(@"touched %@",node.name);

        for (SKNode *n in  [self nodesAtPoint:location]) {
            NSLog(@"looking throu %@",n.name);
        }
        
        if (node == pause) {
            [self togglePause];
        } else if ([node isKindOfClass:[Sub class]]){
            Sub *sub = (Sub *)node;
            [sub reveal];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [lighthouseManager touchesMoved:touches withEvent:event];
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
    Sub *sub = NULL;
    switch (type) {
        case NORMAL:
            ship = [[Ship alloc] init];
            break;
            
        case SUBMARINE:
            sub = [[Sub alloc] init];
            break;
            
        default:
            ship = [[Ship alloc] init];
            NSLog(@"defaulted");
            break;
    }
    if (ship != NULL) {
        [shipManager addNode:ship];
        [self addChild:ship];
        [ship move];
    } else if (sub != NULL) {
        [shipManager addNode:sub];
        [self addChild:sub];
        [sub setPosition:[sub randomTopPosition]];
        [sub setBubbleTarget:self];
        [sub move];
    } else {
        NSLog(@"null ship");
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    NSLog(@"contact ended with %@ and %@ ",contact.bodyA.node.name, contact.bodyB.node.name);
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    FloatingNode *floatingNode;
    SKPhysicsBody *firstBody, *secondBody;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.node.parent == nil || secondBody.node.parent == nil) return;
    
    if ((firstBody.categoryBitMask & SPOT_LIGHT) != 0) {
         floatingNode = (FloatingNode*)secondBody.node;
        if ([floatingNode isKindOfClass:[Sub class]]) {
            Sub *sub = (Sub *)floatingNode;
            if (!sub.isUnderWater)
                [sub turnAround];
        } else {
            [floatingNode turnAround];
        }
    } else if ((firstBody.categoryBitMask & ROCKS) != 0) {
        NSLog(@"%@ hit rocks",secondBody.node.name);
        floatingNode = (FloatingNode*)secondBody.node;
        [shipManager removeNode:floatingNode];
        [floatingNode explode];
        BrokenFloatingNode *broken =[[BrokenFloatingNode alloc] initWithNode:floatingNode];
        [broken setPosition:contact.contactPoint];
        [self addChild:broken];
        [starController removeStar];
        floatingNode = NULL;
    } else {
        [self logContact:contact];
    }
}

- (void)logContact:(SKPhysicsContact *)contact {
    NSLog(@"contact: %@ and %@",contact.bodyA.node.name, contact.bodyB.node.name);
}

- (void)moveToLevelSelection {
    [shipManager destroyAll];
    [self removeAllChildren];
    LevelSelectScene *scene = [LevelSelectScene sceneWithSize:self.size];
    [self.view presentScene:scene transition:[SKTransition fadeWithColor:[UIColor blackColor] duration:0.4]];
}

@end
