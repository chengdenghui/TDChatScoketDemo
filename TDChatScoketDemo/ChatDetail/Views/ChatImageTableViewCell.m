//
//  ChatImageTableViewCell.m
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatImageTableViewCell.h"

@interface ChatImageTableViewCell()

@property(nonatomic,strong)UIImageView *headerImageView; //头像
@property(nonatomic,strong)UILabel *nameLabel; //昵称
@property(nonatomic,strong)UIImageView *contentImageView; //图片内容

@end


@implementation ChatImageTableViewCell

-(void)setModel:(id)model
{
    self.headerImageView.image =[UIImage imageNamed:@"userhead"];
    self.nameLabel.text =@"小明";
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top).offset(0);
        make.right.equalTo(self.headerImageView.mas_left).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        make.right.equalTo(self.nameLabel.mas_right);
        make.width.equalTo(@(SCREEN_WITH/2));
        make.height.equalTo(@100);
    }];
    
}


#pragma mark ---action--






#pragma mark ---getter--
-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView =[[UIImageView alloc] init];
        _headerImageView.backgroundColor =[UIColor orangeColor];
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc] init];
        _nameLabel.backgroundColor =[UIColor redColor];
        _nameLabel.font =[UIFont systemFontOfSize:14];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView =[[UIImageView alloc] init];
        _contentImageView.backgroundColor =[UIColor purpleColor];
        [self addSubview:_contentImageView];
    }
    return _contentImageView;
}














@end


