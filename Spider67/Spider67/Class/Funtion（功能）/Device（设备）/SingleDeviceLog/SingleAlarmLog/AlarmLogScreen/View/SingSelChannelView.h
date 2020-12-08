//
//  SingSelChannelView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel;
@interface SingSelChannelView : UIView

@property (nonatomic, strong) NSArray<ChannelListModel *>* itemList;
@property (nonatomic, copy) void(^selChannelDatas)(NSMutableArray<ChannelListModel *> *selChannelList);

@end

NS_ASSUME_NONNULL_END
