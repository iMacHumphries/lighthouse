//
//  EditorScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EditorScene.h"

@implementation EditorScene

NSString * const ADD = @"add";
NSString * const CONFIRM = @"confirm";
NSString * const EDIT = @"edit";
NSString * const DELETE = @"delete";
NSString * const SAVE = @"save";
NSString * const SCENE = @"scene";

- (void)didMoveToView:(SKView *)view {
    [self setName:SCENE];
    background = [[Background alloc] initWithImageNamed:@"water.png"];
    [background setSize:CGSizeMake(WIDTH - 100, HEIGHT - 100)];
    [self addChild:background];
    
    addButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [addButton setName:ADD];
    [addButton setZPosition:10];
    [addButton setPosition:CGPointMake(addButton.size.width + 5, addButton.size.height + 5)];
    SKLabelNode *la =[SKLabelNode labelNodeWithText:@"+"];
    [la setName:ADD];
    [addButton addChild:la];
    [self addChild:addButton];
    
    edSelection = [[EDSelection alloc] initWithImageNamed:@"selectionMenu.png"];
    [edSelection setDelegate:self];
    
    currentSelectedNode = NULL;
    
    confirm = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [confirm setPosition:CGPointMake(WIDTH - confirm.size.width - 5, addButton.position.y)];
    [confirm setColorBlendFactor:0.8f];
    [confirm setColor:[UIColor greenColor]];
    [confirm setName:CONFIRM];
    [confirm setZPosition:11];
    
    
    edit = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [edit setPosition:CGPointMake(confirm.position.x - edit.size.width - 20, confirm.position.y)];
    [edit setColorBlendFactor:0.8f];
    [edit setColor:[UIColor blueColor]];
    [edit setName:EDIT];
    [edit setZPosition:11];
    SKLabelNode *editLA = [SKLabelNode labelNodeWithText:@"Edit"];
    [editLA setName:EDIT];
    [edit addChild:editLA];
    

    deleteButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [deleteButton setPosition:CGPointMake(edit.position.x - deleteButton.size.width - 20, edit.position.y)];
    [deleteButton setColorBlendFactor:0.8f];
    [deleteButton setColor:[UIColor redColor]];
    [deleteButton setName:DELETE];
    [deleteButton setZPosition:11];
    SKLabelNode *delLA = [SKLabelNode labelNodeWithText:@"Delete"];
    [delLA setName:DELETE];
    [deleteButton addChild:delLA];
    
    saveButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [saveButton setPosition:CGPointMake(addButton.position.x, HEIGHT - saveButton.size.height - 20)];
    [saveButton setColorBlendFactor:0.8f];
    [saveButton setColor:[UIColor greenColor]];
    [saveButton setName:SAVE];
    [saveButton setZPosition:11];
    SKLabelNode *saveL = [SKLabelNode labelNodeWithText:@"Save"];
    [saveL setName:SAVE];
    [saveButton addChild:saveL];
    [self addChild:saveButton];

    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotateGesture];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPress.delegate      =   self;
    longPress.minimumPressDuration = 0.7;
    [self.view addGestureRecognizer:longPress];
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer {
    if (isEditing && currentSelectedNode) {
        [currentSelectedNode runAction:[SKAction rotateByAngle:-[recognizer rotation] duration:0.0f]];
        [recognizer setRotation:0.0];
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {

    if (isEditing && currentSelectedNode) {
        if (sender.state == UIGestureRecognizerStateChanged) {
           [currentSelectedNode runAction:[SKAction scaleBy:[sender scale] duration:0.0f]];
            sender.scale =1;
        }
        if (sender.state == UIGestureRecognizerStateEnded) {
            [currentSelectedNode removeAllActions];
        }
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognicer{
     if (isEditing && currentSelectedNode) {
          [self toggleDeleteMode];
     }
}


- (void)toggleConfirm {
    if (isConfirmMenu) {
        [confirm removeFromParent];
    }
    else
        [self addChild:confirm];
    
    isConfirmMenu = !isConfirmMenu;
}

- (void)toggleAddMenu {
    if (isAddMenu) {
        [edSelection removeFromParent];
    }
    else {
        [self addChild:edSelection];
        if (isConfirmMenu)
            [self toggleConfirm];
    }
    
    isAddMenu = !isAddMenu;
}

- (void)toggleEdit {
    if (showingEditButton) {
        [edit removeFromParent];
        NSLog(@"not editing anymore");
    }
    else {
        [self addChild:edit];
         NSLog(@"starting to edit");
    }
    
    showingEditButton = !showingEditButton;
    isEditing = !showingEditButton;
}

- (void)toggleDeleteMode {
    if (isShowingDelete) {
        [deleteButton removeFromParent];
    }
    else {
        [self addChild:deleteButton];
    }
    
    isShowingDelete = !isShowingDelete;
    isDeleteMode = !isShowingDelete;
}

- (void)confirmPressed {
    [self toggleConfirm];
    [self singleSelectionEnded];
    currentSelectedNode = NULL;
}

- (void)addPressed {
    [self toggleAddMenu];
    [self singleSelectionEnded];
    currentSelectedNode = NULL;
}

- (void)editPressed {
    [self toggleEdit];
    
}

- (void)deletePressed {
    [self toggleDeleteMode];
    if (currentSelectedNode)
        [currentSelectedNode removeFromParent];
    [self singleSelectionEnded];
}

- (void)savePressed {
    [self saveGame];
}

- (BOOL)isMainUI:(SKNode *)node {
    if (!node) return false;
    return ([node.name isEqualToString:ADD] || [node.name isEqualToString:CONFIRM] || [node.name isEqualToString:@"background"] || [node.name isEqualToString:SCENE] || [node.name isEqualToString:EDIT] || [node.name isEqualToString:@"edSelection"] || [node.name isEqualToString:DELETE] || [node.name isEqualToString:SAVE]);
}

- (void) selectNode:(SKNode *)node {
    currentSelectedNode = node;
    if (!node) return;
    
    if (!showingEditButton)
        [self toggleEdit];
    
    if (!isShowingDelete)
        [self toggleDeleteMode];
    
    if (!isConfirmMenu)
        [self toggleConfirm];
    if ([node isKindOfClass:[SKSpriteNode class]]) {
        SKSpriteNode *sprite = (SKSpriteNode *)node;
        [sprite setColorBlendFactor:0.7f];
        [sprite setColor:[UIColor purpleColor]];
    }
}

- (void)singleSelectionEnded {
    if (showingEditButton)
        [self toggleEdit];
    if (isShowingDelete)
        [self toggleDeleteMode];
    if (isConfirmMenu)
        [self toggleConfirm];
    
    if (currentSelectedNode) {
        if ([currentSelectedNode isKindOfClass:[SKSpriteNode class]]){
            SKSpriteNode*node =(SKSpriteNode *)currentSelectedNode;
            [node setColorBlendFactor:0.0f];
        }
    }
}

- (void)selectionEndedWithNode:(SKNode *)node {
    [self toggleAddMenu];
    currentSelectedNode = node;
    if (node) {
        [currentSelectedNode setZPosition:10];
        [self addChild:currentSelectedNode];
        [self selectNode:node];
    }
   
}

- (void)moveWithSelectedNode:(CGPoint)location {
    if (!isEditing) {
        [currentSelectedNode setPosition:location];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [edSelection touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if ([node.name isEqualToString:ADD]) {
            [self addPressed];
        } else if ([node.name isEqualToString:CONFIRM]) {
            [self confirmPressed];
        } else if ([node.name isEqualToString:EDIT]) {
            [self editPressed];
        } else if ([node.name isEqualToString:DELETE]) {
            [self deletePressed];
        } else if ([node.name isEqualToString:SAVE]) {
            [self savePressed];
        } else if (currentSelectedNode) {
            [self moveWithSelectedNode:location];
        } else if (![self isMainUI:node]) {
            [self selectNode:node];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (currentSelectedNode) {
            [self moveWithSelectedNode:location];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)update:(NSTimeInterval)currentTime {

}

- (void)saveGame {
    NSLog(@"saving game...");
    LevelData *levelData = [LevelData sharedLevelData];
    [levelData setLevel:1];
    [levelData setShips:[self ships]];
    [levelData setRocks:[self rocks]];
    [levelData setLighthouses:[self lighthouses]];
    [levelData save];
    
}

- (NSMutableArray *)ships {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Ship *s in self.children) {
        [result addObject:s];
    }
    return result;
}
- (NSMutableArray *)lighthouses {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Lighthouse *lh in self.children) {
        [result addObject:lh];
    }
    return result;
}
- (NSMutableArray *)rocks {
    return NULL;
}

@end
