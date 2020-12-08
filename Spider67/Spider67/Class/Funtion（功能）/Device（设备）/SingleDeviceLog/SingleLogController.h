//
//  SingleLogController.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleLogController : UIViewController

@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, weak) id<DevicePtc> delegate;


@end

NS_ASSUME_NONNULL_END
