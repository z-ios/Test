//
//  NSObject+WT.m
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NSObject+WT.h"

@implementation NSObject (WT)

/**
 * 判断一个字符串是否是一个IP地址
 **/
+ (BOOL)isValidIP:(NSString *)ipStr {
    if (nil == ipStr) {
        return NO;
    }
    NSArray *ipArray = [ipStr componentsSeparatedByString:@"."];
    if (ipArray.count == 4) {
        for (NSString *ipnumberStr in ipArray) {
            int ipnumber = [ipnumberStr intValue];
            if (!(ipnumber>=0 && ipnumber<=255)) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

#pragma mark--获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字 搜索
+ (NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}


+ (BOOL)StringIsNullOrEmpty:(NSString *)str
{
    return (str == nil || [str isKindOfClass:[NSNull class]] || str.length == 0);
}

#pragma mark---根据指定文本,字体和最大高度计算尺寸
+ (CGSize)sizeWidthWidth:(NSString *)text font:(UIFont *)font maxHeight:(CGFloat)height{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

#pragma mark - 比较两个日期大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
//    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    NSDate*dta = [[NSDate alloc]init];
    NSDate*dtb = [[NSDate alloc]init];
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedDescending) {
//        指定时间 已过期
        return 1;
        
    }else if(result ==NSOrderedAscending){
        //指定时间 没过期
        return -1;
        
    }else{
        //刚好时间一样.
        return 0;
        
    }
}

#pragma mark - 日期格式转换
+ (NSString *)getTimeStrWithString:(NSString *)str form:(NSString *)formStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:formStr]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter1 stringFromDate: tempDate];
    return currentDateStr;
}
+ (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSxxx"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter1 stringFromDate: tempDate];
    return currentDateStr;
}

@end
