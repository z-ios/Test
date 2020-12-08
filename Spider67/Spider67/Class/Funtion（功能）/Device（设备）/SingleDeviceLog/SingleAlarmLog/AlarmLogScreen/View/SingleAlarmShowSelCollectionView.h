//
//  SingleAlarmShowSelCollectionView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SingAlarmItemModel;
@interface SingleAlarmShowSelCollectionView : UICollectionView

@property (nonatomic, strong) NSMutableArray<SingAlarmItemModel *>* itemList;
@property (nonatomic, weak) id<DevicePtc> zdelegate;

@end

NS_ASSUME_NONNULL_END
