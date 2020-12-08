//
//  LinkagePerformView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkagePerformView : UIView

@property (nonatomic, strong) NSDictionary* dict;
@property (nonatomic, copy) NSArray* linkageList;
@property (nonatomic, copy) NSString* relationStr;
@property (nonatomic, strong) UITextField* perform_tf;

@end

NS_ASSUME_NONNULL_END
