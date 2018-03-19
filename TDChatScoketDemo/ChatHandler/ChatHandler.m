//
//  ChatHandler.m
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/19.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatHandler.h"
#import <GCDAsyncSocket.h>

/*******************Socket**************************/
#define TCP_VersionCode  @"1"      //当前TCP版本(服务器协商,便于服务器版本控制)
#define TCP_beatBody  @"beatID"    //心跳标识
#define TCP_AutoConnectCount  3    //自动重连次数
#define TCP_BeatDuration  1        //心跳频率
#define TCP_MaxBeatMissCount   3   //最大心跳丢失数
#define TCP_PingUrl    @"www.baidu.com"



//自动重连次数
NSInteger sutoConnectCount = TCP_AutoConnectCount;

@interface ChatHandler()<GCDAsyncSocketDelegate>

//初始化聊天
@property(nonatomic,strong)GCDAsyncSocket *chatScoket;
//所有的代理
@property(nonatomic,strong)NSMutableArray *delegates;
//心跳定时器
@property(nonatomic,strong)dispatch_source_t beatTimer;
//发送心跳次数
@property(nonatomic,assign)NSInteger sendBeatCount;

@end

@implementation ChatHandler

#pragma mark --初始化单例
+(instancetype)shareInstance
{
    static ChatHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler =[[ChatHandler alloc] init];
    });
    return handler;
}

-(instancetype)init
{
    if (self = [super init]) {
        //将handler 设置成加收TCP信息的代理
        _chatScoket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        //设置默认关闭读取
        [_chatScoket setAutoDisconnectOnClosedReadStream:NO];
        //默认状态未连接
        _connectStatus = SocketConnectStatus_UnConnected;
    }
    return self;
}






#pragma mark ----连接服务器端口
-(void)connectServerHost
{
    NSError *error = nil;
    [_chatScoket connectToHost:@"填写服务器IP" onPort:8080 error:&error];
    if (error) {
        NSLog(@"-----------连接服务器失败---------");
    } else{
        NSLog(@"-----------连接服务器成功---------");
    }
}

#pragma mark ----主动断开连接
-(void)executeDisconnectServer
{
    
    
}

#pragma mark ----添加代理
-(void)addDelegate:(id<ChatHandlerDelegate>)delegate deleagteQueue:(dispatch_queue_t)queue
{
    
    
    
}

#pragma mark ----移除代理
-(void)removeDeleagte:(id<ChatHandlerDelegate>)delegate
{
    
    
    
}

#pragma mark ----发送消息
-(void)sendMessage:(ChatModel *)chatModel timeOut:(NSInteger)timeOut tag:(long)tag
{
    
    
}

















#pragma mark ---getter--
//心跳定时器
-(dispatch_source_t)beatTimer
{
    if (!_beatTimer) {
        _beatTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_beatTimer, DISPATCH_TIME_NOW, TCP_BeatDuration * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_beatTimer, ^{
           
            //发送心跳 +1
            _sendBeatCount ++ ;
            //超过3次未收到服务器心跳 , 置为未连接状态
            if (_sendBeatCount>TCP_MaxBeatMissCount) {
                //更新连接状态
                _connectStatus = SocketConnectStatus_UnConnected;
            }else{
                //发送心跳
                NSData *beatData = [[NSData alloc]initWithBase64EncodedString:[TCP_beatBody stringByAppendingString:@"\n"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                [_chatScoket writeData:beatData withTimeout:-1 tag:9999];
                NSLog(@"------------------发送了心跳------------------");
            }

        });
    }
    return _beatTimer;
}


//代理数组
-(NSMutableArray *)delegates
{
    if (!_delegates) {
        _delegates =[NSMutableArray arrayWithCapacity:0];
    }
    return _delegates;
}


















@end




