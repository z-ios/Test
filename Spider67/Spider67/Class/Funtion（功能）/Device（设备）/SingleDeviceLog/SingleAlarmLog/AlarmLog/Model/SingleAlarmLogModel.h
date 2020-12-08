//
//  SingleAlarmLogModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleAlarmLogModel : NSObject

@property (nonatomic, assign) CGFloat bgWith;
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *channelTitle;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *logTime;
@property (nonatomic, copy) NSString *tagColor;
@property (nonatomic, copy) NSString *alarmTag;
@property (nonatomic, copy) NSString *originalVal;
@property (nonatomic, copy) NSString *readVal;
@property (nonatomic, copy) NSString *calculatedVal;
@property (nonatomic, copy) NSString *logicRelation;
@property (nonatomic, copy) NSString *logicThreshold;
@property (nonatomic, copy) NSString *id;

@end

NS_ASSUME_NONNULL_END
