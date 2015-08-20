//
//  NeroArtifactItem.m
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroArtifactItem.h"
#import "NeroDataModel.h"
#import <UIKit/UIKit.h>

@implementation NeroArtifactItem
/**
 *  初始化
 */
- (id)init{
    if ((self=[super init])) {
        self.itemId = [NeroDataModel nextArtifactsItemId];
    }
    return self;
}
/**
 *  反转
 */
- (void)toggleChecked{
    self.checked = !self.checked;
}

/**
 *  安排提醒
 *
 *  @param className 科目名称
 */
- (void)scheduleNotification:(NSString *)className{
    UILocalNotification *exitingNotification = [self notificationForThisItem];
    if (exitingNotification != nil) {
        [[UIApplication sharedApplication]cancelLocalNotification:exitingNotification];
    }
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]]!=NSOrderedAscending) {
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        NSString *string = [className stringByAppendingString:self.text];
        NSString *string2 = [string stringByAppendingString:@" 即将 "];
        localNotification.alertBody =[string2 stringByAppendingString:self.nextTask];
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemId":@(self.itemId)};
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    }
}

/**
 *  配置提醒
 *
 *  @return notification
 */
- (UILocalNotification *)notificationForThisItem{
    NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotifications) {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemId"];
        if (number != nil && [number integerValue]==self.itemId) {
            return notification;
        }
    }
    return nil;
}

/**
 *  拿到数据并赋值
 */
- (id)initWithCoder:(NSCoder *)neroCoder
{
    if( (self = [super init]) ) {
        self.text = [neroCoder decodeObjectForKey:@"Text"];
        self.nextTask = [neroCoder decodeObjectForKey:@"NextTask"];
        self.checked =[neroCoder decodeBoolForKey:@"Checked"];
        self.dueDate = [neroCoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [neroCoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [neroCoder decodeIntegerForKey:@"ItemId"];
    }
    return self;
}

/**
 *  拿到数据并赋值
 */
- (void)encodeWithCoder:(NSCoder *)neroCoder
{
    [neroCoder encodeObject:self.text forKey:@"Text"];
    [neroCoder encodeObject:self.nextTask forKey:@"NextTask"];
    [neroCoder encodeBool:self.checked forKey:@"Checked"];
    [neroCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [neroCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [neroCoder encodeInteger:self.itemId forKey:@"ItemId"];
}

- (void)dealloc{
}

@end
