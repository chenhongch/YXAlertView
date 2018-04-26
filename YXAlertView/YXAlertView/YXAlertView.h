//
//  YXAlertView.h
//  YXAlertView
//
//  Created by jokechen on 2018/4/4.
//  Copyright © 2018年 陈红. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YXAlertViewMode) {
    YXAlertViewModeLargeIcon   = 0,     // show large icon to alterview
    YXAlertViewModeSmallIcon   = 1,     // show large module to alterview
};

@protocol YXAlertViewDelegate;

@interface YXAlertView : UIView

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (nonatomic ,assign)YXAlertViewMode mode;
@property (weak, nonatomic) id<YXAlertViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message mode:(YXAlertViewMode)mode delegate:(id<YXAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

// Show the alert view in current window
- (void)show;

// Hide the alert view
- (void)hide;

// Set the color and font size of title, if color is nil, default is black. if fontsize is 0, default is 14
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of message, if color is nil, default is black. if fontsize is 0, default is 12
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

// Set the color and font size of button at the index, if color is nil, default is black. if fontsize is 0, default is 16
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

// Set the icon distance from top to view top
- (void)setIconTop:(CGFloat)top;



@end


@protocol YXAlertViewDelegate <NSObject>

- (void)alertView:(YXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end




