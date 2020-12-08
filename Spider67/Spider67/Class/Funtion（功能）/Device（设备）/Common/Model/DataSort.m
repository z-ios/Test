//
//  DataSort.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DataSort.h"
#import "DeviceModel.h"

@implementation DataSort

/*按照拼音首字母排序*/
+(NSMutableArray*)az_SortPinYing:(NSMutableArray*)pFriendListArray
{
    
    NSMutableArray* pAllArray = [[NSMutableArray alloc] init];
    for(char sz = 'A'; sz <= 'Z'; ++sz)
    {
        NSMutableArray* pArray = [[NSMutableArray alloc] init];
        for(int i = 0;i < pFriendListArray.count; ++i)
        {
            DeviceModel* pItem = (DeviceModel*)[pFriendListArray objectAtIndex:i];
            NSString* pPinYin = [self FirstCharactor:pItem.devicename];
            if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
            {
                [pArray addObject:pItem];
            }
        }
        
        while(true)
        {
            int i = 0;
            for(;i < pFriendListArray.count; ++i)
            {
                DeviceModel* pItem = (DeviceModel*)[pFriendListArray objectAtIndex:i];
                
                NSString* pPinYin = [self FirstCharactor:pItem.devicename];
                if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
                {
                    [pFriendListArray removeObjectAtIndex:i];
                    break;
                }
            }
            
            if(i == pFriendListArray.count)
            {
                if(pArray.count > 0)
                {
//                    Model* pItem = [[Model alloc] init];
//                    pItem.pstrName = [NSString stringWithFormat:@"%c", sz];
//                    [pAllArray addObject:pItem];
                    [pAllArray addObjectsFromArray:pArray];
                }
                
                break;
            }
        }
    }
    
    if (pFriendListArray.count != 0) {
//        Model* pItem = [[Model alloc] init];
//        pItem.pstrName = @"#";
//        [pAllArray addObject:pItem];
        [pAllArray addObjectsFromArray:pFriendListArray];
    }
    return pAllArray;
    
}

// 倒序
+(NSMutableArray*)za_SortPinYing:(NSMutableArray*)pFriendListArray
{
    
    NSMutableArray* pAllArray = [[NSMutableArray alloc] init];
    for(char sz = 'Z'; sz >= 'A'; --sz)
    {
        NSMutableArray* pArray = [[NSMutableArray alloc] init];
        for(int i = 0;i < pFriendListArray.count; ++i)
        {
            DeviceModel* pItem = (DeviceModel*)[pFriendListArray objectAtIndex:i];
            NSString* pPinYin = [self FirstCharactor:pItem.devicename];
            if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
            {
                [pArray addObject:pItem];
            }
        }
        
        while(true)
        {
            int i = 0;
            for(;i < pFriendListArray.count; ++i)
            {
                DeviceModel* pItem = (DeviceModel*)[pFriendListArray objectAtIndex:i];
                
                NSString* pPinYin = [self FirstCharactor:pItem.devicename];
                if(NSOrderedSame == [[NSString stringWithFormat:@"%c", sz] compare:pPinYin])
                {
                    [pFriendListArray removeObjectAtIndex:i];
                    break;
                }
            }
            
            if(i == pFriendListArray.count)
            {
                if(pArray.count > 0)
                {
//                    Model* pItem = [[Model alloc] init];
//                    pItem.pstrName = [NSString stringWithFormat:@"%c", sz];
//                    [pAllArray addObject:pItem];
                    [pAllArray addObjectsFromArray:pArray];
                }
                
                break;
            }
        }
    }
    
    if (pFriendListArray.count != 0) {
//        Model* pItem = [[Model alloc] init];
//        pItem.pstrName = @"#";
//        [pAllArray addObject:pItem];
        [pAllArray addObjectsFromArray:pFriendListArray];
    }
    return pAllArray;
    
}

//CommonUtil里面的类方法：
//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+(NSString *)FirstCharactor:(NSString *)pString
{
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pPinYin = [pStr capitalizedString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}


+(NSMutableArray*)SortShuZi:(NSMutableArray*)pFriendListArray
{
    
    NSArray *sortedArray = [pFriendListArray sortedArrayUsingComparator:^NSComparisonResult(DeviceModel *obj1, DeviceModel *obj2) {
        
        NSInteger value1;
        NSInteger value2;
        if ([obj1.imei isEqualToString:@""]) {
            value1 = [obj1.wifimac integerValue];
        }else{
            value1 = [obj1.imei integerValue];
        }
        
        if ([obj2.imei isEqualToString:@""]) {
            value2 = [obj2.wifimac integerValue];
        }else{
            value2 = [obj2.imei integerValue];
        }
        
        if (value1 > value2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    return sortedArray.mutableCopy;
    
    
}

// 倒序
+(NSMutableArray*)daoxu_SortShuZi:(NSMutableArray*)pFriendListArray
{
    
    NSArray *sortedArray = [pFriendListArray sortedArrayUsingComparator:^NSComparisonResult(DeviceModel *obj1, DeviceModel *obj2) {
        
        NSInteger value1;
        NSInteger value2;
        if ([obj1.imei isEqualToString:@""]) {
            value1 = [obj1.wifimac integerValue];
        }else{
            value1 = [obj1.imei integerValue];
        }
        
        if ([obj2.imei isEqualToString:@""]) {
            value2 = [obj2.wifimac integerValue];
        }else{
            value2 = [obj2.imei integerValue];
        }
        
        if (value1 < value2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    return sortedArray.mutableCopy;
    
    
}

@end
