//
//  NeroItemDetailVC.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeroItemDetailVC;
@class NeroArtifactItem;

@protocol NeroItemDetailVCDelegate <NSObject>
- (void) itemDetailViewControllerdidCancel:(NeroItemDetailVC *)controller;
- (void) itemDetailViewController:(NeroItemDetailVC *)controller didFinishAddingItem:(NeroArtifactItem *)item;
- (void) itemDetailViewController:(NeroItemDetailVC *)controller didFinishEditingItem:(NeroArtifactItem *)item;
@end

@interface NeroItemDetailVC : UITableViewController<UITextFieldDelegate>

@property (nonatomic, strong) NeroArtifactItem *itemToEdit;
@property (nonatomic, strong) NSString *workName;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *nextTaskTextField;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *saveBarButton;
@property (nonatomic, weak) IBOutlet UISwitch *switchControl;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;

@property (nonatomic, weak) id <NeroItemDetailVCDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)Save:(id)sender;
@end
