//
//  SingleSendLogScreenController.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleSendLogScreenController : UIViewController

@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, weak) id<DevicePtc> zdelegate;
@property (nonatomic, strong) NSDictionary* selDict;

@end

NS_ASSUME_NONNULL_END
