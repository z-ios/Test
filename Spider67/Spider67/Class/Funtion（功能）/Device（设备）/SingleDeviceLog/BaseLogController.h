//
//  BaseLogController.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/26.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleLogController.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseLogController : UIViewController<DevicePtc,XLSlideSwitchDelegate>

@property (nonatomic, copy) void(^cancelSelectItem)(void);
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, strong) SingleLogController* vc;

@end

NS_ASSUME_NONNULL_END
