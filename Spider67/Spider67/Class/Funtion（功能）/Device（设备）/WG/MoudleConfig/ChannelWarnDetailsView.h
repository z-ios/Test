//
//  ChannelWarnDetailsView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChannelWarnDetailsView : UIView

@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, copy) NSDictionary* dict;

@property (nonatomic, copy) NSString *alarm_tag_L;
@property (nonatomic, copy) NSString *alarm_color_L;
@property (nonatomic, copy) NSString *alarm_tag_H;
@property (nonatomic, copy) NSString *alarm_color_H;

@end

NS_ASSUME_NONNULL_END
