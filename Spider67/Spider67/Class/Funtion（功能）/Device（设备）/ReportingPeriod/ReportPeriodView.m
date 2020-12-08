//
//  ReportPeriodView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ReportPeriodView.h"
#import "ReportPeriodSlider.h"

@interface ReportPeriodView ()

@property (nonatomic, strong) UILabel* t_lb;
@property (nonatomic, strong) NumberCalculate *period_numberView;
@property (nonatomic, strong) ReportPeriodSlider *slider;
@property (nonatomic, strong) UILabel* mincycle_lb;
@property (nonatomic, strong) UILabel* maxcycle_lb;

@end
@implementation ReportPeriodView

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
    
    [self addSubview:self.t_lb];
    [self addSubview:self.period_numberView];
    [self addSubview:self.mincycle_lb];
    [self addSubview:self.maxcycle_lb];
    [self addSubview:self.slider];
    
    zWEAKSELF
    self.period_numberView.resultNumber = ^(NSString *number) {
        [weakSelf.slider setValue:[number integerValue] animated:YES];
        weakSelf.NumberStr = number;
    };
    
}

- (void)setNumberStr:(NSString *)NumberStr
{
    _NumberStr = NumberStr;
    _period_numberView.baseNum = _NumberStr;
    [self.slider setValue:[_NumberStr integerValue] animated:YES];
    
}


- (void)sliderChange:(ReportPeriodSlider*)slider
{
    _period_numberView.baseNum = @([@(slider.value) integerValue]).description;
    _NumberStr = _period_numberView.baseNum;
}

- (UILabel *)t_lb
{
    if (!_t_lb) {
        _t_lb = [UILabel z_frame:CGRectMake(20, 30, self.width - 40, 20) Text:[NSString stringWithFormat:@"%@：s（%@）",NSLocalizedString(@"单位", nil),NSLocalizedString(@"秒", nil)] fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _t_lb.textAlignment = NSTextAlignmentRight;
    }
    
    return _t_lb;
}


- (NumberCalculate *)period_numberView
{
    if (!_period_numberView) {
        _period_numberView = [[NumberCalculate alloc]initWithFrame:CGRectMake(self.width - 267 - 20, self.t_lb.bottom + 5, 267, 52)];
        _period_numberView.numborderColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
        _period_numberView.isShake = YES;
        _period_numberView.baseNum = @"1";
        _period_numberView.maxNum = 3600;
        _period_numberView.layer.cornerRadius = 6;
    }
    return _period_numberView;
}

- (ReportPeriodSlider *)slider
{
    if (!_slider) {
        _slider = [[ReportPeriodSlider alloc] initWithFrame:CGRectMake(30, self.period_numberView.bottom, self.width - 60, 60)];
        [_slider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UILabel *)mincycle_lb
{
    if (!_mincycle_lb) {
        _mincycle_lb = [[UILabel alloc] initWithFrame:CGRectMake(24, self.period_numberView.bottom + 25, 10, 10)];
        _mincycle_lb.layer.borderColor = [UIColor colorWithHex:@"#DADDE2"].CGColor;
        _mincycle_lb.layer.borderWidth = 1;
        _mincycle_lb.layer.cornerRadius = 5;
        _mincycle_lb.layer.masksToBounds = YES;
    }
    
    return _mincycle_lb;
}

- (UILabel *)maxcycle_lb
{
    if (!_maxcycle_lb) {
        _maxcycle_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 34, self.period_numberView.bottom + 25, 10, 10)];
        _maxcycle_lb.layer.borderColor = [UIColor colorWithHex:@"#DADDE2"].CGColor;
        _maxcycle_lb.layer.borderWidth = 1;
        _maxcycle_lb.layer.cornerRadius = 5;
        _maxcycle_lb.layer.masksToBounds = YES;
    }
    
    return _maxcycle_lb;
}
@end
