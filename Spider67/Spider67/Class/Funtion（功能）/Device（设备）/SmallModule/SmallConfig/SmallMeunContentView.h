//
//  SmallMeunContentView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel;
@interface SmallMeunContentView : UIView

@property (nonatomic, copy) NSString* moduletype;
@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) ChannelListModel* channelModel;

@end

NS_ASSUME_NONNULL_END
