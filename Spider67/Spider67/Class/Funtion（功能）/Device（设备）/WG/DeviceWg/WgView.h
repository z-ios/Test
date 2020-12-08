//
//  WgView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ChannelListModel;
@interface WgView : UIView

@property (nonatomic, strong) NSDictionary* deviceDict;
@property (nonatomic, strong) NSArray<ChannelListModel *>* channels0;
@property (nonatomic, strong) NSArray<ChannelListModel *>* channels1;
@property (nonatomic, copy) NSString* moduletypeStr0;
@property (nonatomic, copy) NSString* moduletypeStr1;

@end

NS_ASSUME_NONNULL_END
