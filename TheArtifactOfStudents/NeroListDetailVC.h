//
//  NeroListDetailVC.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeroListDetailVC;
@class NeroArtifactList;

@protocol NeroListDetailVCDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(NeroListDetailVC *)controller;
- (void)listDetailViewController:(NeroListDetailVC *)controller didFinishAddingArtifactlist:(NeroArtifactList *)artifactList;
- (void)listDetailViewController:(NeroListDetailVC *)controller didFinishEditingArtifactList:(NeroArtifactList *)artifactList;
@end

@interface NeroListDetailVC : UITableViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UITextField *accountOfWebsiteTextField;
@property (nonatomic, weak) IBOutlet UITextField *reminderOfPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *saveBarButton;

@property (nonatomic, weak) id<NeroListDetailVCDelegate> delegate;
@property (nonatomic, strong) NeroArtifactList *artifactListToEdit;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
