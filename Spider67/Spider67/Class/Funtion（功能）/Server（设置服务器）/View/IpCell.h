//
//  IpCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IpCell : UICollectionViewCell

@property (nonatomic, assign) CGFloat ipW;
@property (nonatomic, strong) UITextField* tf1;
@property (nonatomic, strong) UITextField* tf2;
@property (nonatomic, strong) UITextField* tf3;
@property (nonatomic, strong) UITextField* tf4;
@property (nonatomic, weak) id<ServerPtc> delegate;

@end

NS_ASSUME_NONNULL_END
