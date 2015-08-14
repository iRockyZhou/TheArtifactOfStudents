//
//  ViewController.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NeroItemDetailVC.h"
#import <BFPaperCheckbox.h>


@class NeroArtifactList;

//@interface ViewController : UITableViewController <NeroItemDetailVCDelegate,BFPaperCheckboxDelegate>
@interface ViewController : UITableViewController <NeroItemDetailVCDelegate, BFPaperCheckboxDelegate>

@property (nonatomic, strong)NeroArtifactList *artifactList;
@end

