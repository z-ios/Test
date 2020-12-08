//
//  VersionView.m
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "VersionView.h"

@implementation VersionView

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
    
    UIImageView* imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_new_version"]];
    imgV.frame = CGRectMake(0, -37, self.width, 169);
    [self addSubview:imgV];
    
    UILabel* newLb = [UILabel z_frame:CGRectMake(0, imgV.bottom + 30, self.width, 33)
                                 Text:NSLocalizedString(@"新版本", nil)
                             fontSize:24
                                color:[UIColor colorWithHex:@"#26C464"] isbold:YES
                      ];
    newLb.textAlignment = NSTextAlignmentCenter;
    newLb.centerX = self.width * 0.5;
    [self addSubview:newLb];
    
    UITextView* textV = [[UITextView alloc] initWithFrame:CGRectMake(20, newLb.bottom + 20, self.width - 40, 89)];
    textV.backgroundColor = [UIColor yellowColor];
    [self addSubview:textV];
    
     CGRect f = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? CGRectMake(20, textV.bottom + 32, 90, 24) : CGRectMake(20, textV.bottom + 32, 170, 24);
    UIButton* neverShowBtn = [UIButton z_setImageName:@"icon_back" selectedImageName:@"icon_back_selected" fontSize:14 titleColor:[UIColor colorWithHex:@"#808080"] title:[NSString stringWithFormat:@" %@",NSLocalizedString(@"不在提醒", nil)] isbold:NO];
    neverShowBtn.frame = f;
    [neverShowBtn addTarget:self action:@selector(neverShowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:neverShowBtn];
  
    UIButton *cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - 63, self.width*0.5+0.5, 64)
                       norImageName:nil
                       selImageName:nil
                             Target:self
                             action:@selector(cancelBtnClick)
                              title:NSLocalizedString(@"下次再说", nil)
                           selTitle:nil
                               font:[UIFont boldSystemFontOfSize:17]
                      norTitleColor:[UIColor colorWithHex:@"#808080"]
                      selTitleColor:nil
                            bgColor:nil
                       cornerRadius:0
                                borderWidth:0.5
                        borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                   ];
    
    [self addSubview:cancelBtn];
    
    UIButton* updateBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - 63, self.width*0.5+0.5, 64)
                            norImageName:nil
                            selImageName:nil
                                  Target:self
                                  action:@selector(updateBtnClick)
                                   title:NSLocalizedString(@"立即更新", nil)
                                selTitle:nil
                                    font:[UIFont boldSystemFontOfSize:17]
                           norTitleColor:[UIColor colorWithHex:@"#26C464"]
                           selTitleColor:nil
                                 bgColor:nil
                            cornerRadius:0
                              borderWidth:0.5
                             borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                        ];
    
    [self addSubview:updateBtn];
    
}

- (void)cancelBtnClick
{
//    NSLog(@"点击了");
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}
- (void)updateBtnClick
{
    NSLog(@"点击了");
}
- (void)neverShowBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

@end
