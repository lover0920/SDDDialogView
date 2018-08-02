//
//  YSDDialogView.m
//  LizhiRun
//
//  Created by 孙号斌 on 2018/4/28.
//  Copyright © 2018年 SX. All rights reserved.
//

#import "YSDDialogView.h"


@interface YSDDialogView()
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) YSDDialogViewConfig *config;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *otherButton;
@end
@implementation YSDDialogView
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     otherBtn:(NSString *)otherBtn
{
    return [self initWithTitle:title message:message cancle:nil otherBtn:otherBtn];
}
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                       cancle:(NSString *)cancle
                     otherBtn:(NSString *)otherBtn
{
    self = [super init];
    if (self) {
        [self createUIWithTitle:title message:message cancle:cancle otherBtn:otherBtn];
    }
    return self;
}
- (void)createUIWithTitle:(NSString *)title
                  message:(NSString *)message
                   cancle:(NSString *)cancle
                 otherBtn:(NSString *)otherBtn
{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    
    /*************** 蒙版 ***************/
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _coverView.backgroundColor = RGBA(0, 0, 0, 0.0);
    [window addSubview:_coverView];
    
    /*************** self ***************/
    self.backgroundColor = UIColorWhite;
    self.layer.cornerRadius = 4.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.1f;
    self.layer.shadowRadius = 16.0f;
    self.layer.shadowOffset = CGSizeMake(-2, 2);
    [window addSubview:self];
    [window bringSubviewToFront:self];
    _config = [YSDDialogViewConfig defaultConfig];
    
    /*************** title ***************/
    NSInteger height = 0;
    if (!EmptyStr(title))
    {
        CGFloat h = [NSString sizeOfString:title
                                attributes:@{NSFontAttributeName:_config.titleFont}
                                     width:SCREEN_WIDTH-80].height;
        _titleLabel = [UILabel lableWithFrame:CGRectMake(24, 24, SCREEN_WIDTH-80, h)
                                         text:title
                                    textColor:_config.titleColor
                                         font:_config.titleFont
                                    alignment:NSTextAlignmentLeft];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        
        height = 24+h;
    }
    
    /*************** message ***************/
    if (!EmptyStr(message))
    {
        CGFloat h = [NSString sizeOfString:message
                                attributes:@{NSFontAttributeName:_config.messageFont}
                                     width:SCREEN_WIDTH-80].height;
        _messageLabel = [UILabel lableWithFrame:CGRectMake(24, height+24, SCREEN_WIDTH-80, h)
                                           text:message
                                      textColor:_config.messageColor
                                           font:_config.messageFont
                                      alignment:NSTextAlignmentLeft];
        _messageLabel.numberOfLines = 0;
        [self addSubview:_messageLabel];
        
        height = 24+h+height;
    }
    
    /*************** cancle ***************/
    if (!EmptyStr(cancle) || !EmptyStr(otherBtn))
    {
        //宽
        CGFloat cancleW = [NSString sizeOfString:cancle
                                      attributes:@{NSFontAttributeName:_config.cancleFont}
                                           width:SCREEN_WIDTH-80].width;
        CGFloat otherW = [NSString sizeOfString:otherBtn
                                     attributes:@{NSFontAttributeName:_config.otherBTNFont}
                                          width:SCREEN_WIDTH-80].width;
        //cancle
        if (!EmptyStr(cancle))
        {
            CGFloat x = (SCREEN_WIDTH-32)-12-(EmptyStr(otherBtn) ? 0 : otherW+24)-(cancleW+24);
            _cancleButton = [UIButton buttonWithFrame:CGRectMake(x, height+24, cancleW+24, 52)
                                                title:cancle
                                                 font:_config.cancleFont
                                           titleColor:_config.cancleColor];
            [_cancleButton addTarget:self
                              action:@selector(cancleButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_cancleButton];
        }
        
        //other
        if (!EmptyStr(otherBtn))
        {
            CGFloat x = (SCREEN_WIDTH-32)-12-(otherW+24);
            _otherButton = [UIButton buttonWithFrame:CGRectMake(x, height+24, otherW+24, 52)
                                                title:otherBtn
                                                 font:_config.otherBTNFont
                                           titleColor:_config.otherBTNColor];
            [_otherButton addTarget:self
                              action:@selector(otherButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_otherButton];
        }
        
        height = height+24 + 52 + 8;
    }
    
    self.frame = CGRectMake(16, (SCREEN_HEIGHT-height)/2, SCREEN_WIDTH-32, height);
    
    
    /*************** 移动 ***************/
    [self showView];
}

#pragma mark - setter
- (void)updateConfig:(YSDDialogViewConfig *)config
{
    
}


- (void)setAttMessage:(NSAttributedString *)attMessage
{
    _messageLabel.attributedText = attMessage;
}

#pragma mark - 响应事件
- (void)cancleButtonAction:(UIButton *)button
{
    if (self.cancleButtonBlock) {
        self.cancleButtonBlock();
    }
    [self dismiss];
}
- (void)otherButtonAction:(UIButton *)button
{
    if (self.otherButtonBlock) {
        self.otherButtonBlock();
    }
    
    if (self.clickOtherNoDismiss) {
        return;
    }
    [self dismiss];
}

#pragma mark - 移除
- (void)showView
{
    self.alpha = 0.0;
    CGAffineTransform oldTransform = self.transform;
    self.transform = CGAffineTransformScale(oldTransform, 1.1, 1.1);
    //动画效果
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.backgroundColor = RGBA(0, 0, 0, 0.4);
        self.alpha = 1.0;
        self.transform = oldTransform;
    }];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.backgroundColor = RGBA(0, 0, 0, 0);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [_coverView removeFromSuperview];
        [self removeFromSuperview];
    }];
}
@end







@implementation YSDDialogViewConfig
+ (instancetype)defaultConfig
{
    YSDDialogViewConfig *config = [[YSDDialogViewConfig alloc] init];
    config.titleFont = UIFont(16);
    config.titleColor = UIColorTitle1;
    config.messageFont = UIFont(14);
    config.messageColor = UIColorTitle1;
    config.cancleFont = UIFontBold(14);
    config.cancleColor = UIColorTitle3;
    config.otherBTNFont = UIFontBold(14);
    config.otherBTNColor = UIColorTheme;
    return config;
}

#pragma mark - getter方法
- (YSDDialogViewConfig *(^)(UIColor *))titleColorC
{
    return ^(UIColor *color){
        self.titleColor = color;
        return self;
    };
}
- (YSDDialogViewConfig *(^)(UIFont *))titleFontF
{
    return ^(UIFont *font){
        self.titleFont = font;
        return self;
    };
}

- (YSDDialogViewConfig *(^)(UIColor *))messageColorC
{
    return ^(UIColor *color){
        self.messageColor = color;
        return self;
    };
}
- (YSDDialogViewConfig *(^)(UIFont *))messageFontF
{
    return ^(UIFont *font){
        self.messageFont = font;
        return self;
    };
}

- (YSDDialogViewConfig *(^)(UIColor *))cancleColorC
{
    return ^(UIColor *color){
        self.cancleColor = color;
        return self;
    };
}
- (YSDDialogViewConfig *(^)(UIFont *))cancleFontF
{
    return ^(UIFont *font){
        self.cancleFont = font;
        return self;
    };
}

- (YSDDialogViewConfig *(^)(UIColor *))otherBTNColorC
{
    return ^(UIColor *color){
        self.otherBTNColor = color;
        return self;
    };
}
- (YSDDialogViewConfig *(^)(UIFont *))otherBTNFontF
{
    return ^(UIFont *font){
        self.otherBTNFont = font;
        return self;
    };
}
@end
