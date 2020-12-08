//
//  LanguageController.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LanguageController.h"
#import "LanguageView.h"
#import "LoginView.h"
#import "TuoJiMaskView.h"
#import "ServerSetController.h"

@interface LanguageController ()<DevicePtc>

@property (nonatomic, strong) LanguageView* langView;
@property (nonatomic, strong) UIImageView* spImgV;
@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) LoginView* logView;

@end

@implementation LanguageController

- (void)viewWillAppear:(BOOL)animated {

[super viewWillAppear:animated];

[self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated {

[super viewWillDisappear:animated];

[self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //获取系统语言
    [self setupUI];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"%@",UIApplication.sharedApplication.name);
//               });

    UIApplication.sharedApplication.zdelegate = self;
}

- (void)logAllSelect
{
    
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F8FB"];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;

    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SPH(269), self.view.width, self.view.height - SPH(269))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 34;
    [self.view addSubview:bgView];
    
//    [self showLogView:ddView];
    [self showLanguageView:bgView];
   
}


- (void)showLanguageView:(UIView *)bgView
{
    UIImageView* imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_login_lauguage"]];
    imgV.frame = CGRectMake(SPW(48), SPH(61), self.view.width - SPW(48)*2, SPH(192));
    [self.view addSubview:imgV];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    
    UIImageView* spImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_title"]];
    spImgV.frame = CGRectMake(SPW(36), 0, SPW(205), SPH(56));
    [self.view addSubview:spImgV];
    _spImgV = spImgV;
    _spImgV.alpha = 0;
    
    UIButton* serverBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 24 - 20, SPH(71), 24, 24)];
    [serverBtn setImage:[UIImage imageNamed:@"icon_server"] forState:UIControlStateNormal];
    [self.view addSubview:serverBtn];
    [serverBtn addTarget:self action:@selector(serverBtnClick) forControlEvents:UIControlEventTouchUpInside];
    serverBtn.hidden = YES;
    
    LanguageView* langView = [[LanguageView alloc] initWithFrame:bgView.bounds];
    [bgView addSubview:langView];
    _langView = langView;
    zWEAKSELF
    weakSelf.langView.setSuccessLanguage = ^(NSString * _Nonnull name) {
        
        if ([name isEqualToString:@"ch"]) {
            [DAConfig setUserLanguage:@"zh-Hans"];
        }else{
            [DAConfig setUserLanguage:@"en"];
        }
        weakSelf.logView = [[LoginView alloc] initWithFrame:bgView.bounds];
        weakSelf.logView.tuoJi = ^{
            
            TuoJiMaskView* maskView = [[TuoJiMaskView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            [zAppWindow addSubview:maskView];
            
        };
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            imgV.x = imgV.x - 50;
            langView.x = langView.x - 50;
            imgV.alpha = 0;
            langView.alpha = 0;
            
            bgView.frame = CGRectMake(0, SPH(142), self.view.width, self.view.height - SPH(142));
            weakSelf.spImgV.alpha = 1;
            spImgV.centerY = serverBtn.centerY;
            serverBtn.hidden = NO;
            [self showLogView:bgView];
            
        } completion:^(BOOL finished) {
            [imgV removeFromSuperview];
            [langView removeFromSuperview];
        }];
    };
}

- (void)showLogView:(UIView *)bgView
{

    _logView.frame = bgView.bounds;
    [bgView addSubview:_logView];
   

}

- (void)serverBtnClick
{
    ServerSetController* v = [[ServerSetController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}



@end
