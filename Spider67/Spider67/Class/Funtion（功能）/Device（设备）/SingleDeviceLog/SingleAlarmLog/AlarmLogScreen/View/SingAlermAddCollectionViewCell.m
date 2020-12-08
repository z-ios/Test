//
//  SingAlermAddCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingAlermAddCollectionViewCell.h"

@interface SingAlermAddCollectionViewCell ()

@end
@implementation SingAlermAddCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imgV.frame = self.bounds;
    
}

- (void)setupUI{
    
    [self addSubview:self.imgV];
}

#pragma - lazy

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgV;
}

@end
