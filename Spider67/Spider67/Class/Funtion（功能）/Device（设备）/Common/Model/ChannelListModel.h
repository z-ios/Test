//
//  ChannelListModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelListModel : NSObject

@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *modulename;
@property (nonatomic, copy) NSString *channeltype;
@property (nonatomic, copy) NSString *channelname;
@property (nonatomic, copy) NSString *port;
@property (nonatomic, copy) NSString *channeltitle;
@property (nonatomic, copy) NSString *formulaname;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *originalvalue;
@property (nonatomic, copy) NSString *readvalue;
@property (nonatomic, copy) NSString *alarm_val_L;
@property (nonatomic, copy) NSString *alarm_tag_L;
@property (nonatomic, copy) NSString *alarm_color_L;
@property (nonatomic, copy) NSString *alarm_color_H;
@property (nonatomic, copy) NSString *alarm_val_H;
@property (nonatomic, copy) NSString *alarm_tag_H;
@property (nonatomic, copy) NSString *calculatedvalue;
@property (nonatomic, copy) NSString *alarm_type;
@property (nonatomic, assign) BOOL isSel;

@end

NS_ASSUME_NONNULL_END


