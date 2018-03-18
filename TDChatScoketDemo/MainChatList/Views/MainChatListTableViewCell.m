//
//  MainChatListTableViewCell.m
//  TDChatScoketDemo
//
//  Created by mac on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "MainChatListTableViewCell.h"


@interface MainChatListTableViewCell()

@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *timeLabel;

@end

@implementation MainChatListTableViewCell

-(void)getDateWithModel:(id )model
{
    
    self.headerImageView.image =[UIImage imageNamed:@"userhead"];
    self.nameLabel.text =@"小明";
    self.contentLabel.text =@"小明收到信息回家吃饭啦";
    self.timeLabel.text =@"2018.03.18 12:00";
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
     
     [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@10);
         make.left.equalTo(@10);
         make.width.equalTo(@60);
         make.height.equalTo(@60);
     }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top).offset(0);
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerImageView.mas_bottom).offset(0);
        make.left.equalTo(self.nameLabel.mas_left);
        make.width.equalTo(@300);
        make.height.equalTo(@20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
}


#pragma mark action-----



#pragma mark ---getter----
-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView =[[UIImageView alloc] init];
        _headerImageView.backgroundColor =[UIColor redColor];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 30.0;
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc] init];
        _nameLabel.font =[UIFont systemFontOfSize:18];
        [self addSubview:_nameLabel];
    }
   return _nameLabel;
}
                           
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.font =[UIFont systemFontOfSize:15];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel =[[UILabel alloc] init];
        _timeLabel.font =[UIFont systemFontOfSize:12];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}






@end
