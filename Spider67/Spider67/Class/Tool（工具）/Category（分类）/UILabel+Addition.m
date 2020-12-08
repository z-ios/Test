//
//  UILabel+Addition.m
//  ddd
//
//  Created by elco on 2018/4/23.
//  Copyright © 2018年 elco. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color isbold:(BOOL)isbold{
    UILabel *label = [[self alloc] init];
    
    label.text = text;
    if (isbold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textColor = color;
    label.numberOfLines = 0;
    
    return label;
}

+ (instancetype)z_frame:(CGRect)frame Text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color isbold:(BOOL)isbold
{
    UILabel *label = [[self alloc] initWithFrame:frame];
    
    label.text = text;
    if (isbold) {
        label.font = [UIFont boldSystemFontOfSize:fontSize];
    }else{
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    label.textColor = color;
    label.numberOfLines = 0;
    
    
    return label;
    
}

+ (instancetype)z_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color isbold:(BOOL)isbold cornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [UILabel z_labelWithText:text fontSize:fontSize color:color isbold:isbold];
    label.layer.cornerRadius = radiusSize;
    label.layer.masksToBounds = YES;
    label.backgroundColor = backgroundColor;
    
    return label;
}

+ (instancetype)z_frame:(CGRect)frame Text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color isbold:(BOOL)isbold cornerRadius:(CGFloat)radiusSize backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label = [UILabel z_frame:frame Text:text fontSize:fontSize color:color isbold:isbold];
    label.layer.cornerRadius = radiusSize;
    label.layer.masksToBounds = YES;
    label.backgroundColor = backgroundColor;
    
    return label;
}

@end
