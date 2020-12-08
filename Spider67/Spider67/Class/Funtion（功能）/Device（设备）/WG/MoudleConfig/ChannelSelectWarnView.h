//
//  ChannelSelectWarnView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelSelectWarnView : UIView

@property (nonatomic, strong) NSArray* warnItems;
@property (nonatomic, copy) void(^selectWarnData)(NSString* colorStr, NSString* valueStr);

@end

NS_ASSUME_NONNULL_END
