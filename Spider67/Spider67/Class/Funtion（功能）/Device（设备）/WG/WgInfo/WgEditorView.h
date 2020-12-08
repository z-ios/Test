//
//  WgEditorView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ModulesListModel;
@interface WgEditorView : UIView

@property (nonatomic, strong) NSDictionary* deviceDict;
@property (nonatomic, strong) NSDictionary* mod0Dict;
@property (nonatomic, strong) NSDictionary* mod1Dict;
@property (nonatomic, strong) ModulesListModel* model0;
@property (nonatomic, strong) ModulesListModel* model1;

@end

NS_ASSUME_NONNULL_END
