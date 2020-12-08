//
//  LanguageAlertView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LanguageAlertView.h"
#import "IWTabBarController.h"

@interface LanguageAlertView ()

@property (nonatomic, strong) UIButton* chBtn;
@property (nonatomic, strong) UIButton* enBtn;
@property (nonatomic, strong) UIImageView* enImg;
@property (nonatomic, strong) UIImageView* chImg;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* subtitleLb;
@property (nonatomic, strong) UIButton* sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@end
@implementation LanguageAlertView

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
    
    [self addSubview:self.titleLb];
    [self addSubview:self.subtitleLb];
    [self addSubview:self.chBtn];
    [self addSubview:self.enBtn];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
    

    if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hans"]) {
        [self selectedChBtn];
    }else{
        [self selectedEhBtn];
    }
         
}

#pragma mark - btnClick
- (void)sureClick
{
    
    if (_chBtn.selected == YES) {
        [DAConfig setUserLanguage:@"zh-Hans"];
    }else{
        [DAConfig setUserLanguage:@"en"];
    }
    
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        UITabBarController *tbc = [IWTabBarController new];
        [UIApplication sharedApplication].keyWindow.rootViewController = tbc;
        [UIView setAnimationsEnabled:oldState];
        
        tbc.selectedIndex = 3;
        
    } completion:nil];
    
}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];

}

- (void)chBtnClick:(UIButton *)btn
{
    [self selectedChBtn];
}

- (void)enBtnClick:(UIButton *)btn
{
    [self selectedEhBtn];
}

- (void)selectedChBtn
{
    _chBtn.selected = YES;
    _chBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _chBtn.layer.borderWidth = 1;
    _chBtn.backgroundColor = [UIColor colorWithHex:@"#26C464" alpha:0.05];
    _chImg.hidden = NO;
    
    _enBtn.selected = NO;
    _enBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _enBtn.layer.borderWidth = 0.5;
    _enBtn.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    _enImg.hidden = YES;
    
    self.titleLb.text = @"请选择语言";
    self.subtitleLb.text = @"系统当前语言为：简体中文";
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];

}
- (void)selectedEhBtn
{
    _enBtn.selected = YES;
    _enBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _enBtn.layer.borderWidth = 1;
    _enBtn.backgroundColor = [UIColor colorWithHex:@"#26C464" alpha:0.05];
    _enImg.hidden = NO;
    
    _chBtn.selected = NO;
    _chBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _chBtn.layer.borderWidth = 0.5;
    _chBtn.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    _chImg.hidden = YES;
    
    self.titleLb.text = @"Please select language";
    self.subtitleLb.text = @"Current language of the system is:English";
    [self.cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.sureBtn setTitle:@"Ok" forState:UIControlStateNormal];
}


#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(SPW(25), SPH(40), self.width - SPW(50), SPH(33))
                               Text:NSLocalizedString(@"请选择语言", nil)
                           fontSize:SPFont(24)
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _titleLb;
}

- (UILabel *)subtitleLb
{
    if (!_subtitleLb) {
        _subtitleLb = [UILabel z_frame:CGRectMake(SPW(25), self.titleLb.bottom + SPH(10), self.width - SPW(50), SPH(20))
                                  Text:@"系统当前语言为:简体中文"
                              fontSize:SPFont(14)
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    return _subtitleLb;
}

- (UIButton *)chBtn
{
    if (!_chBtn) {
        CGFloat w = (self.width - SPW(25)*2 - 10)*0.5;
        _chBtn = [UIButton z_svg_frame:CGRectMake(SPW(25), self.subtitleLb.bottom + SPH(30), w, SPH(128))
                          norImageName:@"icon_language_chinese_default"
                          selImageName:@"icon_language_chinese_highlight"
                                Target:self
                                action:@selector(chBtnClick:)
                                 title:@"简体中文"
                              selTitle:@"简体中文"
                                  font:[UIFont systemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#121212"]
                         selTitleColor:[UIColor colorWithHex:@"#121212"]
                               bgColor:[UIColor colorWithHex:@"#26C464" alpha:0.05]
                          cornerRadius:8
                           borderWidth:1
                           borderColor:[UIColor colorWithHex:@"#26C464"]
                  ];
        
        [_chBtn setTitleEdgeInsets:UIEdgeInsetsMake(_chBtn.imageView.frame.size.height +10 ,-_chBtn.imageView.frame.size.width, 0.0,0.0)];
        [_chBtn setImageEdgeInsets:UIEdgeInsetsMake(-20, 0.0,0.0, -_chBtn.titleLabel.intrinsicContentSize.width)];
        [_chBtn addSubview:self.chImg];
    }
    return _chBtn;
}

- (UIImageView *)chImg
{
    if (!_chImg) {
        _chImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.chBtn.width - 18, 0, 18, 18)];
        _chImg.image = [SVGKImage imageNamed:@"icon_server_highlight"].UIImage;
        
    }
    return _chImg;
}

- (UIButton *)enBtn
{
    if (!_enBtn) {
        CGFloat w = (self.width - SPW(25)*2 - 10)*0.5;
        _enBtn = [UIButton z_svg_frame:CGRectMake(self.chBtn.right + 10, self.subtitleLb.bottom + SPH(30), w, SPH(128))
                          norImageName:@"icon_language_english_default"
                          selImageName:@"icon_language_english_highlight"
                                Target:self
                                action:@selector(enBtnClick:)
                                 title:@"English"
                              selTitle:@"English"
                                  font:[UIFont systemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#121212"]
                         selTitleColor:[UIColor colorWithHex:@"#121212"]
                               bgColor:[UIColor colorWithHex:@"#26C464" alpha:0.05]
                          cornerRadius:8
                           borderWidth:1
                           borderColor:[UIColor colorWithHex:@"#26C464"]
                  ];
        [_enBtn setTitleEdgeInsets:UIEdgeInsetsMake(_enBtn.imageView.frame.size.height +10 ,-_enBtn.imageView.frame.size.width, 0.0,0.0)];
        [_enBtn setImageEdgeInsets:UIEdgeInsetsMake(-20, 0.0,0.0, -_enBtn.titleLabel.intrinsicContentSize.width)];
        [_enBtn addSubview:self.enImg];
    }
    return _enBtn;
}

- (UIImageView *)enImg
{
    if (!_enImg) {
        _enImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.enBtn.width - 18, 0, 18, 18)];
        _enImg.image = [SVGKImage imageNamed:@"icon_server_highlight"].UIImage;
        
    }
    return _enImg;
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
