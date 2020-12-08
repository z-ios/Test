//
//  MoudleMenu.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MoudleMenu.h"
#import "MoudleMenuConfigView.h"

@interface MoudleMenu ()

@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong) MoudleMenuConfigView* contentView;
@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;

@end
@implementation MoudleMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  clearColor];
    [self addSubview:self.topView];
    [self addSubview:self.contentView];
    [self.topView addSubview:self.cancelBtn];
    [self.topView addSubview:self.titleLb];
    self.topView.y = -161;
    self.contentView.y = self.height;
    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topView.y = 0;
        self.contentView.y = 161;
    } completion:nil];

}

- (void)cancelBtnClick
{
    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topView.y = -161;
        self.contentView.y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

- (void)setPabStr:(NSString *)pabStr
{
    _pabStr = pabStr;
    
    self.titleLb.text = _pabStr;
    
    self.contentView.moduletype = _moduletype;
    self.contentView.dev_id = _dev_id;
    self.contentView.channel_name = _channel_name;
    self.contentView.pabStr = _pabStr;
    self.contentView.group_id = _group_id;
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 100, 48) Text:@"--" fontSize:34 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _titleLb;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 161)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    
    return _topView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_registor_close"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (MoudleMenuConfigView *)contentView
{
    if (!_contentView) {
        _contentView=  [[MoudleMenuConfigView alloc] initWithFrame:CGRectMake(0, 161, self.width, self.height - 161)];
    }
    return _contentView;
}


@end
