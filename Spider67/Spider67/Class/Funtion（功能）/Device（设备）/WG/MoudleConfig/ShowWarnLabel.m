//
//  ShowWarnLabel.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ShowWarnLabel.h"

@implementation ShowWarnLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.userInteractionEnabled = YES;
        [self addSubview:self.colorView];
        [self addSubview:self.deleBtn];
    }
    return self;
}

- (void)deleBtnClick
{
    if (self.deletWarmItem) {
        self.deletWarmItem();
    }
    
    [self removeFromSuperview];
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

- (UIButton *)deleBtn
{
    if (!_deleBtn) {
        _deleBtn = [UIButton new];
        [_deleBtn setImage:[SVGKImage imageNamed:@"icon_empty"].UIImage forState:UIControlStateNormal];
        [_deleBtn addTarget:self action:@selector(deleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleBtn;
}




@end
