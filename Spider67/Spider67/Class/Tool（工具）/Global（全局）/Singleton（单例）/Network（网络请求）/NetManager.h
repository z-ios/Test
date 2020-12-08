//
//  NetManager.h
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface NetManager : NSObject

/// 全局访问点
+ (instancetype)shared;

/// 原生请求
- (void)NSURLSessionUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)NSURLSessionUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters auth:(NSString *)auth success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure;
/// afn请求
- (void)afnNetUrl:(NSString *)url method:(NSString *)method parameters:(nullable id)parameters auth:(nullable NSString *)auth  success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)afnBodyNetUrl:(NSString *)url method:(NSString *)method Body:(id)body auth:(nullable NSString *)auth  success:(void (^)(NSUInteger statuCode,id responseObject))success failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
