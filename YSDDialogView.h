//
//  YSDDialogView.h
//  LizhiRun
//
//  Created by 孙号斌 on 2018/4/28.
//  Copyright © 2018年 SX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YSDDialogViewConfig;

@interface YSDDialogView : UIView
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                       cancle:(NSString *)cancle
                     otherBtn:(NSString *)otherBtn;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                     otherBtn:(NSString *)otherBtn;

- (void)updateConfig:(YSDDialogViewConfig *)config;
@property (nonatomic, copy) NSAttributedString *attMessage;

@property (nonatomic, assign) BOOL clickOtherNoDismiss;

@property (nonatomic, copy) void(^cancleButtonBlock)(void);
@property (nonatomic, copy) void(^otherButtonBlock)(void);
@end


@interface YSDDialogViewConfig : NSObject
+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont  *titleFont;

@property (nonatomic, strong) UIColor *messageColor;
@property (nonatomic, strong) UIFont  *messageFont;

@property (nonatomic, strong) UIColor *cancleColor;
@property (nonatomic, strong) UIFont  *cancleFont;

@property (nonatomic, strong) UIColor *otherBTNColor;
@property (nonatomic, strong) UIFont  *otherBTNFont;


@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^titleColorC)(UIColor *color);
@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^titleFontF)(UIFont  *font);

@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^messageColorC)(UIColor *color);
@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^messageFontF)(UIFont  *font);

@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^cancleColorC)(UIColor *color);
@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^cancleFontF)(UIFont  *font);

@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^otherBTNColorC)(UIColor *color);
@property (nonatomic, copy, readonly) YSDDialogViewConfig *(^otherBTNFontF)(UIFont  *font);

@end
