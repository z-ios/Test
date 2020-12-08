//  GitHub: https://github.com/Tate-zwt/WTSDK
//  UIButton+WT.m
//  ShopApp
//
//  Created by 张威庭 on 16/1/18.
//  Copyright © 2016年 cong. All rights reserved.
//

#import "UIButton+WT.h"

@implementation UIButton (WT)


+ (UIButton *_Nullable)z_frame:(CGRect)frame norImageName:(nullable NSString *)norImageName selImageName:(nullable NSString *)selImageName Target:(nullable id)target action:(SEL _Nullable )action title:(nullable NSString *)title selTitle:(nullable NSString *)selTitle  font:(nullable UIFont *)font norTitleColor:(nullable UIColor *)norTitleColor selTitleColor:(nullable UIColor *)selTitleColor  bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor
{
    
    UIButton *_ = [[UIButton alloc] initWithFrame:frame];
    
    if (norImageName) {
        [_ setImage:[UIImage imageNamed:norImageName] forState: UIControlStateNormal];
    }
    
    if (selImageName) {
        [_ setImage:[UIImage imageNamed:selImageName] forState: UIControlStateSelected];
    }
    
    [_ addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (title) {
        [_ setTitle:title forState:UIControlStateNormal];
    }
    
    if (selTitle) {
        [_ setTitle:selTitle forState:UIControlStateSelected];
    }
    
    if (font) {
        _.titleLabel.font = font;
    }
    
    if (bgColor) {
        _.backgroundColor = bgColor;
    }
    
    if (norTitleColor) {
        [_ setTitleColor:norTitleColor forState:UIControlStateNormal];
    }
    
    if (selTitleColor) {
        [_ setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    
    _.layer.cornerRadius = cornerRadius;
    
    _.layer.borderWidth = borderWidth;
    
    if (borderColor) {
        _.layer.borderColor = borderColor.CGColor;
    }
    
    return _;
}

+ (instancetype _Nullable )z_frame:(CGRect)frame fontSize:(CGFloat)fontSize cornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold Target:(nullable id)target action:(SEL _Nullable )action
{
    UIButton *_ = [[UIButton alloc] initWithFrame:frame];
    
    [_ setTitle:title forState:UIControlStateNormal];
    
    [_ setTitleColor:titleColor forState:UIControlStateNormal];

    [_.layer setCornerRadius:radiusSize];
    
    if (isbold) {
        _.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        _.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    _.backgroundColor = backgroundColor;
    
    [_ addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return _;
}

+ (instancetype _Nullable )z_frame:(CGRect)frame fontSize:(CGFloat)fontSize cornerRadius:(CGFloat)radiusSize borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold Target:(nullable id)target action:(SEL _Nullable )action
{
    UIButton *_ = [[UIButton alloc] initWithFrame:frame];
    
    [_ setTitle:title forState:UIControlStateNormal];
    
    [_ setTitleColor:titleColor forState:UIControlStateNormal];

    [_.layer setCornerRadius:radiusSize];
    
    if (isbold) {
        _.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        _.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    _.backgroundColor = backgroundColor;
    
    [_ addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    _.layer.borderWidth = borderWidth;
       
       if (borderColor) {
           _.layer.borderColor = borderColor.CGColor;
       }
    
    return _;
}




+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold
{
    UIButton *instance =[[UIButton alloc]init];
    if (imageName) {
        [instance setImage:[UIImage imageNamed:imageName] forState: UIControlStateNormal];
    }
    [instance setTitle:title forState:UIControlStateNormal];
    [instance setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (isbold) {
        instance.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        instance.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    [instance sizeToFit];
    
    return instance;
    
}

+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold
{
    UIButton *instance =[[UIButton alloc]init];
    
    if (imageName) {
        [instance setImage:[UIImage imageNamed:imageName] forState: UIControlStateNormal];
        
    }
    
    [instance setTitle:title forState:UIControlStateNormal];
    [instance setTitleColor:titleColor forState:UIControlStateNormal];
//    [instance.layer setMasksToBounds:YES];
    [instance.layer setCornerRadius:radiusSize];
    if (isbold) {
        instance.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        instance.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    instance.backgroundColor = backgroundColor;
    [instance sizeToFit];
    
    return instance;
    
}

+ (instancetype _Nullable )z_setImageName:(NSString *_Nullable)imageName selectedImageName:(NSString *_Nullable)selectedImageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold
{
    UIButton *instance =[[UIButton alloc]init];
    if (imageName) {
        [instance setImage:[UIImage imageNamed:imageName] forState: UIControlStateNormal];
    }
    if (selectedImageName) {
        [instance setImage:[UIImage imageNamed:selectedImageName] forState: UIControlStateSelected];
    }
    [instance setTitle:title forState:UIControlStateNormal];
    [instance setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (isbold) {
        instance.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        instance.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    
    [instance sizeToFit];
    
    return instance;
    
}


+ (instancetype _Nullable )z_svg_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold
{
    UIButton *instance =[[UIButton alloc]init];
      if (imageName) {
          [instance setImage:[SVGKImage imageNamed:imageName].UIImage forState: UIControlStateNormal];
      }
      [instance setTitle:title forState:UIControlStateNormal];
      [instance setTitleColor:titleColor forState:UIControlStateNormal];
      
      if (isbold) {
          instance.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
      }else{
          instance.titleLabel.font = [UIFont systemFontOfSize:fontSize];
      }
      
      [instance sizeToFit];
      
      return instance;
}

+ (instancetype _Nullable )z_svg_setImageName:(NSString *_Nullable)imageName fontSize:(CGFloat)fontSize CornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *_Nullable)backgroundColor titleColor:(UIColor *_Nullable)titleColor title:(NSString *_Nullable)title isbold:(BOOL)isbold
{
      UIButton *instance =[[UIButton alloc]init];
        
        if (imageName) {
            [instance setImage:[SVGKImage imageNamed:imageName].UIImage forState: UIControlStateNormal];
            
        }
        
        [instance setTitle:title forState:UIControlStateNormal];
        [instance setTitleColor:titleColor forState:UIControlStateNormal];
    //    [instance.layer setMasksToBounds:YES];
        [instance.layer setCornerRadius:radiusSize];
        if (isbold) {
            instance.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        }else{
            instance.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        }
        instance.backgroundColor = backgroundColor;
        [instance sizeToFit];
        
        return instance;
}

// svg

+ (UIButton *_Nullable)z_svg_frame:(CGRect)frame norImageName:(nullable NSString *)norImageName selImageName:(nullable NSString *)selImageName Target:(nullable id)target action:(SEL _Nullable )action title:(nullable NSString *)title selTitle:(nullable NSString *)selTitle  font:(nullable UIFont *)font norTitleColor:(nullable UIColor *)norTitleColor selTitleColor:(nullable UIColor *)selTitleColor  bgColor:(nullable UIColor *)bgColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor
{
    UIButton *_ = [[UIButton alloc] initWithFrame:frame];
    
    if (norImageName) {
        [_ setImage:[SVGKImage imageNamed:norImageName].UIImage forState: UIControlStateNormal];
    }
    
    if (selImageName) {
        [_ setImage:[SVGKImage imageNamed:selImageName].UIImage forState: UIControlStateSelected];
    }
    
    [_ addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (title) {
        [_ setTitle:title forState:UIControlStateNormal];
    }
    
    if (selTitle) {
        [_ setTitle:selTitle forState:UIControlStateSelected];
    }
    
    if (font) {
        _.titleLabel.font = font;
    }
    
    if (bgColor) {
        _.backgroundColor = bgColor;
    }
    
    if (norTitleColor) {
        [_ setTitleColor:norTitleColor forState:UIControlStateNormal];
    }
    
    if (selTitleColor) {
        [_ setTitleColor:selTitleColor forState:UIControlStateSelected];
    }
    
    _.layer.cornerRadius = cornerRadius;
    
    _.layer.borderWidth = borderWidth;
    
    if (borderColor) {
        _.layer.borderColor = borderColor.CGColor;
    }
    
    return _;
}

@end
