//
//  XLSlideSwitchDelegate.h
//  XLSlideSwitchDemo
//
//  Created by Apple on 2017/1/9.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XLSlideSwitchDelegate <NSObject>
@optional
/**
 切换位置
 */
- (void)slideSwitchDidselectTab:(NSUInteger)index;
/*
 滑动到左边界时调用
 */
- (void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam;

/**
 滑动到右边界时调用
 */
- (void)slideSwitchPanRightEdge:(UIPanGestureRecognizer *)panParam;


/**
 子视图第一次加载页面,和系统的viewDidLoad方法具有一样的效果,视图第一次加载时执行,因此在使用这个第三方的时候,要把viewDidLoad里面的操作放到这个代理方法里面执行,避免出现一些布局错乱的问题
 
 @param index 页面下标
 */
- (void)slideMenuViewDidLoad:(NSInteger)index;

// 页面生命周期方法
- (void)slideMenuViewWillAppear:(NSInteger)index;
- (void)slideMenuViewDidAppear:(NSInteger)index;
- (void)slideMenuViewWillDisappear:(NSInteger)index;
- (void)slideMenuViewDidDisappear:(NSInteger)index;


@end
