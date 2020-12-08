//
//  IWTabBar.h
//  WeiBo17
//
//  Created by teacher on 15/8/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWTabBar;


@protocol IWTabBarDelegate <NSObject,UITabBarDelegate>

- (void)tabBar:(IWTabBar *)tabBar didSelectPlusButton:(UIButton *)button;

@end

@interface IWTabBar : UITabBar

//加号按钮点击的block
@property (nonatomic, copy) void(^plusBtnClick)();


@property (nonatomic, weak) id<IWTabBarDelegate> delegate;

@end
