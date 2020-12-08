//
//  SmallWarnDetailsView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallWarnDetailsView.h"
#import "ChannelSelectWarnView.h"
#import "ShowWarnLabel.h"

@interface SmallWarnDetailsView ()

@property (nonatomic, strong) UILabel* h_t_lb;
@property (nonatomic, strong) NumberCalculate *h_numberView;
@property (nonatomic, strong) UIButton* h_btn;
@property (nonatomic, strong) UILabel* l_t_lb;
@property (nonatomic, strong) NumberCalculate *l_numberView;
@property (nonatomic, strong) UIButton* l_btn;

@end
@implementation SmallWarnDetailsView

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
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.layer.shadowOpacity = 10;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    [self addSubview:self.h_t_lb];
    [self addSubview:self.h_numberView];
    [self addSubview:self.h_btn];
    [self addSubview:self.l_t_lb];
    [self addSubview:self.l_numberView];
    [self addSubview:self.l_btn];
    
    zWEAKSELF
    self.h_numberView.resultNumber = ^(NSString *number) {
        weakSelf.alarm_val_H = number;
    };
    
    self.l_numberView.resultNumber = ^(NSString *number) {
        weakSelf.alarm_val_L = number;
    };
    
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    _alarm_color_H = _dict[@"alarm_color_H"];
    _alarm_color_L = _dict[@"alarm_color_L"];
    _alarm_tag_H = _dict[@"alarm_tag_H"];
    _alarm_tag_L = _dict[@"alarm_tag_L"];
    
    
    if ([_dict[@"alarm_val_H"] isEqualToString:@""]) {
        _h_numberView.baseNum = @"1";
        _alarm_val_H = @"1";
        
    }else{
        _h_numberView.baseNum = _dict[@"alarm_val_H"];
        _alarm_val_H = _dict[@"alarm_val_H"];
    }
    if ([_dict[@"alarm_val_L"] isEqualToString:@""]) {
        _l_numberView.baseNum = @"1";
        _alarm_val_L = @"1";
    }else{
        _l_numberView.baseNum = _dict[@"alarm_val_L"];
        _alarm_val_L = _dict[@"alarm_val_L"];
    }
    
    if (_alarm_color_H.length > 0) {
        [self ShowSelectWarnLabelWithType:@"H" colorStr:_dict[@"alarm_color_H"] valueStr:_dict[@"alarm_tag_H"]];
    }
    if (_alarm_color_L.length > 0) {
        [self ShowSelectWarnLabelWithType:@"L" colorStr:_dict[@"alarm_color_L"] valueStr:_dict[@"alarm_tag_L"]];
    }
}

- (void)h_btnClick
{
    [self showSelectWarnView:@"H"];
}

- (void)l_btnClick
{
    [self showSelectWarnView:@"L"];
}

- (void)showSelectWarnView:(NSString *)type
{
    [CenterNet.shared checkWarnItemCompletionParm:_group_id completion:^(NSArray * _Nullable dataList) {
        ChannelSelectWarnView* eview = [[ChannelSelectWarnView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 554)];
        eview.warnItems = dataList;
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
        nkView.contentView = eview;
        [nkView show];
        eview.selectWarnData = ^(NSString * _Nonnull colorStr, NSString * _Nonnull valueStr) {
            [self ShowSelectWarnLabelWithType:type colorStr:colorStr valueStr:valueStr];
        };
    }];
}

- (void)ShowSelectWarnLabelWithType:(NSString *)type colorStr:(NSString *)colorStr valueStr:(NSString *)valueStr
{
    ShowWarnLabel* lb = [ShowWarnLabel new];
    lb.text = valueStr;
    CGSize contentSize = [NSObject sizeWidthWidth:valueStr font:[UIFont systemFontOfSize:17] maxHeight:58];
    CGFloat lb_Width = contentSize.width + 93;
    if ([type isEqualToString:@"H"]) {
        lb.frame = CGRectMake(20, self.h_numberView.bottom + 10, lb_Width, 58);
        self.h_btn.hidden = YES;
        lb.deletWarmItem = ^{
            self.h_btn.hidden = NO;
            self.alarm_color_H = @"";
            self.alarm_tag_H = @"";
        };
        _alarm_color_H = colorStr;
        _alarm_tag_H = valueStr;
    }else{
        lb.frame = CGRectMake(20, self.l_numberView.bottom + 10, lb_Width, 58);
        self.l_btn.hidden = YES;
        lb.deletWarmItem = ^{
            self.l_btn.hidden = NO;
            self.alarm_color_L = @"";
            self.alarm_tag_L = @"";
        };
        _alarm_color_L = colorStr;
        _alarm_tag_L = valueStr;
    }
    
    lb.colorView.frame = CGRectMake(15, (lb.height - 24)*0.5, 24, 24);
    lb.colorView.backgroundColor = [UIColor colorWithHex:colorStr];
    lb.deleBtn.frame = CGRectMake(lb_Width - 24 - 10, (lb.height - 24)*0.5, 24, 24);
    
    [self addSubview:lb];
    
}

#pragma mark - lazy

- (UILabel *)h_t_lb
{
    if (!_h_t_lb) {
        _h_t_lb = [UILabel z_frame:CGRectMake(20, 20, self.width - 40, 20)
                              Text:[NSString stringWithFormat:@"%@（H）",NSLocalizedString(@"高阈值", nil)]
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _h_t_lb;
}



- (NumberCalculate *)h_numberView
{
    if (!_h_numberView) {
        _h_numberView = [[NumberCalculate alloc]initWithFrame:CGRectMake(20, self.h_t_lb.bottom + 10, self.width - 40, 52)];
        _h_numberView.numborderColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
        _h_numberView.baseNum = @"1000";
        _h_numberView.isShake = YES;
        
    }
    return _h_numberView;
}

- (UIButton *)h_btn
{
    if (!_h_btn) {
        _h_btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.h_numberView.bottom + 10, 190, 58)];
        [_h_btn setImage:[UIImage imageNamed:[[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"tag_notset_chinese" : @"tag_notset_english"] forState:UIControlStateNormal];
        [_h_btn addTarget:self action:@selector(h_btnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _h_btn;
}

- (UILabel *)l_t_lb
{
    if (!_l_t_lb) {
        _l_t_lb = [UILabel z_frame:CGRectMake(20, self.h_btn.bottom + 20, self.width - 40, 20)
                              Text:[NSString stringWithFormat:@"%@（L）",NSLocalizedString(@"低阈值", nil)]
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _l_t_lb;
}

- (NumberCalculate *)l_numberView
{
    if (!_l_numberView) {
        _l_numberView = [[NumberCalculate alloc]initWithFrame:CGRectMake(20, self.l_t_lb.bottom + 10, self.width - 40, 52)];
        _l_numberView.numborderColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
        _l_numberView.isShake = YES;
        _l_numberView.baseNum = @"1000";
        _l_numberView.layer.cornerRadius = 6;
    }
    return _l_numberView;
}

- (UIButton *)l_btn
{
    if (!_l_btn) {
        _l_btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.l_numberView.bottom + 10, 190, 58)];
        [_l_btn setImage:[UIImage imageNamed:[[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"tag_notset_chinese" : @"tag_notset_english"] forState:UIControlStateNormal];
        [_l_btn addTarget:self action:@selector(l_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _l_btn;
}


@end
