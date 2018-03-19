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
NSInteger autoConnectCount = TCP_AutoConnectCount;

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


#pragma mark ---Delegate----
#pragma mark ---scoketDelegate
//接收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    //转为明文消息
    NSString *secretStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //去除'\n'
    secretStr = [secretStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //转为消息模型(具体传输的json包裹内容,加密方式,包头设定什么的需要和后台协商,操作方式根据项目而定)
    ChatModel *messageModel = [ChatModel mj_setKeyValues:secretStr];
    
    //接收到服务器的心跳
    if ([messageModel.beatID isEqualToString:TCP_beatBody]) {
        
        //未接到服务器心跳次数置为0
        _sendBeatCount = 0;
        NSLog(@"------接收到服务器心跳--------");
        return;
    }
    
    //消息类型 (消息类型这里是以和服务器协商后自定义的通信协议来设定 , 包括字段名,具体的通信逻辑相关 . 当然也可以用数字来替代下述的字段名,使用switch效率更高)
    ChatMessageType messageType     = ChatMessageContentType_Unknow;

    
    
    
    
    
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

#pragma mark ----添加代理
-(void)addDelegate:(id<ChatHandlerDelegate>)delegate deleagteQueue:(dispatch_queue_t)queue
{
    if (![self.delegates containsObject:delegate]) {
        [self.delegates addObject:delegate];
    }
    
}

#pragma mark ----移除代理
-(void)removeDeleagte:(id<ChatHandlerDelegate>)delegate
{
    [self.delegates removeObject:delegate];
}

#pragma mark ----发送消息
-(void)sendMessage:(ChatModel *)chatModel timeOut:(NSInteger)timeOut tag:(long)tag
{
    //将模型转化为JSON字符串
    NSString *messageJson = chatModel.mj_JSONString;
    //以"\n"分割此条消息 , 支持的分割方式有很多种例如\r\n、\r、\n、空字符串,不支持自定义分隔符,具体的需要和服务器协商分包方式 , 这里以\n分包
    /*
     如不进行分包,那么服务器如果在短时间里收到多条消息 , 那么就会出现粘包的现象 , 无法识别哪些数据为单独的一条消息 .
     对于普通文本消息来讲 , 这里的处理已经基本上足够 . 但是如果是图片进行了分割发送,就会形成多个包 , 那么这里的做法就显得并不健全,严谨来讲,应该设置包头,把该条消息的外信息放置于包头中,例如图片信息,该包长度等,服务器收到后,进行相应的分包,拼接处理.
     */
    messageJson = [messageJson stringByAppendingString:@"\n"];
    //base64编码成data类型
    NSData *messageData =[[NSData alloc] initWithBase64EncodedString:messageJson options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //写入数据
    [_chatScoket writeData:messageData withTimeout:1 tag:1];
    
}


#pragma mark ----主动断开连接
-(void)executeDisconnectServer
{
    //更新scoket连接状态
    _connectStatus = SocketConnectStatus_UnConnected;
    [self disconnect];
}

#pragma mark ---连接中断
- (void)serverInterruption
{
    //更新soceket连接状态
    _connectStatus = SocketConnectStatus_UnConnected;
    [self disconnect];
}

-(void)disconnect
{
    //断开连接
    [_chatScoket disconnect];
    //关闭心跳定时器
    dispatch_source_cancel(self.beatTimer);
    //未接收服务器心跳次数 置为初始化
    _sendBeatCount = 0;
    //自动重连次数 置为初始化
    autoConnectCount = TCP_AutoConnectCount;
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




