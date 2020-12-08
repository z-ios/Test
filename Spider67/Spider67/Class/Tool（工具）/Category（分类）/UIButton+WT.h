//  GitHub: https://github.com/Tate-zwt/WTSDK
//  UIButton+WT.h
//  ShopApp
//
//  Created by 张威庭 on 16/1/18.
//  Copyright © 2016年 cong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WT)

/** 创建一个Button */
+ (UIButton *_Nullable)z_frame:(CGRect)frame norImageName:(nullable NSString *)norImageName selImageName:(nullable NSString *)selImageName Target:(nullable id)target action:(SEL _Nullable )action title:(nullable NSString *)title selTitle:(nullable NSString *)selTitle  font:(nullable UIFont *)font norTitleColor:(nullable UIColor *)norTitleColor selTitleColor:(nullable UIColor *)selTitleColor  bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

+ (instancetype _Nullable )z_frame:(CGRect)frame fontSize:(CGFloat)fontSize cornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold Target:(nullable id)target action:(SEL _Nullable )action;






+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold;

+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold;

+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName selectedImageName:(NSString *_Nullable)selectedImageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold;


+ (instancetype _Nullable )z_svg_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold;

+ (instancetype _Nullable )z_svg_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold;



+ (UIButton *_Nullable)z_svg_frame:(CGRect)frame norImageName:(nullable NSString *)norImageName selImageName:(nullable NSString *)selImageName Target:(nullable id)target action:(SEL _Nullable )action title:(nullable NSString *)title selTitle:(nullable NSString *)selTitle  font:(nullable UIFont *)font norTitleColor:(nullable UIColor *)norTitleColor selTitleColor:(nullable UIColor *)selTitleColor  bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

+ (instancetype _Nullable )z_frame:(CGRect)frame fontSize:(CGFloat)fontSize cornerRadius:(CGFloat)radiusSize borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold Target:(nullable id)target action:(SEL _Nullable )action;

@end
