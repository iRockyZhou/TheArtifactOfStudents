//
//  NeroAllListsVC.m
//  TheArtifactOfStudents
//  app首页
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroAllListsVC.h"
#import "NeroArtifactList.h"
#import "ViewController.h"
#import "NeroArtifactItem.h"
#import "NeroDataModel.h"
#import "NeroCellBGView.h"
#import <MCSwipeTableViewCell.h>
#import "AppDelegate.h"
#import "UIColor+Nero.h"

@interface NeroAllListsVC (){
    NSInteger cellHeight;
}

@property (weak, nonatomic) IBOutlet UILabel *allApplicationNumLabel;

@end

@implementation NeroAllListsVC

/**
 *  加载、更新数据
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateAllApplicationNum];
    [self.tableView reloadData];
    NSLog(@"Nero AllListsVC - will Appera");
}

/**
 *  拿到视图，进行定制
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    
    // 去除右边滚动条
    self.tableView.showsVerticalScrollIndicator =NO;
    NSInteger index = [self.dataModel indexOfSelectedArtifactList];
    if (index >=0 && index <[self.dataModel.artifacts count]) {
        NeroArtifactList *artifactList = self.dataModel.artifacts[index];
        [self performSegueWithIdentifier:@"ShowArtifactList" sender:artifactList];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateAllApplicationNum];
    
    cellHeight = 80;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [backgroundView setBackgroundColor:[UIColor colorWithSixteenColorNumber:@"e3e3e3"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // 隐藏cell间的黑线view
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)updateAllApplicationNum{
    NSInteger tempNum = 0;
    for (NeroArtifactList *artifactList in self.dataModel.artifacts){
        if(artifactList.deletedFlag == 0){
            for(NeroArtifactItem *artifactItem in artifactList.items){
                if (artifactItem.checked == 0) {
                    tempNum ++;
                }
            }
        }
    }
    self.allApplicationNumLabel.text=[NSString stringWithFormat:@"%ld个作业还没写完",(long)tempNum];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // 判断操作
    if ([segue.identifier isEqualToString:@"ShowArtifactList"]) {
        ViewController *controller = segue.destinationViewController;
        controller.artifactList = sender;
    }else if([segue.identifier isEqualToString:@"AddArtifactList"]){
        UINavigationController *navigationController = segue.destinationViewController;
        NeroListDetailVC *controller = (NeroListDetailVC *)navigationController.topViewController;
        controller.delegate = self;
        controller.artifactListToEdit = nil;
    }
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    MCSwipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[MCSwipeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            cell.separatorInset = UIEdgeInsetsZero;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [self setBackgroundViewForCell:cell];
        
        UILabel *label =[[UILabel alloc]init];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.tag = 123;
        [cell.contentView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        // AutoLayout - VFL
        NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[label]-|"
                                                                        options:0
                                                                        metrics:@{@"margin":@60}
                                                                          views:NSDictionaryOfVariableBindings(label)];
        NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                        options:0
                                                                        metrics:@{@"heigth":@40}
                                                                          views:NSDictionaryOfVariableBindings(label)];
        [cell.contentView addConstraints:constraints1];
        [cell.contentView addConstraints:constraints2];
        
    }
    
    
    [self configureTextForCell:cell withIndexPath:indexPath];
    [self configureStateOfCell:cell forRowAtIndexPath:indexPath ];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataModel.artifacts count];
}
#pragma mark - MCSwipeTableViewCell
- (void)configureTextForCell:(MCSwipeTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    [self updateAllApplicationNum];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:123];
    label.textColor =  [UIColor colorWithRed:204.0/255.0 green:153.0/255.0 blue:102.0/255.0 alpha:1];
    
    NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
    
    cell.textLabel.text = artifactList.date;
    cell.textLabel.font = [UIFont systemFontOfSize:22.0];
    // color1
//    cell.textLabel.textColor = [UIColor colorWithRed:130.0/255.0 green:18.0/255.0 blue:13.0/255.0 alpha:1];
    cell.textLabel.textColor = [UIColor colorWithSixteenColorNumber:@"82120d"];
    cell.detailTextLabel.textColor =  [UIColor colorWithSixteenColorNumber:@"666666"];
    
    if ([artifactList.items count] != 0) {
        NeroArtifactItem *artifactsItem = artifactList.items[0];
        
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMdd"];
        
        NSString *now=[dateFormatter stringFromDate:senddate];
        NSString *targetTime = [dateFormatter stringFromDate:artifactsItem.dueDate];
        
        NSInteger nowValue = [now integerValue];
        NSInteger targetTimeValue = [targetTime integerValue];
        
        if((targetTimeValue - nowValue) >= 31){
            NSDateFormatter *dateFormatterToShow = [[NSDateFormatter alloc] init];
            [dateFormatterToShow setDateFormat:@"M月d日 "];
            NSString *showTime = [dateFormatterToShow stringFromDate:artifactsItem.dueDate];
            label.text = [showTime stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) >= 3 && (targetTimeValue - nowValue) <= 30){
            NSString *string = [NSString stringWithFormat:@"%ld天后 ",(long)(targetTimeValue - nowValue)];
            label.text =[string stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) == 2){
            label.text = [@"后天 " stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) == 1){
            label.text = [@"明天 " stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) == 0){
            label.text = [@"今天 " stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) == -1){
            label.text=[@"昨天 " stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) == -2){
            label.text=[@"前天 " stringByAppendingString:artifactsItem.nextTask];
        }else if((targetTimeValue - nowValue) <= -3){
            label.text=[@"几天前 " stringByAppendingString:artifactsItem.nextTask];
        }
        
        
        cell.detailTextLabel.text = artifactsItem.text;
        
    }else{
        label.text=@"";
        cell.detailTextLabel.text = @"还没设置作业呢...";
    }
}

- (void)configureCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NeroArtifactList *artifactList= self.dataModel.artifacts[indexPath.row];
    UIView *checkView = [self viewWithImageName:@"check"];
    // color2
    UIColor *greenColor = [UIColor colorWithSixteenColorNumber:@"55d550"];
    
    UIView *crossView = [self viewWithImageName:@"cross"];
    UIColor *redColor = [UIColor colorWithSixteenColorNumber:@"55d550"];
    
    UIView *listView = [self viewWithImageName:@"list"];
    UIColor *brownColor = [UIColor colorWithSixteenColorNumber:@"ce9562"];
    
    // 颜色联动至tableView的BG
    [cell setDefaultColor:self.tableView.backgroundView.backgroundColor];
    [cell setDelegate:(id)self];
    
    if (artifactList.deletedFlag == 0) {
        [cell setSwipeGestureWithView:crossView
                                color:redColor
                                 mode:MCSwipeTableViewCellModeSwitch
                                state:MCSwipeTableViewCellState1
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode){
                          
                          [self changeStateofCell:cell];
                      }];
        [cell setSwipeGestureWithView:crossView
                                color:redColor
                                 mode:MCSwipeTableViewCellModeSwitch
                                state:MCSwipeTableViewCellState2
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode){
                          
                          [self changeStateofCell:cell];
                      }];
        
        [cell setSwipeGestureWithView:listView
                                color:brownColor
                                 mode:MCSwipeTableViewCellModeExit
                                state:MCSwipeTableViewCellState3
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
                          
                          UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
                          NeroListDetailVC *controller = (NeroListDetailVC *)navigationController.topViewController;
                          controller.delegate = self;
                          NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
                          controller.artifactListToEdit = artifactList;
                          [self presentViewController:navigationController animated:YES completion:nil];
                      }];
    }else if(artifactList.deletedFlag == 1){
        [cell setSwipeGestureWithView:checkView
                                color:greenColor
                                 mode:MCSwipeTableViewCellModeSwitch
                                state:MCSwipeTableViewCellState1
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode){
                          
                          [self changeStateofCell:cell];
                      }];
        [cell setSwipeGestureWithView:crossView
                                color:redColor
                                 mode:MCSwipeTableViewCellModeExit
                                state:MCSwipeTableViewCellState2
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode){
                          
                          [self deleteCell:cell];
                      }];
        [cell setSwipeGestureWithView:listView
                                color:brownColor
                                 mode:MCSwipeTableViewCellModeExit
                                state:MCSwipeTableViewCellState3
                      completionBlock:^(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode) {
                          
                          UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
                          NeroListDetailVC *controller = (NeroListDetailVC *)navigationController.topViewController;
                          controller.delegate = self;
                          NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
                          controller.artifactListToEdit = artifactList;
                          [self presentViewController:navigationController animated:YES completion:nil];
                      }];
    }
    cell.firstTrigger = 0.25;
    cell.secondTrigger = 0.5;
}

- (void)configureStateOfCell:(MCSwipeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
    if (artifactList.deletedFlag == 0) {
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:123];
        // color3
        label.textColor =  [UIColor colorWithSixteenColorNumber:@"ce9562"];
        cell.textLabel.textColor = [UIColor colorWithSixteenColorNumber:@"82120d"];
        cell.detailTextLabel.textColor =  [UIColor colorWithSixteenColorNumber:@"82120d"];
    }else if(artifactList.deletedFlag == 1){
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:123];
        label.textColor = [UIColor grayColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.textColor =  [UIColor grayColor];
    }
    [self updateAllApplicationNum];
}

/**
 *  设置继承自MCSwipeTableViewCell的cell的BG
 */
- (void)setBackgroundViewForCell:(MCSwipeTableViewCell *)cell{
    //UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, cellHeight)];
    //backgroundView = [(UIView *)[CellbackgroundVIew alloc]init];
    [cell setBackgroundView:[[NeroCellBGView alloc]init]];
}


- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

/**
 *  删除数据-cell
 */
- (void)deleteCell:(MCSwipeTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self cancelLocalNotificationIndex:indexPath.row];
    [self.dataModel.artifacts removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (void)cancelLocalNotificationIndex:(NSInteger)index{
    NeroArtifactList *artifactList = self.dataModel.artifacts[index];
    for (NeroArtifactItem *temp in artifactList.items){
        if (temp.shouldRemind == YES) {
            UILocalNotification *existingNotification = [temp notificationForThisItem];
            if (existingNotification != nil) {
                [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
            }
        }
    }
}

/**
 *  继承自MCSwipeTableViewCell的状态及细节设定
 */
- (void)changeStateofCell:(MCSwipeTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
    NSInteger disDeletedNum=0;
    for(NeroArtifactList *artifactListTemp in self.dataModel.artifacts){
        if (artifactListTemp.deletedFlag == 0) {
            disDeletedNum ++;
        }else{
            break;
        }
    }
    if (disDeletedNum == 0) {
        disDeletedNum =1;
    }
    if (artifactList.deletedFlag == 0) {
        artifactList.deletedFlag =1;
        [self configureStateOfCell:cell forRowAtIndexPath:indexPath];
        [self.dataModel.artifacts removeObjectAtIndex:indexPath.row];
        [self.dataModel.artifacts insertObject:artifactList atIndex:disDeletedNum-1];
        NSIndexPath *bottomIndexPath = [NSIndexPath indexPathForRow:disDeletedNum-1 inSection:0];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:bottomIndexPath];
    }else if(artifactList.deletedFlag == 1){
        artifactList.deletedFlag = 0;
        [self configureStateOfCell:cell forRowAtIndexPath:indexPath];
        [self configureCell:cell forRowAtIndexPath:indexPath];
        [self.dataModel.artifacts removeObjectAtIndex:indexPath.row];
        [self.dataModel.artifacts insertObject:artifactList atIndex:0];
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }
    
    NSInteger sum = [self.tableView numberOfRowsInSection:0];
    for (NSInteger i = 0; i < sum; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        MCSwipeTableViewCell *cell = (MCSwipeTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [self configureCell:cell forRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel setIndexOfSelectedArtifactList:indexPath.row];
    NeroArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self performSegueWithIdentifier:@"ShowArtifactList" sender:artifactList];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedArtifactList:-1];
    }
}

#pragma mark - ListDetailViewControllerDelegate
- (void)listDetailViewControllerDidCancel:(NeroListDetailVC *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(NeroListDetailVC *)controller didFinishAddingArtifactlist:(NeroArtifactList *)artifactList{
    //  NSInteger newRowIndex = [self.dataModel.artifacts count];
    [self.dataModel.artifacts insertObject:artifactList atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(NeroListDetailVC *)controller didFinishEditingArtifactList:(NeroArtifactList *)artifactList{
    NSInteger index = [self.dataModel.artifacts indexOfObject:artifactList];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    //cell.textLabel.text = artifactList.name;
    //ArtifactList *artifactList = self.dataModel.artifacts[indexPath.row];
    
    UILabel *textLabel = (UILabel *)[cell viewWithTag:2];
    textLabel.text = artifactList.date;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - longPressGesture
- (IBAction)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.dataModel.artifacts exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

@end
