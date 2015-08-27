//
//  EditorScene.h
//  Mar
//
//  Created by Benjamin Humphries on 8/14/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PrefixHeader.pch"
#import "Background.h"
#import "Lighthouse.h"
#import "EDSelection.h"
#import "EDTimeLine.h"
#import "LevelData.h"
#import <MessageUI/MessageUI.h>
#import "EDSpawnerPopUp.h"
#import "EDFogPopUp.h"

@interface EditorScene : SKScene<EDSelectionDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
    LevelData *levelData;
    Background *background;
    Lighthouse *lighthouse;
    
    
    EDSelection *edSelection;
    SKNode *currentSelectedNode;
    
    EDTimeLine *timeLine;
    
    SKSpriteNode *addButton;
    BOOL isAddMenu;
    
    SKSpriteNode *confirm;
    SKSpriteNode *edit;
    SKSpriteNode *deleteButton;
    BOOL isEditing;
 
    SKSpriteNode *showHideButton;
    SKLabelNode *showHideLabel;
    NSMutableArray *showHideButtons;
    BOOL isShow;
    
    BOOL isLockY;
    
    int spawnerCount;
    
    EDSpawnerPopUp *popUp;
    EDFogPopUp *fogPopUp;
    BOOL isPopUpDetail;
    
    SKSpriteNode *centerX;
    SKSpriteNode *centerY;
    
    BOOL isBottomRightControl;

}
- (void)toggleAddMenu;
- (int)shipsCount;
@end

/**
 Adding new content to editor:
 Add in EDSelection.
 Fix LoadContent Method
 Fix SaveContent Method
 Make sure spawner class can spawn the new type.
 Add type to GameScene Loader method
 */
