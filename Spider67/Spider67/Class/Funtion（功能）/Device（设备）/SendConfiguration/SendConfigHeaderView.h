//
//  SendConfigHeaderView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/8.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SendConfigModel;
NS_ASSUME_NONNULL_BEGIN

@interface SendConfigHeaderView : UIControl

@property (nonatomic, strong) SendConfigModel* model;

@property (nonatomic, strong) UILabel* line_lb;

@end

NS_ASSUME_NONNULL_END
