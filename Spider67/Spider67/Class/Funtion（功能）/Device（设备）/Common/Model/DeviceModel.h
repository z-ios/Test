//
//  DeviceModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/7/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceModel : NSObject

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* imei;
@property (nonatomic, copy) NSString* wifimac;
@property (nonatomic, copy) NSString* devicename;
@property (nonatomic, copy) NSString* groupname;
@property (nonatomic, copy) NSString* modulecount;
@property (nonatomic, copy) NSString* onlinestatus;
@property (nonatomic, copy) NSString* havenewversion;
@property (nonatomic, copy) NSString* csq;
@property (nonatomic, copy) NSString* devicetype;
@property (nonatomic, copy) NSString* remarks;
@property (nonatomic, copy) NSString* havealarm;

@end

NS_ASSUME_NONNULL_END
