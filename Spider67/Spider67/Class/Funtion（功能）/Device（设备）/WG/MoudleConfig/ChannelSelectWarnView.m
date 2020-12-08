//
//  ChannelSelectWarnView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ChannelSelectWarnView.h"
#import "SelectWarnItemView.h"

@interface ChannelSelectWarnView ()<DevicePtc>

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) SelectWarnItemView* warnItemView;
@property (nonatomic,strong) UIButton* sureBtn;
@property (nonatomic,strong) UIButton* cancelBtn;

@property (nonatomic,copy) NSString* valueStr;
@property (nonatomic,copy) NSString* colorStr;


@end
@implementation ChannelSelectWarnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 18;
    _valueStr = @"";
    _colorStr = @"";
    
    [self addSubview:self.title_lb];
    [self addSubview:self.warnItemView];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
    
    
}

- (void)setWarnItems:(NSArray *)warnItems
{
    _warnItems = warnItems;
    
    self.warnItemView.warnItems = _warnItems;
}

- (void)selectWarnColor:(NSString *)color value:(NSString *)value
{
    _colorStr = color;
    _valueStr = value;
}

- (void)sureClick
{
    if (_colorStr.length > 0) {
        if (self.selectWarnData) {
            self.selectWarnData(_colorStr, _valueStr);
        }
        NKAlertView *alertView = (NKAlertView *)self.superview;
        [alertView hide];
    }else{
        [MBhud showText:@"还没有选择颜色" addView:zAppWindow];
    }
    
}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}

#pragma mark - lazy

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(25, 30, self.width - 50, 33) Text:NSLocalizedString(@"选择一个标签（单选）", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _title_lb;
}

- (SelectWarnItemView *)warnItemView
{
    if (!_warnItemView) {
        _warnItemView = [[SelectWarnItemView alloc] initWithFrame:CGRectMake(15, self.title_lb.bottom + 35, self.width - 30, self.height - 64 - 35 - self.title_lb.bottom)];
        _warnItemView.delegate = self;
    }
    return _warnItemView;
}


- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                        norImageName:nil
                        selImageName:nil
                              Target:self
                              action:@selector(sureClick)
                               title:NSLocalizedString(@"确定", nil)
                            selTitle:nil
                                font:[UIFont boldSystemFontOfSize:SPFont(17)]
                       norTitleColor:[UIColor colorWithHex:@"#26C464"]
                       selTitleColor:nil
                             bgColor:nil
                        cornerRadius:0
                         borderWidth:0.5
                         borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                    ];
    }
    
    return _sureBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                          norImageName:nil
                          selImageName:nil
                                Target:self
                                action:@selector(cancelClick)
                                 title:NSLocalizedString(@"取消", nil)
                              selTitle:nil
                                  font:[UIFont boldSystemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#808080"]
                         selTitleColor:nil
                               bgColor:nil
                          cornerRadius:0
                           borderWidth:0.5
                           borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                      ];
    }
    
    return _cancelBtn;
}


@end
