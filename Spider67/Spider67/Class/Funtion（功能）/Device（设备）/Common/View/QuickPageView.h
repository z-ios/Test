//
//  QuickPageView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class PageModel;
@interface QuickPageView : UIView

@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) NSMutableArray<PageModel *>* arrData;
@property (nonatomic, weak) id<DevicePtc> delegate;

@end

NS_ASSUME_NONNULL_END
