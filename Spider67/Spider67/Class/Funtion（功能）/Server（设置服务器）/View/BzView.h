//
//  BzView.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BzView : UIView

@property (nonatomic, assign) CGFloat bzW;
@property (nonatomic, weak) id<ServerPtc> delegate;
@property (nonatomic, strong) UITextField* beizhuTf;

@end

NS_ASSUME_NONNULL_END
