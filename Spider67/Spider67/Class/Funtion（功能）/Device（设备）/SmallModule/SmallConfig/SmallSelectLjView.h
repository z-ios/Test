//
//  SmallSelectLjView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmallSelectLjView : UIView

@property (nonatomic, copy) NSString* dataStr;
@property (nonatomic, copy) void(^selectSymbol)(NSString *symbolStr);

@end

NS_ASSUME_NONNULL_END
