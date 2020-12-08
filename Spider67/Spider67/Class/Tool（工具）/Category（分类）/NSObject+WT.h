//
//  NSObject+WT.h
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WT)

/**
 * 判断一个字符串是否是一个IP地址
 **/
+ (BOOL)isValidIP:(NSString *)ipStr;

+ (NSString *)transformToPinyin:(NSString *)aString;

+ (BOOL)StringIsNullOrEmpty:(NSString *)str;

+ (CGSize)sizeWidthWidth:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height;

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

+ (NSString *)getTimeStrWithString:(NSString *)str form:(NSString *)formStr;

+ (NSString *)getTimeStrWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
