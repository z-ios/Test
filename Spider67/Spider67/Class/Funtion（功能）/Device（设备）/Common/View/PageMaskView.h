//
//  PageMaskView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageMaskView : UIView

+ (void)showPageViewWithFrame:(CGRect)frame vc:(UIViewController *)vc totalCount:(NSInteger)totalCount curIndex:(NSInteger)curIndex completion:(void (^ __nullable)(NSInteger pageNum))completion;

@end

NS_ASSUME_NONNULL_END
