//
//  RegisterContentView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterContentView : UIView

@property (nonatomic, weak) id<RegisterPtc> delegate;
@property (nonatomic, assign) NSInteger scrollIndex;

@property (nonatomic, copy) void(^stepBlock)(void);
@property (nonatomic, copy) void(^nextBlock)(void);
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, copy) void(^checkFailBlock)(void);
@property (nonatomic, copy) void(^resetIndexBlock)(void);

@end

NS_ASSUME_NONNULL_END
