//
//  LineTypeView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LineTypeView.h"

@interface LineTypeView ()

//@property (nonatomic, strong) UIButton* gBtn;
//@property (nonatomic, strong) UIButton* wifiBtn;
@property (nonatomic, strong) UIImageView* wifiImgV;
@property (nonatomic, strong) UIImageView* gImgV;

@end
@implementation LineTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setLineTypeStr:(NSString *)lineTypeStr
{
    _lineTypeStr = lineTypeStr;
    
    if ([lineTypeStr isEqualToString:@"4g"]) {
        [self one4g];
    }else if ([lineTypeStr isEqualToString:@"wifi"]) {
        [self onewifi];
    }else if ([lineTypeStr isEqualToString:@"4gwifi"]) {
        [self WifiAnd4g];
    }
    
}

- (void)one4g{
    
    UILabel* labelTitle = [UILabel z_frame:CGRectMake(0, 0, self.width, SPH(20)) Text:NSLocalizedString(@"指定的联网方式", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:labelTitle];
    
    UIButton* gBtn = [UIButton z_frame:CGRectMake(0, labelTitle.bottom + 5, self.width, SPH(65))
                          norImageName:nil
                          selImageName:nil
                                Target:nil
                                action:nil
                                 title:@"4G"
                              selTitle:nil
                                  font:[UIFont systemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#121212"]
                         selTitleColor:nil
                               bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                          cornerRadius:4
                           borderWidth:1
                           borderColor:[UIColor colorWithHex:@"#26C464"]
                      ];
    [self addSubview:gBtn];
    
    UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(gBtn.width - 18, 0, 18, 18)];
    imgV.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    [gBtn addSubview:imgV];
    
    UILabel* noteTitle = [UILabel z_frame:CGRectMake(0, gBtn.bottom + 8, self.width, SPH(20)) Text:NSLocalizedString(@"注：此设备支持的联网方式为4G", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:noteTitle];
    
    
}

- (void)onewifi{
    
    UILabel* labelTitle = [UILabel z_frame:CGRectMake(0, 0, self.width, SPH(20)) Text:NSLocalizedString(@"指定的联网方式", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:labelTitle];
    
    UIButton* wifiBtn = [UIButton z_frame:CGRectMake(0, labelTitle.bottom + 5, self.width, SPH(65))
                          norImageName:nil
                          selImageName:nil
                                Target:nil
                                action:nil
                                 title:@"Wi-Fi"
                              selTitle:nil
                                  font:[UIFont systemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#121212"]
                         selTitleColor:nil
                               bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                          cornerRadius:4
                           borderWidth:1
                           borderColor:[UIColor colorWithHex:@"#26C464"]
                      ];
    [self addSubview:wifiBtn];
    
    UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(wifiBtn.width - 18, 0, 18, 18)];
    imgV.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    [wifiBtn addSubview:imgV];
    
    UILabel* noteTitle = [UILabel z_frame:CGRectMake(0, wifiBtn.bottom + 8, self.width, SPH(20)) Text:NSLocalizedString(@"注：此设备支持的联网方式为Wi-Fi", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:noteTitle];
    
    
}

- (void)WifiAnd4g
{
    UILabel* labelTitle = [UILabel z_frame:CGRectMake(0, 0, self.width, SPH(20)) Text:NSLocalizedString(@"指定的联网方式", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:labelTitle];
    
    UIButton* gBtn = [UIButton z_frame:CGRectMake(0, labelTitle.bottom + 5, (self.width - 10)*0.5, SPH(65))
                          norImageName:nil
                          selImageName:nil
                                Target:self
                                action:@selector(gBtnClick:)
                                 title:@"4G"
                              selTitle:nil
                                  font:[UIFont systemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#121212"]
                         selTitleColor:nil
                               bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                          cornerRadius:4
                           borderWidth:1
                           borderColor:[UIColor colorWithHex:@"#26C464"]
                      ];
    [self addSubview:gBtn];
    _gBtn = gBtn;
    
    UIButton* wifiBtn = [UIButton z_frame:CGRectMake(gBtn.right + 10, labelTitle.bottom + 5, gBtn.width, SPH(65))
                             norImageName:nil
                             selImageName:nil
                                   Target:self
                                   action:@selector(wifiBtnClick:)
                                    title:@"Wi-Fi"
                                 selTitle:nil
                                     font:[UIFont systemFontOfSize:SPFont(17)]
                            norTitleColor:[UIColor colorWithHex:@"#121212"]
                            selTitleColor:nil
                                  bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                             cornerRadius:4
                              borderWidth:0.5
                              borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                         ];
    [self addSubview:wifiBtn];
    _wifiBtn = wifiBtn;
    
    UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(gBtn.width - 18, 0, 18, 18)];
    imgV.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    [gBtn addSubview:imgV];
    _gImgV = imgV;
    
    UIImageView* imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(wifiBtn.width - 18, 0, 18, 18)];
    imgV1.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    [wifiBtn addSubview:imgV1];
    _wifiImgV = imgV1;
    imgV1.hidden = YES;
    
    UILabel* noteTitle = [UILabel z_frame:CGRectMake(0, gBtn.bottom + 8, self.width, SPH(40)) Text:NSLocalizedString(@"注：此设备支持的联网方式为4G、Wi-Fi", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    noteTitle.numberOfLines = 0;
    [self addSubview:noteTitle];
}

- (void)gBtnClick:(UIButton *)btn
{
    _gImgV.hidden = NO;
    _gBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _gBtn.layer.borderWidth = 1;
    
    _wifiImgV.hidden = YES;
    _wifiBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _wifiBtn.layer.borderWidth = 0.5;
    
    if ([self.delegate respondsToSelector:@selector(changeNetAndWifiType:)]) {
        [self.delegate changeNetAndWifiType:@"4g"];
    }
}

- (void)wifiBtnClick:(UIButton *)btn
{
    
    _gImgV.hidden = YES;
    _gBtn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _gBtn.layer.borderWidth = 0.5;
    
    _wifiImgV.hidden = NO;
    _wifiBtn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _wifiBtn.layer.borderWidth = 1;
    
    if ([self.delegate respondsToSelector:@selector(changeNetAndWifiType:)]) {
        [self.delegate changeNetAndWifiType:@"wifi"];
    }
}

@end
