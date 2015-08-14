//
//  NeroAllListsVC.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeroListDetailVC.h"

@class  NeroDataModel;

@interface NeroAllListsVC : UITableViewController<NeroListDetailVCDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)NeroDataModel *dataModel;

@end
