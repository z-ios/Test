//
//  SingleAlarmShowSelCollectionViewCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SingAlarmItemModel;
@interface SingleAlarmShowSelCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SingAlarmItemModel* model;
@property (nonatomic, strong) NSIndexPath* cellPath;
@property (nonatomic, weak) id<DevicePtc> delegate;

@end

NS_ASSUME_NONNULL_END
