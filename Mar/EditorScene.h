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
#import "LevelData.h"
#import <MessageUI/MessageUI.h>

@interface EditorScene : SKScene<EDSelectionDelegate, UIGestureRecognizerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {
    LevelData *levelData;
    Background *background;
    Lighthouse *lighthouse;
    
    
    EDSelection *edSelection;
    SKNode *currentSelectedNode;
    
    SKSpriteNode *addButton;
    BOOL isAddMenu;
    
    SKSpriteNode *confirm;
    BOOL isConfirmMenu;
    
    SKSpriteNode *edit;
    BOOL isEditing;
    BOOL showingEditButton;
    
    SKSpriteNode *deleteButton;
    BOOL isDeleteMode;
    BOOL isShowingDelete;
    
    SKSpriteNode *saveButton;
    SKSpriteNode *loadButton;
        
}
- (void)toggleAddMenu;
@end