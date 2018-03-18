//
//  ChatDetailModel.h
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatContentModel;

@interface ChatDetailModel : NSObject

@property (nonatomic, copy) NSString *groupID; //群ID

@property (nonatomic, copy) NSString *fromUserID; //消息发送者ID

@property (nonatomic, copy) NSString *toUserID;  //对方ID

@property (nonatomic, copy) NSString *fromPortrait; //发送者头像url

@property (nonatomic, copy) NSString *toPortrait; //对方头像url

@property (nonatomic, copy) NSString *nickName; //我对好友命名的昵称

@property (nonatomic, copy) NSArray<NSString *> *atToUserIDs; // @目标ID

@property (nonatomic, copy) NSString *messageType; //消息类型

@property (nonatomic, copy) NSString *contenType; //内容类型

@property (nonatomic, copy) NSString *chatType;  //聊天类型 , 群聊,单聊

@property (nonatomic, copy) NSString *deviceType; //设备类型

@property (nonatomic, copy) NSString *versionCode; //TCP版本码

@property (nonatomic, copy) NSString *messageID; //消息ID

@property (nonatomic, strong) NSNumber *byMyself; //消息是否为本人所发

@property (nonatomic, copy) NSNumber *isSend;  //是否已经发送成功

@property (nonatomic, strong) NSNumber *isRead; //是否已读

@property (nonatomic, copy) NSString *sendTime; //时间戳

@property (nonatomic, copy) NSString *beatID; //心跳标识

@property (nonatomic, copy) NSString *groupName; //群名称

@property (nonatomic, strong) NSNumber *noDisturb; //免打扰状态  , 1为正常接收  , 2为免打扰状态 , 3为屏蔽状态

@property (nonatomic, strong) ChatContentModel *content; //内容

@property (nonatomic, strong) NSNumber *isSending; //是否正在发送中

@property (nonatomic, strong) NSNumber *progress; //进度

@end



#pragma mark ---消息内容--
@interface ChatContentModel :NSObject

@property (nonatomic, copy) NSString *text; //文本

@property (nonatomic, assign) CGSize picSize; //图片尺寸

@property (nonatomic, strong) NSString *seconds; //时长

@property (nonatomic, copy) NSString *fileName; //文件名

@property (nonatomic, strong) NSNumber *videoDuration; //语音时长

@property (nonatomic, copy) NSString *videoSize;  //视频大小

@property (nonatomic, copy) NSString *bigPicAdress; //图片大图地址

@property (nonatomic, strong) NSString *fileSize; //文件大小

@property (nonatomic, copy) NSString *fileType; //文件类型

@property (nonatomic, copy) NSString *fileIconAdress; //文件缩略图地址

@end
