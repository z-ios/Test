//
//  DescriptionView.h
//  Spider67
//
//  Created by 宾哥 on 2020/11/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    Small,
    SmallChannel,
    SmallGs,
    SmallAlarm,
    SmallLinkage,
    WgChannel,
} DescriptionType;
@interface DescriptionView : UIView

@property (nonatomic, assign) DescriptionType type;

@end

NS_ASSUME_NONNULL_END
