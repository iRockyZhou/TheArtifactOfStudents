//
//  NeroDataModel.h
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NeroDataModel : NSObject

@property(nonatomic, strong) NSMutableArray *artifacts;

- (void)saveArtifacts;
- (NSInteger)indexOfSelectedArtifactList;
- (void)setIndexOfSelectedArtifactList:(NSInteger)index;
+ (NSInteger)nextArtifactsItemId;

@end
