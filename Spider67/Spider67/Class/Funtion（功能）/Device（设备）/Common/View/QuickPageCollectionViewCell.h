//
//  QuickPageCollectionViewCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PageModel;
@interface QuickPageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PageModel* model;

@end

NS_ASSUME_NONNULL_END
