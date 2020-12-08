//
//  SmallLinkageDetailsView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmallLinkageDetailsView : UIView

@property (nonatomic, strong) NSDictionary* dict;
@property (nonatomic, copy) NSArray* linkageList;
@property (nonatomic, strong) UITextField* perform_tf;
@property (nonatomic, strong) UITextField* performlj_tf;
@property (nonatomic, copy) NSString* relationval;

@end

NS_ASSUME_NONNULL_END
