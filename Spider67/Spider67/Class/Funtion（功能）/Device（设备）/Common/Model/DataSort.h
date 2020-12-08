//
//  DataSort.h
//  Spider67
//
//  Created by 宾哥 on 2020/7/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataSort : NSObject

+(NSMutableArray*)az_SortPinYing:(NSMutableArray*)pFriendListArray;
+(NSMutableArray*)za_SortPinYing:(NSMutableArray*)pFriendListArray;

+(NSMutableArray*)SortShuZi:(NSMutableArray*)pFriendListArray;
+(NSMutableArray*)daoxu_SortShuZi:(NSMutableArray*)pFriendListArray;

@end

NS_ASSUME_NONNULL_END
