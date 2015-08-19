//
//  EditorScene.m
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "EditorScene.h"
#import "Ship.h"
#import "MenuScene.h"


@implementation EditorScene

static NSString * const UI = @"ui";
static NSString * const DETAIL = @"detail";
static NSString * const LABEL = @"label";
static NSString * const ON_TIME_LINE = @"onTimeLine";
static NSString * const ADD = @"add";
static NSString * const CONFIRM = @"confirm";
static NSString * const EDIT = @"edit";
static NSString * const DELETE = @"delete";
static NSString * const SHOW_HIDE = @"show/hide";
    static NSString * const EMAIL = @"Email";
    static NSString * const LOAD = @"Load";
    static NSString * const NEW = @"New";
    static NSString * const EXIT = @"Exit";
static NSString * const SCENE = @"scene";
static NSString * const SPAWNER = @"spawner.png";

static NSString * const RESET = @"Shut up Ben, I know what I am doing...";


- (void)didMoveToView:(SKView *)view {
    currentSelectedNode = NULL;
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
    
    timeLine = [[EDTimeLine alloc] initWithImageNamed:@"timeLine.png"];
    [self addChild:timeLine];
    
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
    
    showHideButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
    [showHideButton setPosition:CGPointMake(addButton.position.x, HEIGHT - showHideButton.size.height - 20)];
    [showHideButton setColorBlendFactor:0.8f];
    [showHideButton setColor:[UIColor greenColor]];
    [showHideButton setName:SHOW_HIDE];
    [showHideButton setZPosition:11];
    showHideLabel = [SKLabelNode labelNodeWithText:@">"];
    [showHideLabel setName:SHOW_HIDE];
    [showHideButton addChild:showHideLabel];
    [self addChild:showHideButton];
    showHideButtons= [[NSMutableArray alloc] init];
    
    popUp = [[EDPopUpDetail alloc] init];
    
    [self addButtonsToShowHideMenuWithTitles:[NSArray arrayWithObjects:EMAIL, LOAD, NEW, EXIT, nil]];
    
    UIRotationGestureRecognizer *rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:rotateGesture];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinch];
    
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer {
    if ( currentSelectedNode) {
        [currentSelectedNode runAction:[SKAction rotateByAngle:-[recognizer rotation] duration:0.0f]];
        [recognizer setRotation:0.0];
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {

    if ( currentSelectedNode) {
        if (sender.state == UIGestureRecognizerStateChanged) {
           [currentSelectedNode runAction:[SKAction scaleBy:[sender scale] duration:0.0f]];
            sender.scale =1;
        }
        if (sender.state == UIGestureRecognizerStateEnded) {
            [currentSelectedNode removeAllActions];
        }
    }
}


- (void)removeAllNonUI {
    for (SKNode *node in self.children) {
        if (![self isMainUI:node])
            [node removeFromParent];
    }
}

- (BOOL)isMainUI:(SKNode *)node {
    //fix this...
    if (!node) return false;
    return ([node.name isEqualToString:ADD] || [node.name isEqualToString:CONFIRM] || [node.name isEqualToString:@"background"] || [node.name isEqualToString:SCENE] || [node.name isEqualToString:EDIT] || [node.name isEqualToString:@"edSelection"] || [node.name isEqualToString:DELETE] || [node.name isEqualToString:EMAIL] || [node.name isEqualToString:LOAD] || [node.name isEqualToString:SHOW_HIDE] || [node.name isEqualToString:NEW] || [node.name isEqualToString:UI] || [node.name isEqualToString:EXIT]);
}

- (void)addButtonsToShowHideMenuWithTitles:(NSArray *)titles {
    int buttonCount = titles.count;
    
    for (int i =0; i < buttonCount; i++) {
        SKSpriteNode *newButton = [SKSpriteNode spriteNodeWithImageNamed:@"tempButton.png"];
        [newButton setPosition:CGPointMake(showHideButton.position.x + (10 *(i+1)) + (newButton.size.width *(i+1)), showHideButton.position.y)];
        [newButton setColorBlendFactor:0.65f];
        [newButton setColor:[UIColor greenColor]];
        [newButton setName:titles[i]];
        [newButton setZPosition:11];
        [newButton setScale:0.5];
        SKLabelNode *label = [SKLabelNode labelNodeWithText:titles[i]];
        [label setName:titles[i]];
        [newButton addChild:label];
        [showHideButtons addObject:newButton];
    }
}

- (void)toggleShowHideMenu {
    if (isShow) {
        [showHideLabel setText:@">"];
        for (int i =0;i<showHideButtons.count;i++) {
            SKSpriteNode *node = [showHideButtons objectAtIndex:i];
            [node runAction:[SKAction sequence:@[ [SKAction scaleTo:0.5 duration:0.1+(i *0.05)],
                                                  [SKAction moveTo:showHideButton.position duration:0.1+(i *0.05)],
                                                  [SKAction removeFromParent]
                                                  ]]];
        }
    } else {
        [showHideLabel setText:@"<"];
        for (int i =0;i<showHideButtons.count;i++) {
            SKSpriteNode *node = [showHideButtons objectAtIndex:i];
            CGPoint pos = CGPointMake(showHideButton.position.x + (10 *(i+1)) + (node.size.width *(i+1))*2, showHideButton.position.y);
           
            [node setScale:0.5];
            [node setPosition:showHideButton.position];
            [self addChild:node];
            [node runAction:[SKAction sequence:@[ [SKAction moveTo:pos duration:0.1 +(i *0.05)],
                                                  [SKAction scaleTo:1 duration:0.1 +(i *0.05)]
                                                  ]]];
        }
    }
    isShow = !isShow;
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
        [edSelection setScale:0.3];
        [edSelection runAction:[SKAction scaleTo:1 duration:0.2]];
        if (isConfirmMenu)
            [self toggleConfirm];
    }
    
    isAddMenu = !isAddMenu;
}

- (void)togglePopUpDetail {
    if (isPopUpDetail) {
        [popUp removeFromParent];
    } else {
        if ([currentSelectedNode isKindOfClass:[Spawner class]])
             [currentSelectedNode addChild:popUp];
    }
    isPopUpDetail = !isPopUpDetail;
}

- (void)toggleEdit {
    if (showingEditButton)
        [edit removeFromParent];
    else
        [self addChild:edit];
    
    showingEditButton = !showingEditButton;
    isEditing = !showingEditButton;
}

- (void)toggleDeleteMode {
    if (isShowingDelete)
        [deleteButton removeFromParent];
    else
        [self addChild:deleteButton];
    
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
    [self togglePopUpDetail];
}

- (void)deletePressed {
    [self toggleDeleteMode];
    if (currentSelectedNode)
        [currentSelectedNode removeFromParent];
    [self singleSelectionEnded];
}

- (void)showHidePressed {
    [self toggleShowHideMenu];
}

- (void)emailPressed {
    [self saveGame];
    [self emailToMe];
}

- (void)loadPressed {
    NSError *error = nil;
    NSString *folderPath = [[[NSBundle mainBundle] resourcePath]
                                stringByAppendingPathComponent:@"levels"];
    
    NSArray  *contents = [[NSFileManager defaultManager]
                                    contentsOfDirectoryAtPath:folderPath error:&error];
    if (error)
        NSLog(@"ERROR :%@",[error localizedDescription]);
   
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"levels" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (NSString *title in contents) {
        [action addButtonWithTitle:title];
    }
    
    [action showInView:self.view.window.rootViewController.view];
}

- (void)newPressed {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure Mariah?" message:@"This will erase this current level" delegate:self cancelButtonTitle:@"NO WAIT!" otherButtonTitles:RESET, nil];
    [alert show];
}

- (void)exitPressed {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure you want to exit?" message:@"This will erase this current level, so make sure you have emailed it" delegate:self cancelButtonTitle:@"NO WAIT!" otherButtonTitles:EXIT, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:RESET]) {
        [self removeAllNonUI];
        [self singleSelectionEnded];
    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:EXIT]) {
        MenuScene *scene = [MenuScene sceneWithSize:self.view.frame.size];
        SKTransition *tran = [SKTransition doorwayWithDuration:1];
        [self.view presentScene:scene transition:tran];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) return;
    NSError *error = nil;
    NSString *folderPath = [[[NSBundle mainBundle] resourcePath]
                            stringByAppendingPathComponent:@"levels"];
    
    NSArray  *contents = [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:folderPath error:&error];
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"levels/%@",[contents objectAtIndex:buttonIndex-1]] ofType:@""];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self loadContent:content];
}

- (void)loadContent:(NSString *)content {
    [self removeAllNonUI];
    NSError *jsonError;
    NSData *objectData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    if (jsonError)
        NSLog(@"error %@",[jsonError localizedDescription]);
    
    levelData = [[LevelData alloc] initWithDictionary:json];
    int i = 0;
    for (Ship *ship in levelData.ships) {
        [self addChild:ship];
        SKLabelNode *label = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"ship%i",[self shipsCount]]];
        [label setName:LABEL];
        [label setUserInteractionEnabled:NO];
        [ship addChild:label];
        [timeLine addNodeOnTimeLine:ship withTime:ship.waitTime];
        i++;
    }
    for (Lighthouse *lh in levelData.lighthouses) {
        [self addChild:lh];
    }
   
}

- (void) selectNode:(SKNode *)node {
    [self singleSelectionEnded];
    currentSelectedNode = node;
    if (!node) return;
    
    if (!isShowingDelete)
        [self toggleDeleteMode];
    
    if (!isConfirmMenu)
        [self toggleConfirm];
    
    if (!showingEditButton)
        [self toggleEdit];
    
    if ([node isKindOfClass:[SKSpriteNode class]]) {
        SKSpriteNode *sprite = (SKSpriteNode *)node;
        [sprite setColorBlendFactor:0.7f];
        [sprite setColor:[UIColor purpleColor]];
    }
}

- (void)singleSelectionEnded {
    if (isShowingDelete)
        [self toggleDeleteMode];
    if (isConfirmMenu)
        [self toggleConfirm];
    if (showingEditButton)
        [self toggleEdit];
    
    if (currentSelectedNode) {
        if ([currentSelectedNode isKindOfClass:[SKSpriteNode class]]){
            SKSpriteNode*node =(SKSpriteNode *)currentSelectedNode;
            [node setColorBlendFactor:0.0f];
        }
    }
}

- (void)selectionEndedWithNode:(SKNode *)node {
    [self toggleAddMenu];
    if ([node isKindOfClass:[Ship class]]) {
        SKLabelNode *label = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"ship%i",[self shipsCount]]];
        [label setName:LABEL];
        [label setUserInteractionEnabled:NO];
        [node addChild:label];
        [timeLine addNodeOnTimeLine:node];
    }
   
    if (![node.name isEqualToString:SPAWNER]) {
        currentSelectedNode = node;
        [currentSelectedNode setZPosition:10];
        [self addChild:currentSelectedNode];
        [self selectNode:node];
    } else {
         SKLabelNode *label = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"spawner%i",spawnerCount]];
        [label setFontSize:0.0f];
        [node addChild:label];
        [timeLine addNodeOnTimeLine:node];
        spawnerCount++;
    }
}

- (void)moveWithSelectedNode:(CGPoint)location {
    if ([currentSelectedNode.name isEqualToString:ON_TIME_LINE])
        isLockY = true;
    else
        isLockY = false;
    
    if (!isEditing) {
        if (isLockY) {
            [currentSelectedNode setPosition:CGPointMake(location.x, currentSelectedNode.position.y)];
             [timeLine updateTextForNode:currentSelectedNode];
        }
        else {
            [currentSelectedNode setPosition:location];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [timeLine updateTextForNode:NULL];
    [popUp touchesBegan:touches withEvent:event];
    [edSelection touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        if ([touch tapCount] > 1) return;
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        while (node.parent != NULL && ![self isMainUI:node.parent])
            node = node.parent;
        
        
        if ([node.name isEqualToString:ADD]) {
            [self addPressed];
        } else if ([node.name isEqualToString:CONFIRM]) {
            [self confirmPressed];
        } else if ([node.name isEqualToString:EDIT]) {
            [self editPressed];
        } else if ([node.name isEqualToString:DELETE]) {
            [self deletePressed];
        } else if ([node.name isEqualToString:EMAIL]) {
            [self emailPressed];
        } else if ([node.name isEqualToString:LOAD]) {
            [self loadPressed];
        } else if ([node.name isEqualToString:NEW]) {
            [self newPressed];
        } else if ([node.name isEqualToString:EXIT]) {
            [self exitPressed];
        } else if ([node.name isEqualToString:SHOW_HIDE]) {
            [self showHidePressed];
        } else if (![self isMainUI:node]) {
            [self selectNode:node];
        } else if (currentSelectedNode) {
            [self moveWithSelectedNode:location];
        }

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [popUp touchesMoved:touches withEvent:event];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (currentSelectedNode && [touch tapCount] <= 1) {
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
    [self saveShipTimes];
    [self saveSpawners];
    
    levelData = [[LevelData alloc] init];
    [levelData setLevel:1];
    [levelData setShips:[self ships]];
    [levelData setRocks:[self rocks]];
    [levelData setLighthouses:[self lighthouses]];
    [levelData setSpawners:[self spawners]];
   
    [self emailToMe];
}

- (void)saveSpawners {
    for (Spawner *spawner in [self spawners]) {
        [spawner setWaitTime:[timeLine getTimeForNode:spawner]];
    }
}

- (void)saveShipTimes {
    for (Ship *ship in [self ships]) {
        float wait = [timeLine getTimeForNode:ship];
        NSLog(@"saving wait %f", wait);
        [ship setWaitTime:wait];
    }
}

- (NSMutableArray*)querySceneForClass:(Class)c notEqualTo:(NSString *)name {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (SKNode *s in self.children) {
        if ([s isKindOfClass:c])
            if (![s.name isEqualToString:name]) {
                [result addObject:s];
            }
    }
    return result;
}

- (NSMutableArray *)ships {
    return [self querySceneForClass:[Ship class] notEqualTo:ON_TIME_LINE];
    
}
- (NSMutableArray *)lighthouses {
    return [self querySceneForClass:[Lighthouse class] notEqualTo:@"null"];
}

- (NSMutableArray *)spawners {
     return [self querySceneForClass:[Spawner class] notEqualTo:@"null"];
}

- (NSMutableArray *)rocks {
    return [self querySceneForClass:[Rock class] notEqualTo:@"null"];
}

- (int)shipsCount {
    return [[self ships] count];
}

- (int)lighthousesCount {
    return [[self lighthouses] count];
}

- (int)rocksCount {
    return [[self rocks] count];
}

- (void)emailToMe {
    
    NSString *emailTitle = [NSString stringWithFormat:@"level %i", levelData.level];
    NSString *messageBody = @"Here is the file buddy: ";
    NSArray *toRecipents = [NSArray arrayWithObject:@"imachumphries@me.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    NSString* dataString =[levelData encodeJSON];
    [mc addAttachmentData:[dataString dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"txt" fileName:emailTitle];
    
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self.view.window.rootViewController dismissViewControllerAnimated:NO completion:^{
        
    }];
    
}

@end