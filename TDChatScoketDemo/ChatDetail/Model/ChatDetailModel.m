//
//  ChatDetailModel.m
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatDetailModel.h"

@implementation ChatDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

- (instancetype)init
{
    if (self = [super init]) {
        self.sendTime = getSendTime();
    }
    return self;
}

NS_INLINE NSString *getSendTime() {
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%llu",recordTime];
}

@end


@implementation ChatContentModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end









