//
//  AppDelegate.m
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//
//  类前缀: Nero
//

#import "AppDelegate.h"
#import "NeroAllListsVC.h"
#import "NeroDataModel.h"
#import "NeroArtifactList.h"
#import "NeroArtifactItem.h"
#import "NeroIntroPageVC.h"

@interface AppDelegate ()
@end

@implementation AppDelegate
{
    NeroDataModel *_dataModel;
}

/**
 *  启动完成后执行操作:
 *    - 初始化提醒
 *    - 初始化UI
 *    - 加载模型
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 启动界面停留1s
    [NSThread sleepForTimeInterval:1.0];
    
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    // iOS 8.0+可以通知中心提醒
    if (sysVersion>=8.0) {
        UIUserNotificationType type = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    _dataModel = [[NeroDataModel alloc]init];
    
    // 启动界面
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        // 初始化IntroPageVC
        NeroIntroPageVC *introPageViewController = [[NeroIntroPageVC alloc]init];
        introPageViewController._dataModel = _dataModel;
        self.window.rootViewController = introPageViewController;
    }else{
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navigationController = [storyBoard instantiateViewControllerWithIdentifier:@"FirstNavigationController"];
        navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor; //shadowColor阴影颜色
        navigationController.navigationBar.layer.shadowOffset = CGSizeMake(2.0f , 2.0f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
        navigationController.navigationBar.layer.shadowOpacity = 0.25f;//阴影透明度，默认0
        navigationController.navigationBar.layer.shadowRadius = 4.0f;//阴影半径
        
        // 初始化ALlListVC
        NeroAllListsVC *controller = navigationController.viewControllers[0];
        controller.dataModel = _dataModel;
        self.window.rootViewController = navigationController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}




- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{

}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

/**
 *  涉及模型
 */
- (void)saveData
{
    [_dataModel saveArtifacts];
}

/**
 *  app进入后台后保存数据
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveData];
    NSInteger tempNum = 0;
    for (NeroArtifactList *artifactList in _dataModel.artifacts){
        if(artifactList.deletedFlag == 0){
            for(NeroArtifactItem *artifactItem in artifactList.items){
                if (artifactItem.checked == 0) {
                    tempNum ++;
                }
            }
        }
    }
    [application setApplicationIconBadgeNumber:tempNum];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveData];
}

@end
