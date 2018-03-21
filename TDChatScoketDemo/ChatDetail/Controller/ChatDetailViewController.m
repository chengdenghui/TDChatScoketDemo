//
//  ChatDetailViewController.m
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "ChatTextTableViewCell.h"
#import "ChatKeyboardView.h"
#import "ChatHandler.h"

@interface ChatDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ChatHandlerDelegate>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ChatKeyboardView *keyboardView; //自定义键盘
@property(nonatomic,strong)NSMutableArray *messageArray; //消息数组

@end

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"聊天详情";
    
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.keyboardView];
    
    //注册成为handler代理
    [[ChatHandler shareInstance] addDelegate:self deleagteQueue:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //系统键盘弹起通知
    [[NSNotificationCenter defaultCenter] addObserver:self.keyboardView selector:@selector(systemKeyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
}


#pragma mark - 接收消息
- (void)didReceiveMessage:(ChatModel *)chatModel type:(ChatMessageType)messageType
{
    switch (messageType) {
            //普通消息
        case ChatMessageType_Normal:
        {
            [self.messageArray addObject:chatModel];
            [self.tableview reloadData];
            [self scrollToBottom];
        }
            break;
            //普通消息成功回执
        case ChatMessageType_NormalReceipt:
        {
            NSPredicate *predict = [NSPredicate predicateWithFormat:@"sendTime = %@",chatModel.sendTime];
            ChatModel *refreshModel = [self.messageArray filteredArrayUsingPredicate:predict].firstObject;
            refreshModel.isSend = @1;
            refreshModel.isSending = @0;
            [self.tableview reloadData];
        }
            break;
            //失败回执
        case ChatMessageType_InvalidReceipt:
        {
        }
            break;
            //撤回消息回执
        case ChatMessageType_RepealReceipt:
        {
        }
            break;
        default:
            break;
    }
}















#pragma mark --tableViewDeleagte----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    ChatTextTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ChatTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.messageArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark---action----
#pragma mark - 发送文本/表情消息
- (void)sendTextMessage:(NSString *)text
{
    //创建文本消息
    ChatModel *textModel =[[ChatModel alloc]init];
    textModel.content = [[ChatContentModel alloc] init];
    textModel.byMyself = @1;
    textModel.content.text = text;
    [self.messageArray addObject:textModel];
    [self.tableview reloadData];
    [self scrollToBottom];
    //传输文本
    [[ChatHandler shareInstance] sendTextMessage:textModel];
}

#pragma mark --滚动到底部
-(void)scrollToBottom
{
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:self.messageArray.count -1 inSection:0];
    [self.tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


#pragma mark --getter-----

-(UITableView *)tableview
{
    if (_tableview ==nil) {
        
        CGRect rectFrame =self.view.frame;
        rectFrame.size.height =SCREEN_HEIGHT - 49;
        _tableview =[[UITableView alloc] initWithFrame:rectFrame style:UITableViewStylePlain];
#warning 注意在tableView中必须进行代理的相关设置 不然不能正常显示--------
        _tableview.delegate =self;
        _tableview.dataSource =self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.backgroundColor =[UIColor whiteColor];
        
    }
    return _tableview;
}

-(ChatKeyboardView *)keyboardView
{
    if (!_keyboardView) {
        _keyboardView =[[ChatKeyboardView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WITH, 49)];
        _keyboardView.backgroundColor =[UIColor whiteColor];
        
        //传入当前控制器,方便打开相册(如果放到控制器,后期的逻辑过多,控制器会更加臃肿)
        __weak typeof(self) weakself = self;
        [_keyboardView textCallSendTextBlock:^(NSString *text) {
            NSLog(@"%@",text);
            [weakself sendTextMessage:text];
        }];
        
    }
    return _keyboardView;
}

-(NSMutableArray *)messageArray
{
    if (!_messageArray) {
        _messageArray =[NSMutableArray arrayWithCapacity:0];
    }
    return _messageArray;
}







@end
