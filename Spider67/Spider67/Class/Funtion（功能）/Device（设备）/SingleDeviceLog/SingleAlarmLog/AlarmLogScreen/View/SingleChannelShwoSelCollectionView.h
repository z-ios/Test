//
//  SingleChannelShwoSelCollectionView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel;
@interface SingleChannelShwoSelCollectionView : UICollectionView

@property (nonatomic, weak) id<DevicePtc> zdelegate;
@property (nonatomic, strong) NSMutableArray<ChannelListModel *>* itemList;

@end

NS_ASSUME_NONNULL_END
