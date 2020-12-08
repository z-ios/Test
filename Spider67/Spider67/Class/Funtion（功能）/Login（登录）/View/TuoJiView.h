//
//  TuoJiView.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TuoJiView : UIView

@property (nonatomic, strong) void(^cancelBlock)(void);
@end

NS_ASSUME_NONNULL_END
