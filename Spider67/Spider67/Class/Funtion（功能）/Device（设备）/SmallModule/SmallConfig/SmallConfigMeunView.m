//
//  SmallConfigMeunView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallConfigMeunView.h"
#import "SmallMeunContentView.h"
#import "ChannelListModel.h"

@interface SmallConfigMeunView ()

@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong) SmallMeunContentView* contentView;
@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;

@end
@implementation SmallConfigMeunView

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
    [self.topView addSubview:self.moreInfo_btn];
    self.topView.y = -161;
    self.contentView.y = self.height;
    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topView.y = 0;
        self.contentView.y = 161;
    } completion:nil];

}

- (void)setChannelModel:(ChannelListModel *)channelModel
{
    _channelModel = channelModel;
    
    _titleLb.text = _channelModel.port;
    [_titleLb sizeToFit];
    _moreInfo_btn.x = self.titleLb.right + 15;
    _moreInfo_btn.centerY = self.titleLb.centerY;
    _contentView.group_id = _group_id;
    _contentView.moduletype = _moduletype;
    _contentView.channelModel = _channelModel;
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

- (void)moreInfo_btnClick
{
    [DescriptionMaskView showPageViewWithtype:Small];
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:@"--" fontSize:34 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
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

- (UIButton *)moreInfo_btn
{
    if (!_moreInfo_btn) {
        _moreInfo_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleLb.right + 15, 0, 24, 24)];
        [_moreInfo_btn setImage:[SVGKImage imageNamed:@"icon_confi_information"].UIImage forState:UIControlStateNormal];
        _moreInfo_btn.centerY = self.titleLb.centerY;
        [_moreInfo_btn addTarget:self action:@selector(moreInfo_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreInfo_btn;
}

- (SmallMeunContentView *)contentView
{
    if (!_contentView) {
        _contentView=  [[SmallMeunContentView alloc] initWithFrame:CGRectMake(0, 161, self.width, self.height - 161)];
    }
    return _contentView;
}


@end
