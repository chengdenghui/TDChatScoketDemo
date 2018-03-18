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


#pragma mark --tableViewDeleagte----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    cell.model = nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
