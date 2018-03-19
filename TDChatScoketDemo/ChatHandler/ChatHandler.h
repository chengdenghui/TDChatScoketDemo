//
//  ChatHandler.h
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 hui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatModel.h"

@protocol ChatHandlerDelegate <NSObject>

@required
//接收消息代理
-(void)didreeceivemessage:(ChatModel *)chatModel type:(ChatMessageType)messageType;

@optional
//发送消息超时代里
-(void)sendMessageTimeOutWithTag:(long)tag;

@end

@interface ChatHandler : NSObject

//socket连接状态
@property (nonatomic, assign) SockotConnectStatus connectStatus;

//聊天单例
+(instancetype)shareInstance;
//连接服务器端口
-(void)connectServerHost;
//主动断开连接
-(void)executeDisconnectServer;
//添加代理
-(void)addDelegate:(id<ChatHandlerDelegate>)delegate deleagteQueue:(dispatch_queue_t)queue;
//移除代理
-(void)removeDeleagte:(id<ChatHandlerDelegate>)delegate;
//发送消息
-(void)sendMessage:(ChatModel *)chatModel timeOut:(NSInteger)timeOut tag:(long)tag;





//发送文本消息
-(void)sendTextMessage:(ChatModel *)textModel;

//发送语音消息
-(void)sendAudioMessage:(ChatModel *)audioModel;

//发送图片消息
-(void)sendPicMessage:(NSArray<ChatModel *> *)picModels;

//发送视频消息
-(void)sendVideoMessage:(ChatModel *)videoModel;


@end
