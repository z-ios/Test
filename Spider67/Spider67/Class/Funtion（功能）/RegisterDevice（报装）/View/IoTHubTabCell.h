//
//  IoTHubTabCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class IoTHubModel;
@interface IoTHubTabCell : UITableViewCell

@property (nonatomic, strong) IoTHubModel* model;

@end

NS_ASSUME_NONNULL_END
