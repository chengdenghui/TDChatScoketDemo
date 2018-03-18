//
//  ChatListModel.h
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatListModel : NSObject

@property (nonatomic, strong) NSNumber *unreadCount; //未读数
@property (nonatomic, copy) NSString *lastMessage; //最后一条消息
@property (nonatomic, copy) NSString *lastTimeString; //最后一条消息时间

@end
