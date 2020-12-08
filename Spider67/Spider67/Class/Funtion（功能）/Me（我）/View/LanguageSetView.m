//
//  LanguageSetView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LanguageSetView.h"
#import "LanguageAlertView.h"

@implementation LanguageSetView

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
    
    UIImageView* languageImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SPW(30), (self.height - 24)*0.5, 24, 24)];
      languageImgV.image = [SVGKImage imageNamed:@"icon_me_laugage"].UIImage;
      [self addSubview:languageImgV];
      
      UILabel* languageLb = [UILabel z_frame:CGRectMake(languageImgV.right + SPW(15), 0, 170, 24)
                                     Text:NSLocalizedString(@"语言设置", nil)
                                 fontSize:SPFont(17)
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
      languageLb.centerY = languageImgV.centerY;
      [languageLb sizeToFit];
      [self addSubview:languageLb];
    
    UIImageView* arImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - SPW(49), (self.height - 24)*0.5, 24, 24)];
         arImgV.image = [SVGKImage imageNamed:@"icon_arrow_more"].UIImage;
         [self addSubview:arImgV];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [self addGestureRecognizer:tap];
}

#pragma mark --- UITapGestureRecognizer 轻拍手势事件 ---

-(void)tapView:(UITapGestureRecognizer *)sender{
    
    LanguageAlertView* alertV = [[LanguageAlertView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - SPW(32), SPH(365))];
    //       addV.delegate = self;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:UIApplication.sharedApplication.keyWindow];
    nkView.contentView = alertV;
    [nkView show];
}

@end
