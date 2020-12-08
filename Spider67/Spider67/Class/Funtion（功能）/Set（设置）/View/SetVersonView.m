//
//  SetVersonView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SetVersonView.h"

@implementation SetVersonView

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
    self.layer.cornerRadius = 12;
    
    UILabel* currentTitleLb = [UILabel z_frame:CGRectMake(SPW(35), SPH(30), SPW(120), SPH(24)) Text:NSLocalizedString(@"当前版本", nil) fontSize:SPFont(17) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:currentTitleLb];
    
    UILabel* currentVersonNum = [UILabel z_labelWithText:@"v 1.3.4" fontSize:17 color:[UIColor colorWithHex:@"#26C464"] isbold:YES];
    currentVersonNum.width = SPW(100);
    currentVersonNum.height = SPH(24);
    currentVersonNum.x = self.width - SPW(35) - SPW(100);
    currentVersonNum.centerY = currentTitleLb.centerY;
    [self addSubview:currentVersonNum];
    currentVersonNum.textAlignment = NSTextAlignmentRight;
    
    UILabel* lineLb = [[UILabel alloc] initWithFrame:CGRectMake(SPW(30), currentVersonNum.bottom + SPH(20), self.width - SPW(30)*2, 1)];
    lineLb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [self addSubview:lineLb];
    
    UILabel* checkVersonTitleLb = [UILabel z_frame:CGRectMake(SPW(35),lineLb.bottom + SPH(20), SPW(200), SPH(24)) Text:NSLocalizedString(@"自动版本检测", nil) fontSize:SPFont(15) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:checkVersonTitleLb];
    
    UISwitch* sw = [[UISwitch alloc] init];
    sw.x = self.width - sw.width - SPW(35);
    sw.centerY = checkVersonTitleLb.centerY;
    [self addSubview:sw];
    
    UILabel* alertTitleLb = [UILabel z_frame:CGRectMake(SPW(35),checkVersonTitleLb.bottom + SPH(13), self.width - SPW(35)*2, SPH(40)) Text:NSLocalizedString(@"开启后App每次启动时自动检测新版本", nil) fontSize:SPFont(13) color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    alertTitleLb.numberOfLines = 0;
    [self addSubview:alertTitleLb];
    
    UIButton* checkVersonBtn = [UIButton z_frame:CGRectMake((self.width - SPW(155))*0.5, alertTitleLb.bottom + SPH(25), SPW(155), SPH(38))
                                    norImageName:nil
                                    selImageName:nil
                                          Target:self
                                          action:@selector(checkVersonBtnClick)
                                           title:NSLocalizedString(@"手动检测新版本", nil)
                                        selTitle:NSLocalizedString(@"手动检测新版本", nil)
                                            font:[UIFont systemFontOfSize:SPFont(17)]
                                   norTitleColor:[UIColor colorWithHex:@"#4D8CEB"]
                                   selTitleColor:nil
                                         bgColor:[UIColor colorWithHex:@"#4D8CEB" alpha:0.08]
                                    cornerRadius:4
                                     borderWidth:0.5
                                     borderColor:[UIColor colorWithHex:@"#4D8CEB"]
                                ];
    [self addSubview:checkVersonBtn];
    
}

- (void)checkVersonBtnClick
{
    [MBhud showText:NSLocalizedString(@"当前已是最新版本", nil) addView:zAppWindow];
}

@end
