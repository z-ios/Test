//
//  SingleSendItemView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SingleSendItemModel;
@interface SingleSendItemView : UIView

@property (nonatomic, strong) NSArray<SingleSendItemModel *>* itemList;
@property (nonatomic, copy) void(^selSendDatas)(NSMutableArray<SingleSendItemModel *> *selSendList);

@end

NS_ASSUME_NONNULL_END
