//
//  DeviceLineCollectionViewCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceLineCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<RegisterPtc> delegate;

@end

NS_ASSUME_NONNULL_END
