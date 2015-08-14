//
//  NeroListDetailVC.m
//  TheArtifactOfStudents
//  今天的作业
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroListDetailVC.h"
#import "NeroArtifactList.h"
#import "NEroCellBGView.h"

@interface NeroListDetailVC ()
@end

@implementation NeroListDetailVC{
}

#pragma mark - 右滑编辑
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"NeroListDetail - will Appera");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.artifactListToEdit != nil)
    {
        self.title = @"编辑今天作业";
        self.textField.text = self.artifactListToEdit.date;
        self.accountOfWebsiteTextField.text = self.artifactListToEdit.bijao;
        self.reminderOfPasswordTextField.text = self.artifactListToEdit.beisong;
        self.emailTextField.text = self.artifactListToEdit.ciyao;
        self.saveBarButton.enabled = YES;
    }
    
    self.textField.tag = 30;
    self.accountOfWebsiteTextField.tag = 31;
    self.reminderOfPasswordTextField.tag = 32;
    self.emailTextField.tag = 33;
    
    self.textField.delegate = self;
    self.accountOfWebsiteTextField.delegate = self;
    self.reminderOfPasswordTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    // shadowColor阴影颜色
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;

    // shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(2.0f , 2.0f);

    // 阴影透明度，默认0
    self.navigationController.navigationBar.layer.shadowOpacity = 0.25f;

    // 阴影半径
    self.navigationController.navigationBar.layer.shadowRadius = 4.0f;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return indexPath;
    } else {
        return nil;
    }
}

- (void )tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 30) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        self.saveBarButton.enabled = ([newText length]>0);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag ==30) {
        [self.accountOfWebsiteTextField becomeFirstResponder];
    }else if (textField.tag == 31 ) {
        [self.reminderOfPasswordTextField becomeFirstResponder];
    }else if(textField.tag == 32){
        [self.emailTextField becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
}



#pragma mark - IBAction
- (IBAction)cancel:(id)sender{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)save:(id)sender{
    if (self.artifactListToEdit == nil) {
        NeroArtifactList *artifactList = [[NeroArtifactList alloc]init];
        artifactList.date = self.textField.text;
        artifactList.bijao = self.accountOfWebsiteTextField.text;
        artifactList.beisong = self.reminderOfPasswordTextField.text;
        artifactList.ciyao = self.emailTextField.text;
        [self.delegate listDetailViewController:self didFinishAddingArtifactlist:artifactList];
    }else{
        self.artifactListToEdit.date = self.textField.text;
        self.artifactListToEdit.bijao = self.accountOfWebsiteTextField.text;
        self.artifactListToEdit.beisong = self.reminderOfPasswordTextField.text;
        self.artifactListToEdit.ciyao = self.emailTextField.text;
        [self.delegate listDetailViewController:self didFinishEditingArtifactList:self.artifactListToEdit];
    }
}

- (id)initWithCoder:(NSCoder *)neroCoder{
    if ((self = [super initWithCoder:neroCoder])) {
        //_iconName = @"1";
    }
    return self;
}
@end
