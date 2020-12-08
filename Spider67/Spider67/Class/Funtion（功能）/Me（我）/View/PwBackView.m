//
//  PwBackView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PwBackView.h"
#import "LanguageController.h"
#import "ChangePwView.h"

@implementation PwBackView

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
    [self setPwView];
    [self setBackView];
}

- (void)setPwView
{
    UIView* pwV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height*0.5 - 0.25)];
    [self addSubview:pwV];
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [pwV addGestureRecognizer:tap];
    pwV.tag = 100;
    
    UIImageView* pwImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SPW(30), (pwV.height - 24)*0.5, 24, 24)];
    pwImgV.image = [SVGKImage imageNamed:@"icon_me_password"].UIImage;
    [pwV addSubview:pwImgV];
    
    UILabel* pwLb = [UILabel z_frame:CGRectMake(pwImgV.right + SPW(15), 0, 170, 24)
                                      Text:NSLocalizedString(@"修改密码", nil)
                                  fontSize:SPFont(17)
                                     color:[UIColor colorWithHex:@"#121212"]
                                    isbold:NO
                           ];
    pwLb.centerY = pwImgV.centerY;
    [pwLb sizeToFit];
    [pwV addSubview:pwLb];
    
    UIImageView* arImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - SPW(49), (pwV.height - 24)*0.5, 24, 24)];
    arImgV.image = [SVGKImage imageNamed:@"icon_arrow_more"].UIImage;
    [pwV addSubview:arImgV];
    
    UILabel* lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(pwImgV.x, pwV.bottom, self.width - 60, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [self addSubview:lineLabel];

    
}

- (void)setBackView
{
    UIView* backV = [[UIView alloc] initWithFrame:CGRectMake(0, self.height*0.5+0.25, self.width, self.height*0.5 - 0.25)];
    [self addSubview:backV];
    backV.tag = 101;
    // 添加手势
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
      [backV addGestureRecognizer:tap];
    
    UIImageView* backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SPW(30), (backV.height - 24)*0.5, 24, 24)];
    backImgV.image = [SVGKImage imageNamed:@"icon_me_logout"].UIImage;
    [backV addSubview:backImgV];
    
    UILabel* backLb = [UILabel z_frame:CGRectMake(backImgV.right + SPW(15), 0, 170, 24)
                                      Text:NSLocalizedString(@"退出登录", nil)
                                  fontSize:SPFont(17)
                                     color:[UIColor colorWithHex:@"#F1544F"]
                                    isbold:YES
                           ];
    backLb.centerY = backImgV.centerY;
    [backLb sizeToFit];
    [backV addSubview:backLb];
    
    UIImageView* arImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - SPW(49), (backV.height - 24)*0.5, 24, 24)];
    arImgV.image = [SVGKImage imageNamed:@"icon_arrow_more"].UIImage;
    [backV addSubview:arImgV];
}

-(void)tapView:(UITapGestureRecognizer *)sender{
    
    if (sender.view.tag == 100) {
        ChangePwView* alertV = [[ChangePwView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - SPW(32), SPH(505))];
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:UIApplication.sharedApplication.keyWindow.rootViewController.view];
        nkView.contentView = alertV;
        [nkView show];
    }else if (sender.view.tag == 101) {
        [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            BOOL oldState = [UIView areAnimationsEnabled];
            [UIView setAnimationsEnabled:NO];
            LanguageController *vc = [LanguageController new];
            UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            [UIView setAnimationsEnabled:oldState];
        } completion:nil];
    }
}

@end
