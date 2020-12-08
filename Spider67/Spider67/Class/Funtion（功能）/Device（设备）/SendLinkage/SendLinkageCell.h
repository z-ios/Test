//
//  SendLinkageCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/9.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendLinkageModel;
NS_ASSUME_NONNULL_BEGIN

@interface SendLinkageCell : UITableViewCell


@property (nonatomic, weak) id<DevicePtc> delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) SendLinkageModel *model;

@end

NS_ASSUME_NONNULL_END
