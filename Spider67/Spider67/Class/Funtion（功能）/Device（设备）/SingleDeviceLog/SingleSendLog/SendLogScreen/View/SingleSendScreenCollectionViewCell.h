//
//  SingleSendScreenCollectionViewCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SingleSendItemModel;
@interface SingleSendScreenCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SingleSendItemModel* model;
@property (nonatomic, strong) NSIndexPath* cellPath;
@property (nonatomic, weak) id<DevicePtc> delegate;

@end

NS_ASSUME_NONNULL_END
