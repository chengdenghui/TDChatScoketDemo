//
//  ChatDetailViewController.m
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "ChatDetailTableViewCell.h"

@interface ChatDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation ChatDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"聊天详情";
    self.tableview.backgroundColor =[UIColor whiteColor];
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
    ChatDetailTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ChatDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}





#pragma mark --getter
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
