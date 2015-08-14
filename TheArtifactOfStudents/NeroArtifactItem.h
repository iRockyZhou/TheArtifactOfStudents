//
//  NeroArtifactItem.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NeroArtifactItem : NSObject<NSCoding>

// 当天作业的特性
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *nextTask;
@property (nonatomic,assign) BOOL checked;
@property (nonatomic,copy)NSDate *dueDate;
@property (nonatomic,assign)BOOL shouldRemind;
@property (nonatomic,assign)NSInteger itemId;

- (void)toggleChecked;
- (void)scheduleNotification:(NSString *)className;
- (UILocalNotification *)notificationForThisItem;

@end
