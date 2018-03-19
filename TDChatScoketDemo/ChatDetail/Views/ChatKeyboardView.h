//
//  ChatKeyboardView.h
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//  自定义键盘的实现

#import <UIKit/UIKit.h>


@interface ChatKeyboardView : UIView

//普通文本/表情消息发送回调
@property(nonatomic,copy) void(^chatTextMessageSendBlock)(NSString *text);


//调起键盘通知
- (void)systemKeyboardWillShow:(NSNotification *)note;


//发送消息回调
-(void)textCallSendTextBlock:(void (^)(NSString *text))textCallBlock;


@end



