//
//  ChatTextTableViewCell.m
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatTextTableViewCell.h"

@interface ChatTextTableViewCell()

@property(nonatomic,strong)UIImageView *headerImageView; //头像
@property(nonatomic,strong)UILabel *nameLabel; //昵称
@property(nonatomic,strong)UILabel *contentLabel; //文字内容
@property(nonatomic,strong)ChatModel *chatModel;

@end


@implementation ChatTextTableViewCell

-(void)setModel:(ChatModel *)model
{
    _chatModel = model;
    self.headerImageView.image =[UIImage imageNamed:@"userhead"];

    self.contentLabel.text = model.content.text;
    if (_chatModel.byMyself.integerValue) {  //我方
            self.nameLabel.text =@"小明";
    }
    else{ //对方
           self.nameLabel.text =@"小花";
        self.nameLabel.textAlignment =NSTextAlignmentLeft;
        self.contentLabel.backgroundColor =[UIColor orangeColor];
    }
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        if (_chatModel.byMyself.integerValue) {  //我方
             make.right.equalTo(self.mas_right).offset(-10);
        }
        else{ //对方
             make.left.equalTo(self.mas_left).offset(10);
        }
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];

    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerImageView.mas_top).offset(0);
        if (_chatModel.byMyself.integerValue) {  //我方
        make.right.equalTo(self.headerImageView.mas_left).offset(-10);
        }
        else{ //对方
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        }
        
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        if (_chatModel.byMyself.integerValue) {  //我方
            make.right.equalTo(self.nameLabel.mas_right);
        }
        else{ //对方
            make.left.equalTo(self.nameLabel.mas_left);
        }
        make.width.equalTo(@(SCREEN_WITH/2));
        make.height.equalTo(@40);
    }];
    
}


#pragma mark ---action--






#pragma mark ---getter--
-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView =[[UIImageView alloc] init];
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc] init];
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel =[[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font =[UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}














@end

