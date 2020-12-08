//
//  LineTypeView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LineTypeView : UIView

@property (nonatomic, copy) NSString* lineTypeStr;
@property (nonatomic, weak) id<RegisterPtc> delegate;
@property (nonatomic, strong) UIButton* gBtn;
@property (nonatomic, strong) UIButton* wifiBtn;
- (void)gBtnClick:(UIButton *)btn;
- (void)wifiBtnClick:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
