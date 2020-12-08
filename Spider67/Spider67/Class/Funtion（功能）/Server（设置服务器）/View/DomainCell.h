//
//  DomainCell.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainCell : UICollectionViewCell
@property (nonatomic, assign) CGFloat ipW;
@property (nonatomic, strong) UITextField* domainTf;
@property (nonatomic, weak) id<ServerPtc> delegate;
@end

NS_ASSUME_NONNULL_END
