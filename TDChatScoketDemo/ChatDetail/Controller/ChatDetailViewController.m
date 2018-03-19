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

@interface ChatDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //系统键盘弹起通知
    [[NSNotificationCenter defaultCenter] addObserver:self.keyboardView selector:@selector(systemKeyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
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
    ChatModel *model =[[ChatModel alloc]init];
    model.content = [[ChatContentModel alloc] init];
    model.content.text = text;
    [self.messageArray addObject:model];
    [self.tableview reloadData];
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
//        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.backgroundColor =[UIColor whiteColor];
        
    }
    return _tableview;
}

-(ChatKeyboardView *)keyboardView
{
    if (!_keyboardView) {
        _keyboardView =[[ChatKeyboardView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WITH, 49)];
        _keyboardView.backgroundColor =[UIColor orangeColor];
        
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
