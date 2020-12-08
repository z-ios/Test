//
//  DeviceCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceCell.h"
#import "DeviceModel.h"

@interface DeviceCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UIView* leftView;
@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel* badgeLabel;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* modeNameLabel;
@property (nonatomic, strong) UILabel* logNameLabel;

@property (nonatomic, strong) UIButton* xinhaoBtn;
@property (nonatomic, strong) UIButton* gengxinBtn;
@property (nonatomic, strong) UIButton* baojingBtn;

@end
@implementation DeviceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = SPH(211);
        self.width = zScreenWidth;
        [self setupUI];
    }
    
    return self;
}

- (void)setModel:(DeviceModel *)model
{
    _model = model;
    
    self.badgeLabel.text = [NSString stringWithFormat:@"%d",([model.modulecount intValue] - 2)];
    self.badgeLabel.width = _badgeLabel.text.length*4 + SPH(28) + 10;
    self.nameLabel.text = model.devicename;
    self.modeNameLabel.text = model.devicetype;
    
    CGSize sizeNews = [_modeNameLabel.text sizeWithAttributes:@{NSFontAttributeName:_modeNameLabel.font}];
       _modeNameLabel.width = sizeNews.width + 20;
    
    if ([model.imei isEqualToString:@""]) {
        self.logNameLabel.text = model.wifimac;
    }else{
        self.logNameLabel.text = model.imei;
    }
    CGSize sizeNew = [_logNameLabel.text sizeWithAttributes:@{NSFontAttributeName:_logNameLabel.font}];
    _logNameLabel.width = sizeNew.width + 20;
    // 是否在线
    if ([model.onlinestatus intValue] == 0) {
        [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_offline"].UIImage forState:UIControlStateNormal];
        [_xinhaoBtn setTitle:NSLocalizedString(@"离线", nil) forState:UIControlStateNormal];
        self.badgeLabel.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        self.badgeLabel.textColor = [UIColor colorWithHex:@"#B5B5B5"];
    }else{
        
        if ([model.csq integerValue] < 6) {
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_0"].UIImage forState:UIControlStateNormal];
        }else if ([model.csq integerValue] < 11) {
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_1"].UIImage forState:UIControlStateNormal];
        }else if ([model.csq integerValue] < 16) {
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_2"].UIImage forState:UIControlStateNormal];
        }else if ([model.csq integerValue] < 21) {
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_3"].UIImage forState:UIControlStateNormal];
        }else if ([model.csq integerValue] < 26) {
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_4"].UIImage forState:UIControlStateNormal];
        }else{
            [_xinhaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_5"].UIImage forState:UIControlStateNormal];
        }
        
        [_xinhaoBtn setTitle:[NSString stringWithFormat:@"%zd",[model.csq integerValue]] forState:UIControlStateNormal];
        self.badgeLabel.backgroundColor = [UIColor colorWithHex:@"#D3F1DF"];
        self.badgeLabel.textColor = [UIColor colorWithHex:@"#26C464"];
    }
    
    // 版本更新
    if ([model.havenewversion intValue] == 0) {
        [_gengxinBtn setImage:[SVGKImage imageNamed:@"icon_device_update"].UIImage forState:UIControlStateNormal];
    }else{
        [_gengxinBtn setImage:[SVGKImage imageNamed:@"icon_device_fota"].UIImage forState:UIControlStateNormal];
    }
    
    if ([model.modulecount intValue] == 0) {
        _imgV.image = [UIImage imageNamed:@"pic_device_alone"];
    }else{
        _imgV.image = [UIImage imageNamed:@"pic_device_withio"];
    }
    
    // 是否有报警
    if ([model.havealarm intValue] == 0) {
        [_baojingBtn setImage:[SVGKImage imageNamed:@"icon_device_alert_nor"].UIImage forState:UIControlStateNormal];
    }else{
        [_baojingBtn setImage:[SVGKImage imageNamed:@"icon_device_alert"].UIImage forState:UIControlStateNormal];
    }
    
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self addSubview:self.maskView];

    [self.maskView addSubview:self.leftView];
    [self.leftView addSubview:self.imgV];
    [self.leftView addSubview:self.badgeLabel];
    [self.maskView addSubview:self.nameLabel];
    [self.maskView addSubview:self.modeNameLabel];
    [self.maskView addSubview:self.logNameLabel];
    [self.maskView addSubview:self.xinhaoBtn];
    [self.maskView addSubview:self.gengxinBtn];
    [self.maskView addSubview:self.baojingBtn];
    self.xinhaoBtn.userInteractionEnabled = NO;
    self.gengxinBtn.userInteractionEnabled = NO;
    self.baojingBtn.userInteractionEnabled = NO;
    
    
}


#pragma lazy

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(16, 7.5, self.width - 32, self.height - 15)];
        _maskView.layer.cornerRadius = 16;
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.08].CGColor;
        _maskView.layer.shadowOffset = CGSizeMake(0,0);
        _maskView.layer.shadowRadius = 12.f;
    }
    
    return _maskView;
}

- (UIView *)leftView
{
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(SPW(20), (self.maskView.height - SPH(141))*0.5, SPW(92), SPH(141))];
        _leftView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _leftView.layer.cornerRadius = 14;
    }
    return _leftView;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.width = SPH(50);
        _imgV.height = SPH(65);
        _imgV.centerX = self.leftView.width*0.5;
        _imgV.centerY = self.leftView.height*0.5;
    }
    
    return _imgV;
}

- (UILabel *)badgeLabel
{
    if (!_badgeLabel) {
        _badgeLabel = [UILabel z_labelWithText:@"8" fontSize:SPFont(17) color:[UIColor colorWithHex:@"#26C464"] isbold:YES];
        _badgeLabel.height = SPH(28);
        _badgeLabel.width = _badgeLabel.text.length*4 + SPH(28) + 10;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.center = CGPointMake(5, 5);
        _badgeLabel.backgroundColor = [UIColor colorWithHex:@"#D3F1DF"];
        _badgeLabel.layer.cornerRadius = SPH(14);
        _badgeLabel.layer.masksToBounds = YES;
        
        _badgeLabel.centerX = self.leftView.width;
        _badgeLabel.centerY = 0;
        
    }
    
    return _badgeLabel;;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel z_frame:CGRectMake(self.leftView.right+ SPW(30), SPH(30), self.maskView.width - (self.leftView.right + SPW(30)) , SPH(25))
                                 Text:@"办公室测试设备"
                             fontSize:SPFont(18)
                                color:[UIColor colorWithHex:@"#121212"]
                               isbold:YES
                      ];

    }
    
    return _nameLabel;
    
    
}

- (UILabel *)modeNameLabel
{
    if (!_modeNameLabel) {
        _modeNameLabel = [UILabel z_frame:CGRectZero
                                     Text:@"SPMB_16DIO_003E"
                                 fontSize:SPFont(14)
                                    color:[UIColor colorWithHex:@"#26C464"]
                                   isbold:NO
                             cornerRadius:SPH(14)
                          backgroundColor:[UIColor colorWithHex:@"#EDF6F1"]
                      ];
        _modeNameLabel.frame = CGRectMake(self.nameLabel.x, self.nameLabel.bottom + SPH(10), _modeNameLabel.text.length*10, SPH(28));
        _modeNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _modeNameLabel;
}

- (UILabel *)logNameLabel
{
    if (!_logNameLabel) {
        _logNameLabel = [UILabel z_frame:CGRectZero
                                    Text:@"756493784317563836E"
                                fontSize:SPFont(14)
                                   color:[UIColor colorWithHex:@"#4D8CEB"]
                                  isbold:NO
                            cornerRadius:SPH(14)
                         backgroundColor:[UIColor colorWithHex:@"#F1F3F8"]
                         ];
        
        _logNameLabel.textAlignment = NSTextAlignmentCenter;
        // 根据文本计算size，这里需要传入attributes
        CGSize sizeNew = [_logNameLabel.text sizeWithAttributes:@{NSFontAttributeName:_logNameLabel.font}];
        // 重新设置frame
        _logNameLabel.frame = CGRectMake(self.nameLabel.x, self.modeNameLabel.bottom + SPH(5),sizeNew.width, SPH(28));
        
    }
    
    return _logNameLabel;
}

- (UIButton *)xinhaoBtn
{
    if (!_xinhaoBtn) {
        _xinhaoBtn = [UIButton z_svg_setImageName:@"icon_offline" fontSize:SPFont(12) titleColor:[UIColor colorWithHex:@"#808080"] title:@"离线" isbold:NO];
        _xinhaoBtn.frame = CGRectMake(self.logNameLabel.x, self.logNameLabel.bottom + SPH(26), SPW(60), 24);
    }
    
    return _xinhaoBtn;
}

- (UIButton *)gengxinBtn
{
    if (!_gengxinBtn) {
        _gengxinBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.xinhaoBtn.right, self.logNameLabel.bottom + SPH(26), SPW(60), 24)];
        [_gengxinBtn setImage:[SVGKImage imageNamed:@"icon_device_fota"].UIImage forState:UIControlStateNormal];
        
    }
    
    return _gengxinBtn;
}

- (UIButton *)baojingBtn
{
    if (!_baojingBtn) {
        _baojingBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.gengxinBtn.right, self.logNameLabel.bottom + SPH(26), SPW(60), 24)];
     [_baojingBtn setImage:[SVGKImage imageNamed:@"icon_device_alert_nor"].UIImage forState:UIControlStateNormal];
        
    }
    
    return _baojingBtn;
}



//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 16;
//    frame.origin.y += 15;
//    frame.size.height = SPH(196);
//    frame.size.width = zScreenWidth - 32;
//    [super setFrame:frame];
//}

@end
