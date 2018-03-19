//
//  ChatKeyboardView.m
//  TDChatScoketDemo
//
//  Created by 程登伟 on 2018/3/18.
//  Copyright © 2018年 hui. All rights reserved.
//

#import "ChatKeyboardView.h"

#define CTKEYBOARD_DEFAULTHEIGHT   273
// 记录当前键盘的高度, 键盘除了系统的键盘还有咱们自定义的键盘,互相来回切换
static CGFloat keyoardHeight     = 0;
static CGFloat defaultMsgBarHeight     = 49;  //模态输入框容器 49
static CGFloat defaultInputHeight     = 35;  //默认输入框 35

@interface ChatKeyboardView()<UITextViewDelegate>

//顶部消息操作栏
@property(nonatomic,strong)UIView *messageBar;
//自定义键盘容器
@property(nonatomic,strong)UIView *keyBoardContainer;
//语音按钮
@property(nonatomic,strong)UIButton *audioButton;
//输入框
@property(nonatomic,strong)UITextView *msgTextView;
//表情按钮
@property(nonatomic,strong)UIButton *swtFaceButton;
//加号按钮
@property(nonatomic,strong)UIButton *swtHeadleButton;


@end

@implementation ChatKeyboardView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.messageBar];
        [self addSubview:self.keyBoardContainer];  //键盘容器
        
    }
    return self;
}



#pragma mark ---Delegate----
#pragma mark --UITextDeleagte----
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    //删除键内容
//    if ([text isEqualToString:@""""]) {
//        NSLog(@"------点击了系统键盘删除键");
//
//        return NO;
//    }
    if ([text isEqualToString:@"\n"]){
        //发送普通文本消息
        NSLog(@"发送内容:%@++++++++",self.msgTextView.text);
        [self sendTextMessage]; 
        return NO;
    }
    return YES;
}




#pragma mark --通知的实现----
-(void)systemKeyboardWillShow:(NSNotification *)note
{
     //获取系统键盘高度
    CGFloat systemKeyboardHeight =[note.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    //记录系统键盘高度
    keyoardHeight = systemKeyboardHeight;
    //将自定义键盘跟随移动
    [self customKeyboardMove:SCREEN_HEIGHT - systemKeyboardHeight - CGRectGetHeight(self.messageBar.frame)];
}

//自定义键盘位移变化
- (void)customKeyboardMove:(CGFloat)customKbY
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0,customKbY, SCREEN_WITH, CGRectGetHeight((self.frame)));
    }];
}


#pragma mark ---action----
#pragma mark ---顶部消息操作栏部分点击事件-----
//切换至语音录制
-(void)audioButtonClick:(UIButton *)sender
{
    
    
}


#pragma mark - 输入框监听--监听输入框变化
//这里用contentSize计算较为简单和精确, 如果计算文字高度, 还需要加上textView的内间距
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat oldHeight  = [change[@"old"]CGSizeValue].height;
    CGFloat newHeight = [change[@"new"]CGSizeValue].height;
    if (oldHeight <=0 || newHeight <=0) {
        return;
    }
    NSLog(@"+++++%@+++++",change[@"new"]);
    NSLog(@"-----%@-----",change[@"old"]);
    if (newHeight != oldHeight) {
        NSLog(@"高度变化--");
        //根据实际的键盘高度进行布局
        CGFloat inputHeight = newHeight > defaultInputHeight ? newHeight : defaultInputHeight;
        //更新输入框
        [self msgTextViewHeightFit:inputHeight];
        
    }
}

#pragma mark ----输入框高度调整
- (void)msgTextViewHeightFit:(CGFloat)msgViewHeight
{
    self.messageBar.frame = CGRectMake(0, 0, SCREEN_WITH, msgViewHeight + CGRectGetMinY(self.msgTextView.frame)*2);
    self.msgTextView.frame = CGRectMake(CGRectGetMinX(self.msgTextView.frame), (CGRectGetHeight(self.messageBar.frame)-msgViewHeight)/2, CGRectGetWidth(self.msgTextView.frame), msgViewHeight);
    self.keyBoardContainer.frame = CGRectMake(0, CGRectGetMaxY(self.messageBar.frame), SCREEN_WITH, CGRectGetHeight(self.keyBoardContainer.frame));
    self.frame = CGRectMake(0, SCREEN_HEIGHT -keyoardHeight - CGRectGetHeight(self.messageBar.frame), SCREEN_WITH, CGRectGetHeight(self.keyBoardContainer.frame) +CGRectGetHeight(self.messageBar.frame));
}


//切换到表情键盘
-(void)switchFaceKeyboard:(UIButton *)sender
{
    
}

//切换到操作键盘
-(void)switchHandleKeyboard:(UIButton *)sender
{
    
    
}

#pragma mark ---发送文本/表情消息
-(void)sendTextMessage
{
     //普通文本消息回调
    if (self.chatTextMessageSendBlock) {
        self.chatTextMessageSendBlock(self.msgTextView.text);
    }
    //发送完成后输入框为空
    self.msgTextView.text = @"";
}

#pragma mark ---发送消息回调-----
//发送消息回调
-(void)textCallSendTextBlock:(void (^)(NSString *text))textCallBlock
{
    self.chatTextMessageSendBlock = textCallBlock;
}











#pragma mark ---getter----

#pragma mark --顶部消息操作栏部分初始化----
//顶部消息操作栏
-(UIView *)messageBar
{
    if (!_messageBar) {
        _messageBar =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WITH, defaultMsgBarHeight)];
        _messageBar.backgroundColor =[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        [_messageBar addSubview: self.audioButton];
        [_messageBar addSubview:self.msgTextView];        [_messageBar addSubview:self.swtFaceButton];
        [_messageBar addSubview:self.swtHeadleButton];
    }
    return _messageBar;
}

//语音按钮
-(UIButton *)audioButton
{
    if (!_audioButton) {
        _audioButton =[[UIButton alloc] initWithFrame:CGRectMake(0, (CGRectGetHeight(self.messageBar.frame)-30)/2, 30, 30 )];
        [_audioButton setImage:[UIImage imageNamed:@"语音"] forState:UIControlStateNormal];
        [_audioButton addTarget:self action:@selector(audioButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _audioButton;
}

//输入框
-(UITextView *)msgTextView
{
    if (!_msgTextView) {
        _msgTextView =[[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.audioButton.frame)+15, (CGRectGetHeight(self.messageBar.frame)-defaultInputHeight)/2, SCREEN_WITH -155, defaultInputHeight)];
        _msgTextView.font =[UIFont systemFontOfSize:14];
        _msgTextView.showsVerticalScrollIndicator = NO;
        _msgTextView.showsHorizontalScrollIndicator = NO;
        _msgTextView.returnKeyType = UIReturnKeySend;
        _msgTextView.enablesReturnKeyAutomatically = YES;
        _msgTextView.layer.masksToBounds = YES;
        _msgTextView.layer.cornerRadius = 5;
        _msgTextView.delegate = self;
        //观察者监听高度变化
        [_msgTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return _msgTextView;
}

//表情按钮
-(UIButton *)swtFaceButton
{
    if (!_swtFaceButton) {
        _swtFaceButton =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.msgTextView.frame)+15, (CGRectGetHeight(self.messageBar.frame)-30)/2, 30, 30)];
        [_swtFaceButton setImage:[UIImage imageNamed:@"表情"] forState:UIControlStateNormal];
        [_swtFaceButton addTarget:self action:@selector(switchFaceKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _swtFaceButton;
}


//加号按钮
-(UIButton *)swtHeadleButton
{
    if (!_swtHeadleButton) {
        _swtHeadleButton =[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.swtFaceButton.frame) +15, (CGRectGetHeight(self.messageBar.frame) -30)/2, 30, 30)];
        [_swtHeadleButton setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        [_swtHeadleButton addTarget:self action:@selector(switchHandleKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _swtHeadleButton;
}


#pragma mark ---自定义键盘容器部分初始化---
//自定义键盘容器
-(UIView *)keyBoardContainer
{
    if (!_keyBoardContainer) {
        _keyBoardContainer =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.messageBar.frame) +1, SCREEN_WITH, CTKEYBOARD_DEFAULTHEIGHT -CGRectGetHeight(self.messageBar.frame))];
        
    }
    return _keyBoardContainer;
}







@end



