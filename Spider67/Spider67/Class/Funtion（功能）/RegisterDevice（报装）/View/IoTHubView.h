//
//  IoTHubView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IoTHubView : UIView

@property (nonatomic, strong) UILabel* nameLb;
@property (nonatomic, strong) UILabel* mqttLb;
@property (nonatomic, strong) UILabel* ipLb;

@end

NS_ASSUME_NONNULL_END
