//
//  UITextField+WT.m
//  ClassicIoT
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UITextField+WT.h"

@implementation UITextField (WT)

+ (UITextField *)z_frame:(CGRect)frame bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor  text:(nullable NSString *)text  textFont:(UIFont *)textFont textColor:(UIColor *)textColor placeholder:(nullable NSString *)placeholder placeholderFont:(nullable UIFont *)placeholderFont placeholderColor:(nullable UIColor *)placeholderColor leftImgName:(nullable NSString *)leftImgName leftImgSize:(CGSize)leftImgSize rightImgName:(nullable NSString *)rightImgName rightImgSize:(CGSize)rightImgSize
{
    UITextField* tf = [[UITextField alloc] initWithFrame:frame];
    
    tf.text = text;
    tf.textColor = textColor;
    tf.font = textFont;
    tf.layer.cornerRadius = cornerRadius;
    tf.layer.borderWidth = borderWidth;
    tf.layer.borderColor = borderColor.CGColor;
    tf.backgroundColor = bgColor;
    if (placeholder) {
//        tf.placeholder = placeholder;
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
        if (placeholderColor) {
            [placeholderStr addAttribute:NSForegroundColorAttributeName value:placeholderColor range:NSMakeRange(0, placeholder.length)];
        }
        if (placeholderFont) {
            [placeholderStr addAttribute:NSFontAttributeName value:placeholderFont range:NSMakeRange(0, placeholder.length)];
        }
        
        tf.attributedPlaceholder = placeholderStr;
    }
    
    if (leftImgName) {
        UIImageView*lView = [[UIImageView alloc] init];
        lView.image = [UIImage imageNamed:leftImgName];
        lView.size = leftImgSize;
        lView.contentMode =UIViewContentModeCenter;
        tf.leftView = lView;
        tf.leftViewMode =UITextFieldViewModeAlways;
    }
    
    if (rightImgName) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightImgSize.width, rightImgSize.height)];
        UIImageView*rView = [[UIImageView alloc] init];
        view.userInteractionEnabled = NO;
        rView.image = [UIImage imageNamed:rightImgName];
        rView.size = rightImgSize;
        rView.contentMode =UIViewContentModeCenter;
        [view addSubview:rView];
        tf.rightView = view;
        tf.rightViewMode =UITextFieldViewModeAlways;
    }


    return tf;
    
}

+ (UITextField *)z_btnFrame:(CGRect)btnFrame norBtnImageName:(nullable NSString *)norBtnImageName selBtnImageName:(nullable NSString *)selBtnImageName Target:(nullable id)target action:(SEL)action secureTextEntry:(BOOL)secureTextEntry frame:(CGRect)frame bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor  text:(nullable NSString *)text  textFont:(UIFont *)textFont textColor:(UIColor *)textColor placeholder:(nullable NSString *)placeholder placeholderFont:(nullable UIFont *)placeholderFont placeholderColor:(nullable UIColor *)placeholderColor leftImgName:(nullable NSString *)leftImgName leftImgSize:(CGSize)leftImgSize rightImgName:(nullable NSString *)rightImgName rightImgSize:(CGSize)rightImgSize;
{
    UITextField* tf = [UITextField z_frame:frame bgColor:bgColor cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor text:text textFont:textFont textColor:textColor placeholder:placeholder placeholderFont:placeholderFont placeholderColor:placeholderColor leftImgName:leftImgName leftImgSize:leftImgSize rightImgName:rightImgName rightImgSize:rightImgSize];
    
    if (norBtnImageName) {
        UIView* view = [[UIView alloc] initWithFrame:btnFrame];
        UIButton* btn = [[UIButton alloc] initWithFrame:btnFrame];
        [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
        [btn setImage:[UIImage imageNamed:norBtnImageName] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:selBtnImageName] forState:(UIControlStateSelected)];
        tf.rightViewMode = UITextFieldViewModeAlways;
        [view addSubview:btn];
        tf.rightView = view;
        tf.secureTextEntry = secureTextEntry;
    }
    
    return tf;
}

@end
