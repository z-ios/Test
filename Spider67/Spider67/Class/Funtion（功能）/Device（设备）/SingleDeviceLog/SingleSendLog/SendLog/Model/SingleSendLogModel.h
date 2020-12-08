//
//  SingleSendLogModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleSendLogModel : NSObject

@property (nonatomic, assign) CGFloat bgWith;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* operation;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* operateUserName;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, copy) NSString* sendJson;
@property (nonatomic, copy) NSString* configJson;
@property (nonatomic, copy) NSString* logTime;

@end

NS_ASSUME_NONNULL_END

