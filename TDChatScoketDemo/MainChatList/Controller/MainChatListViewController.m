//
//  MainChatListViewController.m
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "MainChatListViewController.h"
#import "ChatDetailViewController.h"
#import "MainChatListTableViewCell.h"


@interface MainChatListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation MainChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"聊天列表";
    self.tableview.backgroundColor =[UIColor whiteColor];
}






#pragma mark ---tableViewDelegate---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //详情
    static NSString *cellID = @"cellId";
    
    MainChatListTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[MainChatListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell getDateWithModel:nil];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatDetailViewController *detailVC =[[ChatDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}




#pragma mark ---getter--
-(UITableView *)tableview
{
    if (_tableview ==nil) {
        
        CGRect rectFrame =self.view.frame;
        rectFrame.size.height =SCREEN_HEIGHT;
        _tableview =[[UITableView alloc] initWithFrame:rectFrame style:UITableViewStylePlain];
#warning 注意在tableView中必须进行代理的相关设置 不然不能正常显示--------
        _tableview.delegate =self;
        _tableview.dataSource =self;
//        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        [self.view addSubview:_tableview];
    }
    return _tableview;
}









@end
