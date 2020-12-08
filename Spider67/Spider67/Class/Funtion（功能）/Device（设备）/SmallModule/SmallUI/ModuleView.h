//
//  ModuleView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ModulesListModel;
@interface ModuleView : UIView

@property (nonatomic, copy) NSString* group_id;
@property (nonatomic, strong) ModulesListModel* model;

@end

NS_ASSUME_NONNULL_END
