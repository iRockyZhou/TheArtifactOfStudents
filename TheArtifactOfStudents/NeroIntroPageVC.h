//
//  NeroIntroPageVC.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EAIntroView/EAIntroView.h>
#import "NeroDataModel.h"

@interface NeroIntroPageVC : UIViewController<EAIntroDelegate>
@property (nonatomic, strong) NeroDataModel *_dataModel;
@end
