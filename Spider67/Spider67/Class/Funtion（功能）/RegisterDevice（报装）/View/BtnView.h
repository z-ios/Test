//
//  BtnView.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BtnView : UIView

@property (nonatomic, strong) NSString* typeBtnStr;
@property (nonatomic, weak) id<RegisterPtc> delegate;
@property (strong, nonatomic) MSWeakTimer *timer;

@end

NS_ASSUME_NONNULL_END
