//
//  IoTHubView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IoTHubView.h"

@interface IoTHubView ()

@property (nonatomic, strong) UILabel* mqttTitleLb;
@property (nonatomic, strong) UILabel* ipTitleLb;
@property (nonatomic, strong) UIButton* sureBtn;

@end
@implementation IoTHubView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 18;
    
    [self addSubview:self.nameLb];
    [self addSubview:self.mqttTitleLb];
    [self addSubview:self.mqttLb];
    [self addSubview:self.ipTitleLb];
    [self addSubview:self.ipLb];
    [self addSubview:self.sureBtn];
}

- (void)sureBtnClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}


- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel z_frame:CGRectMake(25, 30, self.width - 50, 33) Text:@"阿里云-1" fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _nameLb;
}

- (UILabel *)mqttTitleLb
{
    if (!_mqttTitleLb) {
        _mqttTitleLb = [UILabel z_frame:CGRectMake(39, self.nameLb.bottom + 25, 70, 28) Text:@"MQTT" fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _mqttTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _mqttTitleLb;
}

- (UILabel *)mqttLb
{
     if (!_mqttLb) {
          _mqttLb = [UILabel z_frame:CGRectMake(44, self.mqttTitleLb.bottom + 8, self.width - 50, 24) Text:@"3344" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
      }
      return _mqttLb;
}

- (UILabel *)ipTitleLb
{
    if (!_ipTitleLb) {
        _ipTitleLb = [UILabel z_frame:CGRectMake(39, self.mqttLb.bottom + 20, 78, 28) Text:@"Root IP" fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _ipTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _ipTitleLb;
}

- (UILabel *)ipLb
{
     if (!_ipLb) {
          _ipLb = [UILabel z_frame:CGRectMake(44, self.ipTitleLb.bottom + 8, self.width - 50, 24) Text:@"39.123.56.209" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
      }
      return _ipLb;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_svg_setImageName:nil fontSize:17 titleColor:[UIColor colorWithHex:@"#26C464"] title:NSLocalizedString(@"确定", nil) isbold:YES];
        _sureBtn.frame = CGRectMake(0, self.height - 64, self.width, 64);
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _sureBtn.width, 0.5)];
        line.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
        [_sureBtn addSubview:line];
    }
    return _sureBtn;
}


@end
