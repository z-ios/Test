//
//  SingleSelectAlarmView.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SingAlarmItemModel;
@interface SingleSelectAlarmView : UIView

@property (nonatomic, strong) NSArray<SingAlarmItemModel *>* itemList;
@property (nonatomic, copy) void(^selAlarmDatas)(NSMutableArray<SingAlarmItemModel *> *selAlarmList);

@end

NS_ASSUME_NONNULL_END
