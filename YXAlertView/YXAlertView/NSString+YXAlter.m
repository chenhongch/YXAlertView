


//
//  NSString+YXAlter.m
//  YXAlertView
//
//  Created by jokechen on 2018/4/8.
//  Copyright © 2018年 陈红. All rights reserved.
//

#import "NSString+YXAlter.h"

@implementation NSString (YXAlter)

- (CGSize)titleSize:(CGFloat)width {
    UIFont *font = [UIFont systemFontOfSize:16];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 2000)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}

- (CGSize)messageSize:(CGFloat)width  {
    UIFont *font = [UIFont systemFontOfSize:14];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 10;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, 2000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes context:nil].size;
    
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}
@end
