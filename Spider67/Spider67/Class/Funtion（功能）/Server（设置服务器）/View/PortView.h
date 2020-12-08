//
//  PortView.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PortView : UIView

@property (nonatomic, assign) CGFloat portW;
@property (nonatomic, strong) UITextField* ptf;
@property (nonatomic, weak) id<ServerPtc> delegate;
@end

NS_ASSUME_NONNULL_END
