//
//  SingleChannelLogModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/26.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleChannelLogModel : NSObject

@property (nonatomic, assign) CGFloat bgWith;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, copy) NSString* channelName;
@property (nonatomic, copy) NSString* channelTitle;
@property (nonatomic, copy) NSString* port;
@property (nonatomic, copy) NSString* originalVal;
@property (nonatomic, copy) NSString* readVal;
@property (nonatomic, copy) NSString* calculatedVal;
@property (nonatomic, copy) NSString* logTime;

@end

NS_ASSUME_NONNULL_END
