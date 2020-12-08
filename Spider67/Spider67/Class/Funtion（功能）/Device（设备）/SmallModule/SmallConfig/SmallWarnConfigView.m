//
//  SmallWarnConfigView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallWarnConfigView.h"
#import "SmallWarnInfoView.h"
#import "SmallWarnDetailsView.h"

@interface SmallWarnConfigView ()

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;
@property (nonatomic, strong) UIScrollView* scrollV;
@property (nonatomic, strong) UIButton* sure_btn;
@property (nonatomic, strong) SmallWarnInfoView* infoView;
@property (nonatomic, strong) SmallWarnDetailsView* detailsView;

@end
@implementation SmallWarnConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  whiteColor];
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.moreInfo_btn];
    [self addSubview:self.scrollV];
    [self.scrollV addSubview:self.infoView];
    [self.scrollV addSubview:self.detailsView];
    [self.scrollV addSubview:self.sure_btn];
    
    if (IS_IPHONE_Xx) {
        
    }else{
        self.scrollV.contentSize = CGSizeMake(0, self.height + 20);
    }
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.infoView.pab_lb.text = _pabStr;
    self.infoView.channelType_lb.text = _moduletype;
    self.infoView.channnelName_lb.text = dict[@"channelname"];
    self.infoView.defineName_lb.text = dict[@"channeltitle"];

    self.detailsView.group_id = _group_id;
    self.detailsView.dict = dict;
    
}

- (void)cancelBtnClick
{
   [self dismissView];
}

- (void)moreInfo_btnClick
{
    [DescriptionMaskView showPageViewWithtype:SmallAlarm];
}

- (void)sure_btnClick
{
    NSDictionary* dict = @{
      @"device_id": _dict[@"device_id"],
      @"channelname": _dict[@"channelname"],
      @"alarm_val_L": _detailsView.alarm_val_L,
      @"alarm_tag_L": _detailsView.alarm_tag_L,
      @"alarm_color_L": _detailsView.alarm_color_L,
      @"alarm_val_H": _detailsView.alarm_val_H,
      @"alarm_tag_H": _detailsView.alarm_tag_H,
      @"alarm_color_H": _detailsView.alarm_color_H
    };

    [CenterNet.shared saveWarnItemCompletionParm:dict completion:^(BOOL success) {
        [self dismissView];
    }];

}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.x = zScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:NSLocalizedString(@"告警设置", nil) fontSize:SPFont(30) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_titleLb sizeToFit];
    }
    return _titleLb;
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


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_back_big"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIScrollView *)scrollV
{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleLb.bottom + 15, self.width, (self.height -self.titleLb.bottom + 25))];
    }
    return _scrollV;
}

- (SmallWarnInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[SmallWarnInfoView alloc] initWithFrame:CGRectMake(25, 10, self.scrollV.width - 50, 133)];
    }
    
    return _infoView;
}

- (SmallWarnDetailsView *)detailsView
{
    if (!_detailsView) {
        _detailsView = [[SmallWarnDetailsView alloc] initWithFrame:CGRectMake(25, self.infoView.bottom + 25, self.scrollV.width - 50, 360)];
    }

    return _detailsView;
}

- (UIButton *)sure_btn
{
    if (!_sure_btn) {
        _sure_btn = [UIButton z_frame:CGRectMake(25, self.detailsView.bottom + 35,self.scrollV.width - 50 , 52)
                             fontSize:18
                         cornerRadius:6
                      backgroundColor:[UIColor colorWithHex:@"#26C464"]
                           titleColor:[UIColor colorWithHex:@"#FFFFFF"]
                                title:NSLocalizedString(@"确定", nil)
                               isbold:YES
                               Target:self
                               action:@selector(sure_btnClick)
                     ];
    }

    return _sure_btn;
}

@end
