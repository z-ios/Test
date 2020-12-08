//
//  IPView.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPView : UIView

@property (nonatomic, assign) CGFloat ipW;
@property (nonatomic, weak) id<ServerPtc> delegate;
@property (nonatomic, strong) UITextField* tf1;
@property (nonatomic, strong) UITextField* tf2;
@property (nonatomic, strong) UITextField* tf3;
@property (nonatomic, strong) UITextField* tf4;
@property (nonatomic, strong) UITextField* domainTf;
@property (nonatomic,assign) NSInteger typeNum;

@end

NS_ASSUME_NONNULL_END
