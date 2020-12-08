//
//  WifiContentView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WifiContentView : UIView

@property (nonatomic, strong) UITextField* ssidTf;
@property (nonatomic, strong) UITextField* pwdTf;
- (void)show;
- (void)dismiss;
@property (nonatomic, weak) id<RegisterPtc> delegate;

@end

NS_ASSUME_NONNULL_END
