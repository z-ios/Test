//
//  FinishRegisterCollectionViewCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FinishRegisterCollectionViewCell : UICollectionViewCell<RegisterPtc>

@property (nonatomic, weak) id<RegisterPtc> delegate;

@end

NS_ASSUME_NONNULL_END
