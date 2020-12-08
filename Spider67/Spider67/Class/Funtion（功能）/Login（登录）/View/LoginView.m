//
//  LoginView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LoginView.h"
#import "VersionView.h"
#import "IWTabBarController.h"

@interface LoginView ()

@property (nonatomic, strong) UITextField* userTf;
@property (nonatomic, strong) UITextField* pwdTf;
@property (nonatomic, strong) UIButton* rememberBtn;
@property (nonatomic, strong) UIView* pwdView;
@property (nonatomic, strong) UILabel* errorLb;

@end
@implementation LoginView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self readValue];
        // 版本更新
//        [self upDateVersion];
        
    }
    return self;
}

- (void)upDateVersion{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   VersionView* v = [[VersionView alloc] initWithFrame:CGRectMake(0,0 , self.width - 32, 442)];
                    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:[UIApplication sharedApplication].keyWindow];
                    nkView.contentView = v;
                    [nkView show];
               });
 
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 34;

    UILabel*titleLb = [UILabel z_frame:CGRectMake(SPW(36), SPH(55), self.width - SPW(36)*2, SPH(24))
                                  Text:NSLocalizedString(@"欢迎登录", nil)
                              fontSize:SPFont(17)
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    [self addSubview:titleLb];
    
    // user
    UIView* userView = [[UIView alloc] initWithFrame:CGRectMake(titleLb.x, titleLb.bottom + SPH(25), self.width - titleLb.x * 2, SPH(56))];
    userView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    userView.layer.cornerRadius = 6;
    userView.layer.borderWidth = 0.5;
    userView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    [self addSubview:userView];
    
    UIImageView* userImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_phone"]];
    userImgV.frame = CGRectMake(SPW(15), (userView.height - SPW(24)) * 0.5, SPW(24), SPW(24));
    [userView addSubview:userImgV];
    
    UILabel* userLine = [[UILabel alloc] initWithFrame:CGRectMake(userImgV.right + SPW(15), (userView.height - SPH(25)) * 0.5, 1, SPH(25))];
    userLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [userView addSubview:userLine];
    
    UITextField* userTf = [UITextField z_frame:CGRectMake(userLine.right + SPW(10) , 0, userView.width - userLine.right - SPH(20), userView.height)
                                       bgColor:nil
                                  cornerRadius:0
                                   borderWidth:0
                                   borderColor:0
                                          text:nil
                                      textFont:[UIFont systemFontOfSize:SPH(17)]
                                     textColor:[UIColor colorWithHex:@"#121212"]
                                   placeholder:NSLocalizedString(@"请输入手机号", nil)
                               placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                              placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                   leftImgName:nil
                                   leftImgSize:CGSizeZero
                                  rightImgName:nil
                                  rightImgSize:CGSizeZero
                           ];
    
    
    userTf.clearButtonMode = UITextFieldViewModeAlways;
    
    [userView addSubview:userTf];
    _userTf = userTf;
    
    // pwd
    UIView* pwdView = [[UIView alloc] initWithFrame:CGRectMake(userView.x, userView.bottom + SPH(25), userView.width, userView.height)];
     pwdView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
     pwdView.layer.cornerRadius = 6;
     pwdView.layer.borderWidth = 0.5;
     pwdView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
     [self addSubview:pwdView];
    _pwdView = pwdView;
     
     UIImageView* pwdImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_login_password"]];
     pwdImgV.frame = CGRectMake(SPW(15), (pwdView.height - SPW(24)) * 0.5, SPW(24), SPW(24));
     [pwdView addSubview:pwdImgV];

     UILabel* pwdLine = [[UILabel alloc] initWithFrame:CGRectMake(pwdImgV.right + SPW(15), (pwdView.height - SPH(25)) * 0.5, 1, SPH(25))];
     pwdLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
     [pwdView addSubview:pwdLine];
//
    UITextField* pwdTf = [UITextField z_frame:CGRectMake(pwdLine.right + SPW(10) , 0, pwdView.width - pwdLine.right - SPW(54), pwdView.height)
                                         bgColor:nil
                                    cornerRadius:0
                                     borderWidth:0
                                     borderColor:0
                                            text:nil
                                        textFont:[UIFont systemFontOfSize:SPH(17)]
                                       textColor:[UIColor colorWithHex:@"#121212"]
                                     placeholder:NSLocalizedString(@"请输入密码", nil)
                                 placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                     leftImgName:nil
                                     leftImgSize:CGSizeZero
                                    rightImgName:nil
                                    rightImgSize:CGSizeZero
                             ];
 
     pwdTf.clearButtonMode = UITextFieldViewModeAlways;
     [pwdView addSubview:pwdTf];
    pwdTf.secureTextEntry = YES;
    _pwdTf = pwdTf;
    
    UIButton* eyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(pwdTf.right + SPW(10), (pwdView.height - SPW(24)) * 0.5, SPW(24), SPW(24))];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"icon_eye_on"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [pwdView addSubview:eyeBtn];
    
    // 记住密码
    
    CGRect f = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? CGRectMake(pwdView.x + SPW(10), pwdView.bottom + SPH(13), SPW(90), SPH(24)) : CGRectMake(pwdView.x + SPW(10), pwdView.bottom + SPH(13), SPW(170), SPH(24));
    
    UIButton* rememberBtn = [UIButton z_frame:f
                                 norImageName:@"icon_checkbox_default"
                                 selImageName:@"icon_checkbox_highlight"
                                       Target:self
                                       action:@selector(rememberBtnClick:)
                                        title:[NSString stringWithFormat:@" %@",NSLocalizedString(@"记住密码", nil)]
                                     selTitle:nil
                                         font:[UIFont systemFontOfSize:SPFont(14)]
                                norTitleColor:[UIColor colorWithHex:@"#808080"]
                                selTitleColor:nil
                                      bgColor:nil
                                 cornerRadius:0
                                  borderWidth:0
                                  borderColor:nil
                             ];
    [self addSubview:rememberBtn];
    rememberBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _rememberBtn = rememberBtn;

    
    // 登录
    UIButton* loginBtn = [UIButton z_frame:CGRectMake(pwdView.x, pwdView.bottom + SPH(117), pwdView.width, SPH(52))
                                  fontSize:SPFont(18)
                              cornerRadius:6
                           backgroundColor:[UIColor colorWithHex:@"#26C464"]
                                titleColor:[UIColor whiteColor]
                                     title:NSLocalizedString(@"登录", nil)
                                    isbold:YES
                                    Target:self
                                    action:@selector(loginBtnClick)
                          ];
    [self addSubview:loginBtn];
    
    
    // 脱机应用
    UIButton* tuojiBtn = [UIButton z_frame:CGRectMake((self.width - SPW(116))*0.5, loginBtn.bottom + SPH(186), SPW(116), SPH(34))
                                 norImageName:@"icon_offline_ap"
                                 selImageName:nil
                                       Target:self
                                       action:@selector(tuojiBtnClick)
                                        title:[NSString stringWithFormat:@" %@",NSLocalizedString(@"脱机应用", nil)]
                                     selTitle:nil
                                         font:[UIFont systemFontOfSize:SPFont(14)]
                                norTitleColor:[UIColor colorWithHex:@"#808080"]
                                selTitleColor:nil
                                      bgColor:nil
                                 cornerRadius:SPFont(17)
                               borderWidth:0.5
                               borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                             ];
    [self addSubview:tuojiBtn];
    
    
    _userTf.text = @"15000000000";
    _pwdTf.text = @"15000000000!@#";


}

- (void)eyeBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    _pwdTf.secureTextEntry = ! _pwdTf.secureTextEntry;
    
    _pwdView.layer.borderColor = [UIColor colorWithHex:@"#F82727"].CGColor;
    
    [self addSubview:self.errorLb];
    
}

- (void)rememberBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    [self rememberPwd:btn];
}

#pragma mark - 登录
- (void)loginBtnClick
{
    if (_userTf.text.length == 0) {
        [MBhud showText:@"请输入用户名" addView:zAppWindow];
        return;
    }
    if (_pwdTf.text.length == 0) {
        [MBhud showText:@"请输入密码" addView:zAppWindow];
        return;
    }
    
    //    NSDictionary* dict = @{
    //          @"telephone":@"18302275621",
    //          @"password":@"222"
    //      };
    //
    NSDictionary* dict = @{
        @"telephone":_userTf.text,
        @"password":_pwdTf.text
    };
    [CenterNet.shared netToLoginParam:dict completion:^(BOOL success) {
        if (success) {
            [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                BOOL oldState = [UIView areAnimationsEnabled];
                [UIView setAnimationsEnabled:NO];
                [UIApplication sharedApplication].keyWindow.rootViewController = [IWTabBarController new];
                [UIView setAnimationsEnabled:oldState];
            } completion:nil];
        }
    }];
    
}
- (void)tuojiBtnClick
{
    if (self.tuoJi) {
        self.tuoJi();
    }
}

- (void)rememberPwd:(UIButton *)btn
{
    if (btn.selected)
    {
        [[NSUserDefaults standardUserDefaults] setObject:self.pwdTf.text forKey:@"sp_pw"];
        [[NSUserDefaults standardUserDefaults] setObject:self.userTf.text forKey:@"sp_username"];
        
    }else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sp_pw"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sp_username"];
    }
}

#pragma mark - 读取是否记录密码
- (void)readValue{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sp_username"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"sp_pw"]) {
        self.rememberBtn.selected = YES;
        self.userTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"sp_username"];
        self.pwdTf.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"sp_pw"];
    }
    
}

#pragma mark - 懒加载
- (UILabel *)errorLb
{
    if (!_errorLb) {
        _errorLb = [UILabel z_frame:CGRectMake(self.pwdView.x, self.pwdView.y - SPH(20), self.pwdView.width, SPH(20))
                               Text:NSLocalizedString(@"密码不能为空！", nil)
                           fontSize:SPFont(14)
                              color:[UIColor colorWithHex:@"#F22222"]
                             isbold:NO
                    ];
        _errorLb.textAlignment = NSTextAlignmentRight;
    }
    return _errorLb;
}

@end
