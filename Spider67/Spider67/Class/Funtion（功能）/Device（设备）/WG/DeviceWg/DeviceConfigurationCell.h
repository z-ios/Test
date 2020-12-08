//
//  DeviceConfigurationCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ModulesListModel;
@interface DeviceConfigurationCell : UICollectionViewCell

@property (nonatomic, strong) NSDictionary* deviceDict;
@property (nonatomic, strong) ModulesListModel* model0;
@property (nonatomic, strong) ModulesListModel* model1;

@end

NS_ASSUME_NONNULL_END
