//
//  ServerPtc.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ServerPtc <NSObject>
@optional
- (void)showServerList;
- (void)ipshowServerList;
- (void)severListselectedData:(NSDictionary *)dict;
- (void)saveData:(NSString *)ipStr port:(NSString *)portStr titleStr:(NSString *)titleStr xieyiStr:(NSString *)xieyiStr typeNum:(NSInteger)typeNum;

@end

NS_ASSUME_NONNULL_END
