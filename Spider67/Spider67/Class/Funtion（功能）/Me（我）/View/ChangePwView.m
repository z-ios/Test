//
//  ChangePwView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ChangePwView.h"

@interface ChangePwView ()

@property (nonatomic, strong) UITextField* yspwdTf;
@property (nonatomic, strong) UITextField* newpwdTf;
@property (nonatomic, strong) UITextField* suerpwdTf;

@end
@implementation ChangePwView

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
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(SPW(25), SPH(35), self.width - SPW(25)*2, SPH(33))
                                   Text:NSLocalizedString(@"修改密码", nil)
                               fontSize:SPFont(24)
                                  color:[UIColor colorWithHex:@"#121212"]
                                 isbold:NO
                        ];
    [self addSubview:titleLb];
    
    [self setyuanshipwd:titleLb];
    
    UIButton* sureBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
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
    
    [self addSubview:sureBtn];
    
    UIButton *cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
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
    
    
    [self addSubview:cancelBtn];
}

- (void)setyuanshipwd:(UILabel *)lb
{
    
    UILabel* yuanshiLb = [UILabel z_frame:CGRectMake(SPW(30),lb.bottom + SPH(25), self.width - SPW(25)*2, SPH(20))
                                     Text:NSLocalizedString(@"原始密码", nil)
                                 fontSize:SPFont(14)
                                    color:[UIColor colorWithHex:@"#808080"]
                                   isbold:NO
                          ];
    [self addSubview:yuanshiLb];
    
    UIView* yuanshipwdView = [[UIView alloc] initWithFrame:CGRectMake(yuanshiLb.x , yuanshiLb.bottom + 3, self.width - yuanshiLb.x*2, SPH(48))];
    yuanshipwdView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    yuanshipwdView.layer.cornerRadius = 4;
    yuanshipwdView.layer.borderWidth = 0.5;
    yuanshipwdView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    [self addSubview:yuanshipwdView];
    
//    UILabel *yserrorLb = [UILabel z_frame:CGRectMake(yuanshipwdView.x, yuanshipwdView.y - SPH(20), yuanshipwdView.width, SPH(20))
//                                     Text:NSLocalizedString(@"密码不能为空！", nil)
//                                 fontSize:SPFont(14)
//                                    color:[UIColor colorWithHex:@"#F22222"]
//                                   isbold:NO
//                          ];
//    yserrorLb.textAlignment = NSTextAlignmentRight;
//    [self addSubview:yserrorLb];
    
    
    UITextField* yspwdTf = [UITextField z_frame:CGRectMake(SPW(10) , 0, yuanshipwdView.width - SPW(54), yuanshipwdView.height)
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
    
    yspwdTf.clearButtonMode = UITextFieldViewModeAlways;
    [yuanshipwdView addSubview:yspwdTf];
    _yspwdTf = yspwdTf;
    
    
    UIButton* yseyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(yspwdTf.right + SPW(10), (yuanshipwdView.height - SPW(24)) * 0.5, SPW(24), SPW(24))];
    [yseyeBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
    [yseyeBtn setImage:[UIImage imageNamed:@"icon_eye_on"] forState:UIControlStateSelected];
    [yseyeBtn addTarget:self action:@selector(yseyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [yuanshipwdView addSubview:yseyeBtn];
    
    [self setnewpwd:yuanshipwdView];
    
    
}
- (void)setnewpwd:(UIView *)view
{
    UILabel* newLb = [UILabel z_frame:CGRectMake(view.x,view.bottom + SPH(45), self.width - SPW(25)*2, SPH(20))
                                 Text:NSLocalizedString(@"新密码", nil)
                             fontSize:SPFont(14)
                                color:[UIColor colorWithHex:@"#808080"]
                               isbold:NO
                      ];
    [self addSubview:newLb];
    
    UIView* newpwdView = [[UIView alloc] initWithFrame:CGRectMake(newLb.x , newLb.bottom + 3, self.width - newLb.x*2, SPH(48))];
    newpwdView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    newpwdView.layer.cornerRadius = 4;
    newpwdView.layer.borderWidth = 0.5;
    newpwdView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    [self addSubview:newpwdView];
    
//    UILabel *newerrorLb = [UILabel z_frame:CGRectMake(newpwdView.x, newpwdView.y - SPH(20), newpwdView.width, SPH(20))
//                                      Text:NSLocalizedString(@"密码不能为空！", nil)
//                                  fontSize:SPFont(14)
//                                     color:[UIColor colorWithHex:@"#F22222"]
//                                    isbold:NO
//                           ];
//    newerrorLb.textAlignment = NSTextAlignmentRight;
//    [self addSubview:newerrorLb];
    
    
    UITextField* newpwdTf = [UITextField z_frame:CGRectMake(SPW(10) , 0, newpwdView.width - SPW(54), newpwdView.height)
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
    
    newpwdTf.clearButtonMode = UITextFieldViewModeAlways;
    [newpwdView addSubview:newpwdTf];
    _newpwdTf = newpwdTf;
    
    
    UIButton* neweyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(newpwdTf.right + SPW(10), (newpwdView.height - SPW(24)) * 0.5, SPW(24), SPW(24))];
    [neweyeBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
    [neweyeBtn setImage:[UIImage imageNamed:@"icon_eye_on"] forState:UIControlStateSelected];
    [neweyeBtn addTarget:self action:@selector(neweyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [newpwdView addSubview:neweyeBtn];
    
    [self makesurepwd:newpwdView];
}
- (void)makesurepwd:(UIView *)view
{
    UILabel* sureLb = [UILabel z_frame:CGRectMake(view.x,view.bottom + SPH(20), self.width - SPW(25)*2, SPH(20))
                                  Text:NSLocalizedString(@"确认密码", nil)
                              fontSize:SPFont(14)
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    [self addSubview:sureLb];
    
    UIView* surepwdView = [[UIView alloc] initWithFrame:CGRectMake(sureLb.x , sureLb.bottom + 3, self.width - sureLb.x*2, SPH(48))];
    surepwdView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    surepwdView.layer.cornerRadius = 4;
    surepwdView.layer.borderWidth = 0.5;
    surepwdView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    [self addSubview:surepwdView];
    
//    UILabel *sureerrorLb = [UILabel z_frame:CGRectMake(surepwdView.x, surepwdView.y - SPH(20), surepwdView.width, SPH(20))
//                                       Text:NSLocalizedString(@"密码不能为空！", nil)
//                                   fontSize:SPFont(14)
//                                      color:[UIColor colorWithHex:@"#F22222"]
//                                     isbold:NO
//                            ];
//    sureerrorLb.textAlignment = NSTextAlignmentRight;
//    [self addSubview:sureerrorLb];
    
    
    UITextField* suerpwdTf = [UITextField z_frame:CGRectMake(SPW(10) , 0, surepwdView.width - SPW(54), surepwdView.height)
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
    
    suerpwdTf.clearButtonMode = UITextFieldViewModeAlways;
    [surepwdView addSubview:suerpwdTf];
    _suerpwdTf = suerpwdTf;
    
    UIButton* sureeyeBtn = [[UIButton alloc] initWithFrame:CGRectMake(suerpwdTf.right + SPW(10), (surepwdView.height - SPW(24)) * 0.5, SPW(24), SPW(24))];
    [sureeyeBtn setImage:[UIImage imageNamed:@"icon_eye_close"] forState:UIControlStateNormal];
    [sureeyeBtn setImage:[UIImage imageNamed:@"icon_eye_on"] forState:UIControlStateSelected];
    [sureeyeBtn addTarget:self action:@selector(sureeyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [surepwdView addSubview:sureeyeBtn];
    
    UILabel* noteLb = [UILabel z_frame:CGRectMake(surepwdView.x,surepwdView.bottom + SPH(10), self.width - SPW(25)*2, SPH(20))
                                 Text:NSLocalizedString(@"注：修改完成后需重新登录", nil)
                             fontSize:SPFont(14)
                                color:[UIColor colorWithHex:@"#808080"]
                               isbold:NO
                      ];
    [self addSubview:noteLb];
    
    
    
}

#pragma mark - btnClick

- (void)yseyeBtnClick:(UIButton *)btn
{
     if (btn.selected == YES) {
           self.yspwdTf.secureTextEntry = YES;
           btn.selected = NO;
       }else{
           self.yspwdTf.secureTextEntry = NO;
           btn.selected = YES;
       }
    
}
- (void)neweyeBtnClick:(UIButton *)btn
{
     if (btn.selected == YES) {
           self.newpwdTf.secureTextEntry = YES;
           btn.selected = NO;
       }else{
           self.newpwdTf.secureTextEntry = NO;
           btn.selected = YES;
       }
    
}
- (void)sureeyeBtnClick:(UIButton *)btn
{
     if (btn.selected == YES) {
           self.suerpwdTf.secureTextEntry = YES;
           btn.selected = NO;
       }else{
           self.suerpwdTf.secureTextEntry = NO;
           btn.selected = YES;
       }
    
}
- (void)sureClick
{
    
    if (_yspwdTf.text.length == 0) {
        [MBhud showText:NSLocalizedString(@"原始密码不能为空", nil) addView:zAppWindow];
        return;
    }
    if (_newpwdTf.text.length == 0) {
        [MBhud showText:NSLocalizedString(@"新密码不能为空", nil) addView:zAppWindow];
        return;
    }
    if (![_newpwdTf.text isEqualToString:_suerpwdTf.text]) {
        [MBhud showText:NSLocalizedString(@"两次输入的密码不一致", nil) addView:zAppWindow];
        return;
    }

    NSDictionary* dict = @{
        @"telephone": CenterManager.shared.telephone,
        @"oldpassword": _yspwdTf.text,
        @"newpassword": _newpwdTf.text
    };
    [CenterNet.shared ChangePasswordParam:dict completion:nil];
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];

}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];

}

@end
