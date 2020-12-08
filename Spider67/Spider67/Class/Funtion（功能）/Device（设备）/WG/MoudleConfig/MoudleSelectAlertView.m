//
//  MoudleSelectAlertView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MoudleSelectAlertView.h"
#import "MoudleMenu.h"

@interface MoudleSelectAlertView ()

@property (nonatomic, strong) UIButton* pa_btn;
@property (nonatomic, strong) UIButton* pb_btn;
@property (nonatomic, strong) UIButton* cancne_btn;
@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UIImageView* pa_btn_imgV;
@property (nonatomic, strong) UIImageView* pb_btn_imgV;

@end
@implementation MoudleSelectAlertView

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
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.cancne_btn];
    [self addSubview:self.imgV];
    [self addSubview:self.pa_btn];
    [self addSubview:self.pb_btn];
    [self.pa_btn addSubview:self.pa_btn_imgV];
    [self.pb_btn addSubview:self.pb_btn_imgV];
    
}

- (void)pa_btnClick:(UIButton *)sender
{
    _pa_btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _pa_btn.layer.borderWidth = 1;
    _pa_btn_imgV.hidden = NO;
    
    _pb_btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _pb_btn.layer.borderWidth = 0.5;
    _pb_btn_imgV.hidden = YES;
    
    NSString* mod_name = @"";
    switch (_mod_num) {
        case 100:
            mod_name = @"module_0.channel_0";
            break;
        case 101:
            mod_name = @"module_0.channel_2";
            break;
        case 102:
            mod_name = @"module_0.channel_4";
            break;
        case 103:
            mod_name = @"module_0.channel_6";
            break;
        case 104:
            mod_name = @"module_1.channel_0";
            break;
        case 105:
            mod_name = @"module_1.channel_2";
            break;
        case 106:
            mod_name = @"module_1.channel_4";
            break;
        case 107:
            mod_name = @"module_1.channel_6";
            break;
            
        default:
            break;
    }
    
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    MoudleMenu* mmV = [[MoudleMenu alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    mmV.channel_name = mod_name;
    mmV.dev_id = self.dev_id;
    mmV.group_id = self.group_id;
    mmV.moduletype = _moduletype;
    mmV.pabStr = sender.titleLabel.text;
    [zAppWindow.rootViewController.view addSubview:mmV];
}

- (void)pb_btnClick:(UIButton *)sender
{
    _pb_btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _pb_btn.layer.borderWidth = 1;
    _pb_btn_imgV.hidden = NO;
    
    _pa_btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _pa_btn.layer.borderWidth = 0.5;
    _pa_btn_imgV.hidden = YES;
    
    NSString* mod_name = @"";
    
    switch (_mod_num) {
        case 100:
            mod_name = @"module_0.channel_1";
            break;
        case 101:
            mod_name = @"module_0.channel_3";
            break;
        case 102:
            mod_name = @"module_0.channel_5";
            break;
        case 103:
            mod_name = @"module_0.channel_7";
            break;
        case 104:
            mod_name = @"module_1.channel_1";
            break;
        case 105:
            mod_name = @"module_1.channel_3";
            break;
        case 106:
            mod_name = @"module_1.channel_5";
            break;
        case 107:
            mod_name = @"module_1.channel_7";
            break;
            
        default:
            break;
    }
    
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    MoudleMenu* mmV = [[MoudleMenu alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    mmV.channel_name = mod_name;
    mmV.dev_id = self.dev_id;
    mmV.group_id = self.group_id;
    mmV.moduletype = _moduletype;
    mmV.pabStr = sender.titleLabel.text;

    [zAppWindow.rootViewController.view addSubview:mmV];
}

- (void)cancne_btnClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

#pragma mark - lazy

- (UIButton *)cancne_btn
{
    if (!_cancne_btn) {
        _cancne_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 36 - 15, 15, 36, 36)];
        [_cancne_btn setImage:[SVGKImage imageNamed:@"icon_reg_close"].UIImage forState:UIControlStateNormal];
        [_cancne_btn addTarget:self action:@selector(cancne_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancne_btn;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithImage:[SVGKImage imageNamed:@"pic_port"].UIImage];
        _imgV.center = self.center;
    }
    return _imgV;
}

- (UIButton *)pa_btn
{
    if (!_pa_btn) {
        _pa_btn = [UIButton z_frame:CGRectMake(self.imgV.left - 10 - 90, 0, 90, 46)
                           fontSize:17
                       cornerRadius:4
                        borderWidth:0.5
                        borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                    backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                         titleColor:[UIColor colorWithHex:@"#121212"]
                              title:@"P0_A"
                             isbold:NO
                             Target:self
                             action:@selector(pa_btnClick:)
                   ];
        _pa_btn.centerY = _imgV.centerY;
    }
    
    return _pa_btn;
}

- (UIButton *)pb_btn
{
    if (!_pb_btn) {
        _pb_btn = [UIButton z_frame:CGRectMake(self.imgV.right + 10 , 0, 90, 46)
                           fontSize:17
                       cornerRadius:4
                        borderWidth:0.5
                        borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                    backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                         titleColor:[UIColor colorWithHex:@"#121212"]
                              title:@"P0_B"
                             isbold:NO
                             Target:self
                             action:@selector(pb_btnClick:)
                   ];
        _pb_btn.centerY = _imgV.centerY;
    }
    
    return _pb_btn;
}

- (UIImageView *)pa_btn_imgV
{
    if (!_pa_btn_imgV) {
        _pa_btn_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.pa_btn.width - 18, 0, 18, 18)];
        _pa_btn_imgV.hidden = YES;
        _pa_btn_imgV.image = [SVGKImage imageNamed:@"icon_checkbox_s"].UIImage;
    }
    return _pa_btn_imgV;
}

- (UIImageView *)pb_btn_imgV
{
    if (!_pb_btn_imgV) {
        _pb_btn_imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.pb_btn.width - 18, 0, 18, 18)];
        _pb_btn_imgV.hidden = YES;
        _pb_btn_imgV.image = [SVGKImage imageNamed:@"icon_checkbox_s"].UIImage;
    }
    return _pb_btn_imgV;
}

@end
