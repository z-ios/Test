//
//  CenterManager.h
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CenterManager : NSObject

/// 全局访问点
+ (instancetype)shared;

@property (nonatomic, copy) NSString* role_id;
@property (nonatomic, copy) NSString* realname;
@property (nonatomic, copy) NSString* telephone;
@property (nonatomic, copy) NSString* groupname;
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* user_id;


@end

NS_ASSUME_NONNULL_END

