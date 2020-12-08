//
//  WifiContentView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WifiContentView.h"

@interface WifiContentView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel* lineLb;
@property (nonatomic, strong) UILabel* ssidLb;
@property (nonatomic, strong) UILabel* pwdLb;

@end
@implementation WifiContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
//    [self addSubview:self.lineLb];
//    [self addSubview:self.ssidLb];
//    [self addSubview:self.ssidTf];
//    [self addSubview:self.pwdLb];
//    [self addSubview:self.pwdTf];
    
    
}

- (void)show
{
    
    [self addSubview:self.lineLb];
    [self addSubview:self.ssidLb];
    [self addSubview:self.ssidTf];
    [self addSubview:self.pwdLb];
    [self addSubview:self.pwdTf];
    
    self.lineLb.alpha = 0;
    self.ssidLb.alpha = 0;
    self.ssidTf.alpha = 0;
    self.pwdLb.alpha = 0;
    self.pwdTf.alpha = 0;
    self.ssidLb.y = 0;
    self.ssidTf.y = 0;
    self.pwdLb.y = 0;
    self.pwdTf.y = 0;
    
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.lineLb.alpha = 1;
        self.ssidLb.alpha = 1;
        self.ssidTf.alpha = 1;
        self.pwdLb.alpha = 1;
        self.pwdTf.alpha = 1;
        self.ssidLb.y = self.lineLb.bottom + SPH(25);
        self.ssidTf.y = self.ssidLb.bottom + 3;
        self.pwdLb.y = self.ssidTf.bottom + SPH(10);
        self.pwdTf.y = self.pwdLb.bottom + 3;
    } completion:nil];
    
    if (self.pwdTf.text.length > 0 && self.ssidTf.text.length >0) {
        if ([self.delegate respondsToSelector:@selector(wifiContentFinishType:)]) {
            [self.delegate wifiContentFinishType:YES];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(wifiContentFinishType:)]) {
            [self.delegate wifiContentFinishType:NO];
        }
    }
}

- (void)dismiss
{
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.lineLb.alpha = 0;
        self.ssidLb.alpha = 0;
        self.ssidTf.alpha = 0;
        self.pwdLb.alpha = 0;
        self.pwdTf.alpha = 0;
        self.ssidLb.y = 0;
        self.ssidTf.y = 0;
        self.pwdLb.y = 0;
        self.pwdTf.y = 0;
    } completion:nil];
    
}

- (UILabel *)lineLb
{
    if (!_lineLb) {
        _lineLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, 0.5)];
        _lineLb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _lineLb;
}

- (UILabel *)ssidLb
{
    if (!_ssidLb) {
        _ssidLb = [UILabel z_frame:CGRectMake(0,self.lineLb.bottom + SPH(25), 60, SPH(20))
                              Text:@"SSID"
                          fontSize:SPFont(14)
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _ssidLb;
}

- (UITextField *)ssidTf
{
    if (!_ssidTf) {
        _ssidTf = [[UITextField alloc] initWithFrame:CGRectMake(self.ssidLb.x, self.ssidLb.bottom + 3, self.width, SPH(48))];
        _ssidTf.borderStyle = UITextBorderStyleRoundedRect;
        _ssidTf.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _ssidTf.delegate = self;
        [_ssidTf addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];

    }
    return _ssidTf;
}

- (UILabel *)pwdLb
{
   if (!_pwdLb) {
        _pwdLb = [UILabel z_frame:CGRectMake(0,self.ssidTf.bottom + SPH(10), 100, SPH(20))
                              Text:@"Wifi password"
                          fontSize:SPFont(14)
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
       
    }
    return _pwdLb;
}

- (UITextField *)pwdTf
{
    if (!_pwdTf) {
        _pwdTf = [UITextField z_btnFrame:CGRectMake(0, 0, 40, 24)
                         norBtnImageName:@"icon_eye_close"
                         selBtnImageName:@"icon_eye_on"
                                  Target:self
                                  action:@selector(showPwd:)
                         secureTextEntry:YES
                                   frame:CGRectMake(self.pwdLb.x, self.pwdLb.bottom + 3, self.width, SPH(48))
                                 bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                            cornerRadius:0
                             borderWidth:0
                             borderColor:nil
                                    text:@""
                                textFont:[UIFont systemFontOfSize:SPFont(17)]
                               textColor:[UIColor colorWithHex:@"#121212"]
                             placeholder:nil
                         placeholderFont:nil
                        placeholderColor:nil
                             leftImgName:nil
                             leftImgSize:CGSizeZero
                            rightImgName:nil
                            rightImgSize:CGSizeZero
                  ];
        _pwdTf.borderStyle = UITextBorderStyleRoundedRect;
        [_pwdTf addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    return _pwdTf;
}

- (void)showPwd:(UIButton *)btn
{
    btn.selected = !btn.selected;
    self.pwdTf.secureTextEntry = !btn.selected;
    
}

#pragma mark -监听uitextfield的值得变化

-(void)changedTextField:(UITextField *)textField
{
    if (self.pwdTf.text.length > 0 && self.ssidTf.text.length >0) {
        if ([self.delegate respondsToSelector:@selector(wifiContentFinishType:)]) {
            [self.delegate wifiContentFinishType:YES];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(wifiContentFinishType:)]) {
            [self.delegate wifiContentFinishType:NO];
        }
    }
}



@end
