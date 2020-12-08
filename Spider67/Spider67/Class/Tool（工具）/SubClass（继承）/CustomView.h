//
//  CustomView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView

@property (nonatomic, copy) NSString* textStr;
@property (nonatomic, copy) void(^timeOutBlock)(void);
@property (strong, nonatomic) MSWeakTimer *timer;
@end

NS_ASSUME_NONNULL_END
