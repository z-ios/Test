//
//  IoTHubModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IoTHubModel : NSObject

@property (nonatomic, copy) NSString* instancename;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, copy) NSString* mqttport;
@property (nonatomic, copy) NSString* domain;
@property (nonatomic, copy) NSString* version;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* protocol;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, assign) BOOL iothubCellLineFlag;

@end

NS_ASSUME_NONNULL_END






