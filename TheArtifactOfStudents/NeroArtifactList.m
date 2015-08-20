//
//  NeroArtifactList.m
//  TheArtifactOfStudents
//
//  Created by 谭峻强 on 15/8/9.
//  Copyright (c) 2015年 TanJunqiang. All rights reserved.
//

#import "NeroArtifactList.h"
#import "NeroArtifactItem.h"

@implementation NeroArtifactList

/**
 *  初始化
 */
-(id)init{
    if((self = [super init])){
        self.items =[[NSMutableArray alloc] initWithCapacity:20];
        self.deletedFlag = 0;
    }
    return self;
}

/**
 *  空了几项
 */
- (int)countUncheckedItems{
    int count =0;
    for(NeroArtifactItem *item in self.items){
        if (!item.checked) {
            count+=1;
        }
    }
    return count;
}

/**
 *  拿到数据并赋值
 */
- (id)initWithCoder:(NSCoder *)neroCoder{
    if ((self = [super init])) {
        self.date = [neroCoder decodeObjectForKey:@"date"];
        self.items = [neroCoder decodeObjectForKey:@"Items"];
        self.bijao = [neroCoder decodeObjectForKey:@"bijiao"];
        self.beisong = [neroCoder decodeObjectForKey:@"beisong"];
        self.ciyao = [neroCoder decodeObjectForKey:@"ciyao"];
        self.deletedFlag = [neroCoder decodeIntegerForKey:@"DeletedFlag"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)neroCoder{
    [neroCoder encodeObject:self.date forKey:@"date"];
    [neroCoder encodeObject:self.items forKey:@"Items"];
    [neroCoder encodeObject:self.bijao forKey:@"bijiao"];
    [neroCoder encodeObject:self.beisong forKey:@"beisong"];
    [neroCoder encodeObject:self.ciyao forKey:@"ciyao"];
    [neroCoder encodeInteger:self.deletedFlag forKey:@"DeletedFlag"];
}

@end
