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
    
    
    
    
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints
{
    [super updateConstraints];
    
    
}


#pragma mark action-----



#pragma mark ---getter----
-(UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView =[[UIImageView alloc] init];
    }
    return _headerImageView;
}







@end
