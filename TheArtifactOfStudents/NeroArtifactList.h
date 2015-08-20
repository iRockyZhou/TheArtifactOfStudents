//
//  NeroArtifactList.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NeroArtifactList : NSObject<NSCoding>


// 新一天的作业内容
@property (nonatomic,strong )NSMutableArray *items;
//@property (nonatomic,copy   )NSString *name;
//@property (nonatomic,copy   )NSString *accountOfWebsite;
//@property (nonatomic,copy   )NSString *reminderOfPassword;
//@property (nonatomic,copy   )NSString *email;

@property (nonatomic,copy   )NSString *date;
@property (nonatomic,copy   )NSString *bijao;
@property (nonatomic,copy   )NSString *beisong;
@property (nonatomic,copy   )NSString *ciyao;

@property (nonatomic,assign )BOOL deletedFlag;

- (int)countUncheckedItems;

@end
