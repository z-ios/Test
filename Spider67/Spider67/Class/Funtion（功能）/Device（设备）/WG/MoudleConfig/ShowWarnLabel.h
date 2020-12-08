//
//  ShowWarnLabel.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowWarnLabel : UILabel

@property (nonatomic, strong) UIView* colorView;
@property (nonatomic, strong) UIButton* deleBtn;
@property (nonatomic, copy) void(^deletWarmItem)(void);

@end

NS_ASSUME_NONNULL_END
