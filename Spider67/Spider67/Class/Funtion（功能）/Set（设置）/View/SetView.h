//
//  SetView.h
//  Spider67
//
//  Created by 宾哥 on 2020/7/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    HTTP,
    WEBSOCKET,
    BLE,
} SetSliderType;
@interface SetView : UIView

@property (nonatomic, assign) SetSliderType sliderType;
@property (nonatomic, strong) UILabel* setTitleLb;

@end

NS_ASSUME_NONNULL_END
