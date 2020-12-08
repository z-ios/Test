//
//  SingleAlarmLogCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SingleAlarmLogModel;
@interface SingleAlarmLogCell : UITableViewCell

@property (nonatomic, strong) SingleAlarmLogModel* model;
@property (nonatomic, weak) id<DevicePtc> zdelegate;

@end

NS_ASSUME_NONNULL_END
