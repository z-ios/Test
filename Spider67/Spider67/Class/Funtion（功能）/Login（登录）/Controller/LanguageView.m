//
//  LanguageView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LanguageView.h"

@interface LanguageView ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* subtitleLabel;

@property (nonatomic, strong) UIButton* chBtn;
@property (nonatomic, strong) UIButton* enBtn;
@property (nonatomic, strong) UIButton* sureBtn;
@property (nonatomic, strong) UILabel* zhuLabel;

@end
@implementation LanguageView

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
    self.layer.cornerRadius = 34;
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.chBtn];
    [self addSubview:self.enBtn];
    [self addSubview:self.sureBtn];
    [self addSubview:self.zhuLabel];
    
    if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hans"]) {
        [self setChLanguage];
    }else{
        [self setEnLanguage];
    }
}

#pragma mark - 设置语言

- (void)chBtnClick:(UIButton *)btn
{
    [self setChLanguage];
}

- (void)enBtnClick:(UIButton *)btn
{
    [self setEnLanguage];
}

- (void)setChLanguage{
    
    self.chBtn.selected = YES;
    self.chBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    self.chBtn.layer.borderWidth = 1;
    self.enBtn.selected = NO;
    self.enBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.enBtn.layer.borderWidth = 0.5;
    
    self.titleLabel.text = @"请选择您的语言";
    self.subtitleLabel.text = @"系统检测您当前语言为：简体中文";
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.zhuLabel.text = @"注：您还可以在[设置]中随时切换语言";
    
}
- (void)setEnLanguage{
    
    self.enBtn.selected = YES;
    self.enBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    self.enBtn.layer.borderWidth = 1;
    self.chBtn.selected = NO;
    self.chBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.chBtn.layer.borderWidth = 0.5;
    
    self.titleLabel.text = @"Please select language";
    self.subtitleLabel.text = @"The system detects your current language is:English";
    [self.sureBtn setTitle:@"OK" forState:UIControlStateNormal];
    self.zhuLabel.text = @"Ps:You can switch languages at any time in [SET]";
    
}
- (void)sureBtnClick
{
    if (_chBtn.selected == YES) {
        if (self.setSuccessLanguage) {
            self.setSuccessLanguage(@"ch");
        }
    }else{
        if (self.setSuccessLanguage) {
            self.setSuccessLanguage(@"en");
        }
    }
}

#pragma mark - lazy

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel z_frame:CGRectMake(SPW(26), SPH(40), self.width - SPW(26), SPH(33))
                                  Text:NSLocalizedString(@"请选择您的语言", nil)
                              fontSize:SPFont(24)
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
        
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel z_frame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom + SPH(5), self.width - SPW(40), SPH(42))
                                     Text:@"系统检测您当前语言为:简体中文"
                                 fontSize:SPFont(14)
                                    color:[UIColor colorWithHex:@"#808080"]
                                   isbold:NO
                          ];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UIButton *)chBtn
{
    if (!_chBtn) {
        _chBtn = [UIButton z_frame:CGRectMake(self.subtitleLabel.x, self.subtitleLabel.bottom + SPH(30), self.width - SPW(26)*2, SPH(73))
                              norImageName:@"icon_default"
                              selImageName:@"icon_highlight"
                                    Target:self
                                    action:@selector(chBtnClick:)
                                     title:@"简体中文"
                                  selTitle:@"简体中文"
                                      font:[UIFont systemFontOfSize:SPFont(17)]
                             norTitleColor:[UIColor colorWithHex:@"#B5B5B5"]
                             selTitleColor:[UIColor colorWithHex:@"#121212"]
                                   bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                              cornerRadius:8
                               borderWidth:1
                               borderColor:[UIColor colorWithHex:@"#26C464"]
                          ];
        
        _chBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        _chBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, _chBtn.width*0.5);
        _chBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _chBtn.width*0.5, 0, 0);
    }
    return _chBtn;
}

- (UIButton *)enBtn
{
    if (!_enBtn) {
        _enBtn = [UIButton z_frame:CGRectMake(self.chBtn.x, self.chBtn.bottom + SPH(15), self.chBtn.width, self.chBtn.height)
                      norImageName:@"icon_default"
                      selImageName:@"icon_highlight"
                            Target:self
                            action:@selector(enBtnClick:)
                             title:@"English"
                          selTitle:@"English"
                              font:[UIFont systemFontOfSize:SPFont(17)]
                     norTitleColor:[UIColor colorWithHex:@"#B5B5B5"]
                     selTitleColor:[UIColor colorWithHex:@"#121212"]
                           bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                      cornerRadius:8
                       borderWidth:1
                       borderColor:[UIColor colorWithHex:@"#26C464"]
                  ];
        
        _enBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        _enBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, _enBtn.width*0.5);
        _enBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _enBtn.width*0.5, 0, 0);
    }
    return _enBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(self.enBtn.x, self.enBtn.bottom + SPH(30), self.enBtn.width, SPH(52))
                            fontSize:SPFont(18)
                        cornerRadius:6
                     backgroundColor:[UIColor colorWithHex:@"#26C464"]
                          titleColor:[UIColor whiteColor]
                               title:NSLocalizedString(@"确定", nil)
                              isbold:YES
                              Target:self
                              action:@selector(sureBtnClick)
                    ];
    }
    return _sureBtn;
}

- (UILabel *)zhuLabel
{
    if (!_zhuLabel) {
        _zhuLabel = [UILabel z_frame:CGRectMake(self.sureBtn.x, self.sureBtn.bottom + SPH(20), self.sureBtn.width, SPH(20))
                                Text:NSLocalizedString(@"注", nil)
                            fontSize:SPFont(14)
                               color:[UIColor colorWithHex:@"#808080"]
                              isbold:NO
                     ];
    }
    return _zhuLabel;
}

@end
