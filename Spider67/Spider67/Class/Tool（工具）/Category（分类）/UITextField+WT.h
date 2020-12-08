//
//  UITextField+WT.h
//  ClassicIoT
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (WT)

+ (UITextField *)z_frame:(CGRect)frame bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor  text:(nullable NSString *)text  textFont:(UIFont *)textFont textColor:(UIColor *)textColor placeholder:(nullable NSString *)placeholder placeholderFont:(nullable UIFont *)placeholderFont placeholderColor:(nullable UIColor *)placeholderColor leftImgName:(nullable NSString *)leftImgName leftImgSize:(CGSize)leftImgSize rightImgName:(nullable NSString *)rightImgName rightImgSize:(CGSize)rightImgSize;

+ (UITextField *)z_btnFrame:(CGRect)btnFrame norBtnImageName:(nullable NSString *)norBtnImageName selBtnImageName:(nullable NSString *)selBtnImageName Target:(nullable id)target action:(SEL)action secureTextEntry:(BOOL)secureTextEntry frame:(CGRect)frame bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor  text:(nullable NSString *)text  textFont:(UIFont *)textFont textColor:(UIColor *)textColor placeholder:(nullable NSString *)placeholder placeholderFont:(nullable UIFont *)placeholderFont placeholderColor:(nullable UIColor *)placeholderColor leftImgName:(nullable NSString *)leftImgName leftImgSize:(CGSize)leftImgSize rightImgName:(nullable NSString *)rightImgName rightImgSize:(CGSize)rightImgSize;

@end

NS_ASSUME_NONNULL_END
