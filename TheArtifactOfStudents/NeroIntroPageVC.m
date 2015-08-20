//
//  NeroIntroPageVC.m
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroIntroPageVC.h"
#import <EAIntroView/EAIntroView.h>
#import "AppDelegate.h"
#import "NeroAllListsVC.h"

static NSString * const sampleDescription1 = @"轻松作业整理，日记难度降低。";
static NSString * const sampleDescription2 = @"明早交什么，神器全知道。";
static NSString * const sampleDescription3 = @"作业完成，开心激励。";
static NSString * const sampleDescription4 = @"有了学生神器，妈妈再也不用担心我的学习了。";

@interface NeroIntroPageVC ()

@end

@implementation NeroIntroPageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showIntro];
    // Do any additional setup after loading the view.
}

/**
 *  配置欢迎界面
 */
- (void)showIntro
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"学生神器";
    page1.titleColor = [UIColor colorWithRed:255.0/255.0 green:77.0/255.0 blue:0.0 alpha:1];
    page1.desc = sampleDescription1;
    page1.descColor = [UIColor colorWithRed:255.0/255.0 green:77.0/255.0 blue:0.0 alpha:1];
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"学生神器";
    page2.titleColor = [UIColor blackColor];
    page2.desc = sampleDescription2;
    page2.descColor = [UIColor blackColor];
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"学生神器";
    page3.titleColor = [UIColor blackColor];
    page3.desc = sampleDescription3;
    page3.descColor = [UIColor blackColor];
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"学生神器";
    page4.titleColor = [UIColor blackColor];
    page4.desc = sampleDescription4;
    page4.descColor = [UIColor blackColor];
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds];
    [intro setDelegate:self];
    
    intro.skipButton.alpha = 0.f;
    intro.skipButton.enabled = NO;
    
    [intro setPages:@[page1,page2,page3,page4]];
    [intro showInView:self.view animateDuration:0.3];
}

- (void)introDidFinish:(EAIntroView *)introView
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationController = [storyBoard instantiateViewControllerWithIdentifier:@"FirstNavigationController"];
    navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor; //shadowColor阴影颜色
    navigationController.navigationBar.layer.shadowOffset = CGSizeMake(2.0f , 2.0f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    navigationController.navigationBar.layer.shadowOpacity = 0.25f;//阴影透明度，默认0
    navigationController.navigationBar.layer.shadowRadius = 4.0f;//阴影半径
    
    NeroAllListsVC *controller = navigationController.viewControllers[0];
    controller.dataModel = self._dataModel;
    
    [self addChildViewController:navigationController];
    [self.view addSubview:navigationController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
