//
//  NeroDataModel.m
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroDataModel.h"
#import "NeroDataModel.h"
#import "NeroArtifactList.h"
#import "NeroArtifactItem.h"

@implementation NeroDataModel

/**
 *  初始化
 */
- (id)init{
    if ((self = [super init])) {
        [self loadArtifacts];
        [self updateShouldRemind];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}


/**
 *  @return 下个Artifact的id
 */
+ (NSInteger)nextArtifactsItemId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger itemId = [userDefaults integerForKey:@"ArtifactsItemId"];
    [userDefaults setInteger:(itemId + 1) forKey:@"ArtifactsItemId"];
    [userDefaults synchronize];
    return itemId;
}

/**
 *  配置默认设置
 */
- (void)registerDefaults
{
    NSDictionary *dictionary = @{@"ArtifactIndex":@-1,@"FirstTime":@YES,@"ArtifactsItemId":@0};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary];
}

- (void)handleFirstTime
{
    // 待
}


/**
 *  过期提醒检测
 */
- (void)updateShouldRemind{
    for (NeroArtifactList *artifactList in self.artifacts){
        for (NeroArtifactItem *artifactsItem in artifactList.items) {
            if (artifactsItem.shouldRemind == YES && [artifactsItem.dueDate timeIntervalSinceNow] <= 0) {
                artifactsItem.shouldRemind = NO;
            }
        }
    }
}

/**
 *  对应key拿到选择的cell
 */
- (NSInteger)indexOfSelectedArtifactList{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ArtifactIndex"];
}

- (void)setIndexOfSelectedArtifactList:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ArtifactIndex"];
}

/**
 *  Step 1
 */
- (NSString *)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

/**
 *  Step 2
 */
-(NSString *)dataFilePath{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Artifacts.plist"];
}

/**
 *  Step 3.1
 */
- (void)saveArtifacts{
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_artifacts forKey:@"Artifacts"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

/**
 *  Step 3.2
 */
- (void)loadArtifacts{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        self.artifacts = [unarchiver decodeObjectForKey:@"Artifacts"];
        [unarchiver finishDecoding];
    }else{
        self.artifacts = [[NSMutableArray alloc]initWithCapacity:10];
    }
}




@end
