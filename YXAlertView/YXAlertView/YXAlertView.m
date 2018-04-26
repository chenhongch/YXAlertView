//
//  YXAlertView.m
//  YXAlertView
//
//  Created by jokechen on 2018/4/4.
//  Copyright © 2018年 陈红. All rights reserved.
//

#define YXRGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define YXUIColorFromRGB(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "YXAlertView.h"
#import "UIView+Category.h"
#import "NSString+YXAlter.h"

@interface YXAlertView ()
{
    CGFloat contentViewWidth;
    CGFloat contentViewHeight;
}

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end



@implementation YXAlertView

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message mode:(YXAlertViewMode)mode delegate:(id<YXAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _icon = icon;
        _title = title;
        _message = message;
        _delegate = delegate;
        _mode = mode;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        va_list args;
        va_start(args, buttonTitles);
        if (buttonTitles)
        {
            [_buttonTitleArray addObject:buttonTitles];
            while (1)
            {
                NSString *  otherButtonTitle = va_arg(args, NSString *);
                if(otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
        
        [self initContentView];
    }
    return self;
}


// Init the content of content view
- (void)initContentView {
    contentViewWidth = 280 * self.frame.size.width / 320;
    contentViewHeight = 20;
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
   
   
    [self initTitleAndIcon];
    [self initMessage];
    [self initAllButtons];
    
    _contentView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
    _contentView.center = self.center;
    [self addSubview:_contentView];
}


// Init all the buttons according to button titles
- (void)initAllButtons {
    if (_buttonTitleArray.count > 0) {
        if (self.mode == YXAlertViewModeSmallIcon) {
           contentViewHeight += 20 + 45;
        }else{
           contentViewHeight += 40;
        }
    
        UIView *horizonSperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, contentViewHeight - 55, contentViewWidth, 1)];
        horizonSperatorView.backgroundColor = YXRGBA(218, 218, 222, 1.0);
        [_contentView addSubview:horizonSperatorView];
        
        CGFloat buttonWidth = contentViewWidth / _buttonTitleArray.count;
        for (NSString *buttonTitle in _buttonTitleArray) {
            NSInteger index = [_buttonTitleArray indexOfObject:buttonTitle];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(index * buttonWidth, horizonSperatorView.frame.origin.y + horizonSperatorView.frame.size.height, buttonWidth, 54)];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [button setTitleColor:YXUIColorFromRGB(0x2e2e2e) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_contentView addSubview:button];
            
            if (index < _buttonTitleArray.count - 1) {
                UIView *verticalSeperatorView = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y, 1, button.frame.size.height)];
                verticalSeperatorView.backgroundColor = YXRGBA(218, 218, 222, 1.0);
                [_contentView addSubview:verticalSeperatorView];
            }
        }
    }
}

// Init the title and icon
- (void)initTitleAndIcon {
    _titleView = [[UIView alloc] init];
    if (_icon != nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = _icon;
        [_titleView addSubview:_iconImageView];
        _iconImageView.y = _message == nil?50:40;
    }
    
    CGSize titleSize = [_title titleSize:contentViewWidth - (15 + 15 + _iconImageView.frame.size.width + 5)];
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = _title;
        _titleLabel.textColor = YXRGBA(28, 28, 28, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [_titleView addSubview:_titleLabel];
    }
    
    
    if (self.mode == YXAlertViewModeSmallIcon) {
        _iconImageView.frame = CGRectMake(0, 0, 20, 20);
        
       _titleLabel.frame = CGRectMake(_iconImageView.frame.origin.x + _iconImageView.frame.size.width + 5, 1, titleSize.width, titleSize.height);
        
        _titleView.frame = CGRectMake(0, 0, _iconImageView.width + 5 + titleSize.width, MAX(_iconImageView.frame.size.height, titleSize.height));
        if (_icon) {
             _titleLabel.centerY = _iconImageView.centerY;
        }else{
            _titleLabel.y = _message == nil?0:10;;
        }
       
        _titleView.center = CGPointMake(contentViewWidth / 2, 30 + _titleView.frame.size.height / 2);
    
    }else{
       
        _iconImageView.size = CGSizeMake(100, 100);
        _titleLabel.y = _iconImageView.bottom+20;
        _titleLabel.size = titleSize;
        
        _titleView.frame = CGRectMake(0, 0, self.width, MAX(_iconImageView.y + _iconImageView.height, _titleLabel.y + _titleLabel.height));
        _titleView.centerX = self.centerX-13;
        _titleLabel.centerX = _titleView.centerX;
        _iconImageView.centerX = _titleView.centerX;
    }

    [_contentView addSubview:_titleView];
    
    contentViewHeight += _titleView.height;
    
}

// Init the message
- (void)initMessage {
    if (_message != nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.text = _message;
        _messageLabel.textColor = YXRGBA(120, 120, 120, 1.0);
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = 5;
        NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
        _messageLabel.attributedText = [[NSAttributedString alloc]initWithString:_message attributes:attributes];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize messageSize = [_message messageSize:contentViewWidth - (30 + 30)];
        if (self.mode == YXAlertViewModeSmallIcon) {
            _messageLabel.frame = CGRectMake(30, _titleView.y+_titleView.height+15, MAX(contentViewWidth - 30 - 30, messageSize.width), messageSize.height);
            [_contentView addSubview:_messageLabel];
            contentViewHeight +=  _messageLabel.height+30;
        }else{
            _messageLabel.frame = CGRectMake(30, _titleView.y+_titleView.height + 10, MAX(contentViewWidth - 30 - 30, messageSize.width), messageSize.height);
            [_contentView addSubview:_messageLabel];
            contentViewHeight += 20 + _messageLabel.height;
        }
    }else{
         contentViewHeight +=   20 ;
    }
}


- (void)showBackground
{
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.6;
    [UIView commitAnimations];
}

-(void)showAlertAnimation
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}



- (void)hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.0;
    [UIView commitAnimations];
}


- (void)buttonWithPressed:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        NSInteger index = [_buttonTitleArray indexOfObject:button.titleLabel.text];
        [_delegate alertView:self clickedButtonAtIndex:index];
    }
    [self hide];
}


- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    NSArray *windowViews = [window subviews];
    if(windowViews && [windowViews count] > 0){
        UIView *subView = [windowViews objectAtIndex:[windowViews count]-1];
        for(UIView *aSubView in subView.subviews)
        {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}

- (void)hide {
    _contentView.hidden = YES;
    [self hideAlertAnimation];
    [self removeFromSuperview];
}

- (void)setIconTop:(CGFloat)top{
    _iconImageView.y = top;
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _messageLabel.textColor = color;
    }
    
    if (size > 0) {
        _messageLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

@end
