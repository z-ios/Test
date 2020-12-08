//
//  WarnItemBtn.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WarnItemBtn.h"

@implementation WarnItemBtn

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.colorView];
        [self addSubview:self.selectImgV];
    }
    return self;
}

#pragma mark - lazy

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor whiteColor];
        _colorView.layer.cornerRadius = 2;
    }
    return _colorView;
}

- (UIImageView *)selectImgV
{
    if (!_selectImgV) {
        _selectImgV = [[UIImageView alloc] init];
        _selectImgV.image = [SVGKImage imageNamed:@"icon_add"].UIImage;
    }
    return _selectImgV;
}



@end
