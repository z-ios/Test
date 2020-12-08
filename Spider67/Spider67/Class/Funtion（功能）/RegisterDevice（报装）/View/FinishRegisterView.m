//
//  FinishRegisterView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FinishRegisterView.h"

@interface FinishRegisterView ()

@property (nonatomic, strong) UIImageView* moduleImgV;
@property (nonatomic, strong) UIView* groupView;
@property (nonatomic, strong) UIImageView* groupImgV;
@property (nonatomic, strong) UILabel* groupTitleLb;
@property (nonatomic, strong) UIView* iotHubView;
@property (nonatomic, strong) UIImageView* iotHubImgV;
@property (nonatomic, strong) UILabel* iotHubTitleLb;
@property (nonatomic, strong) UILabel* xinghaoTitleLb;
@property (nonatomic, strong) UILabel* thingIdTitleLb;
@property (nonatomic, strong) UILabel* regIdTitleLb;

@end
@implementation FinishRegisterView

 - (instancetype)initWithFrame:(CGRect)frame
 {
     self = [super initWithFrame:frame];
     if (self) {
       
         [self setupUI];
     }
     return self;
 }

 - (void)setupUI
 {
     self.layer.cornerRadius = 19;
     self.layer.borderWidth = 0.5;
     self.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
     
     [self addSubview:self.moduleImgV];
     [self addSubview:self.nameLb];
     [self addSubview:self.biaoshimaLb];
     [self addSubview:self.groupView];
     [self.groupView addSubview:self.groupImgV];
     [self.groupView addSubview:self.groupTitleLb];
     [self.groupView addSubview:self.groupLb];
     [self addSubview:self.iotHubView];
     [self.iotHubView addSubview:self.iotHubImgV];
     [self.iotHubView addSubview:self.iotHubTitleLb];
     [self.iotHubView addSubview:self.iotHubName];
     [self.iotHubView addSubview:self.iotHubIp];
     [self addSubview:self.xinghaoTitleLb];
     [self addSubview:self.xinghaoLb];
     [self addSubview:self.thingIdTitleLb];
     [self addSubview:self.thingIdLb];
     [self addSubview:self.regIdTitleLb];
     [self addSubview:self.regIdLb];
     
     
 }

- (UIImageView *)moduleImgV
{
    if (!_moduleImgV) {
        _moduleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 92, 250)];
        _moduleImgV.image = [SVGKImage imageNamed:@"module_color"].UIImage;
    }
    return _moduleImgV;
}

- (UILabel *)nameLb
{
    if (!_nameLb) {
        _nameLb = [UILabel z_frame:CGRectMake(self.moduleImgV.right + 18, self.moduleImgV.y, self.width - 40 - self.moduleImgV.width, 28) Text:@"Iot软件测试设备1" fontSize:20 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    }
    
    return _nameLb;
}

- (UILabel *)biaoshimaLb
{
    if (!_biaoshimaLb) {
           _biaoshimaLb = [UILabel z_frame:CGRectMake(self.moduleImgV.right + 18, self.nameLb.bottom + 2, self.width - 40 - self.moduleImgV.width, 20) Text:@"864234342234" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
       }
       
       return _biaoshimaLb;
}

- (UIView *)groupView
{
    if (!_groupView) {
        _groupView = [[UIView alloc] initWithFrame:CGRectMake(self.moduleImgV.right + 18, self.biaoshimaLb.bottom + 15,self.width - 60 - self.moduleImgV.width, 75)];
        _groupView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _groupView.layer.cornerRadius = 12;
    }
    return _groupView;
}

- (UIImageView *)groupImgV
{
    if (!_groupImgV) {
        _groupImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 24, 24)];
        _groupImgV.image = [SVGKImage imageNamed:@"icon_character"].UIImage;
    }
    return _groupImgV;
}

- (UILabel *)groupTitleLb
{
    if (!_groupTitleLb) {
        _groupTitleLb = [UILabel z_frame:CGRectMake(self.groupImgV.right + 10, 0, 60, 20) Text:NSLocalizedString(@"所属群组", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _groupTitleLb.centerY = self.groupImgV.centerY;
    }
    
    return _groupTitleLb;
}

- (UILabel *)groupLb
{
    if (!_groupLb) {
        _groupLb = [UILabel z_frame:CGRectMake(self.groupTitleLb.x, self.groupTitleLb.bottom + 3, self.groupView.width - self.groupTitleLb.x, 20) Text:@"IoT软件部" fontSize:14 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _groupLb;
}

- (UIView *)iotHubView
{
    if (!_iotHubView) {
        _iotHubView = [[UIView alloc] initWithFrame:CGRectMake(self.moduleImgV.right + 18, self.groupView.bottom + 10,self.width - 60 - self.moduleImgV.width, 103)];
        _iotHubView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _iotHubView.layer.cornerRadius = 12;
    }
    return _iotHubView;
}

- (UIImageView *)iotHubImgV
{
    if (!_iotHubImgV) {
        _iotHubImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 24, 24)];
        _iotHubImgV.image = [SVGKImage imageNamed:@"icon_label"].UIImage;
    }
    return _iotHubImgV;
}

- (UILabel *)iotHubTitleLb
{
    if (!_iotHubTitleLb) {
        CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 105 : 140;
        _iotHubTitleLb = [UILabel z_frame:CGRectMake(self.iotHubImgV.right + 10, 0, w, 20) Text:NSLocalizedString(@"IoTHub实例", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _iotHubTitleLb.centerY = self.groupImgV.centerY;
    }
    
    return _iotHubTitleLb;
}

- (UILabel *)iotHubName
{
    if (!_iotHubName) {
        _iotHubName = [UILabel z_frame:CGRectMake(self.iotHubTitleLb.x, self.iotHubTitleLb.bottom + 3, self.iotHubView.width - self.iotHubTitleLb.x, 20) Text:@"IoT软件部" fontSize:14 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _iotHubName;
}

- (UILabel *)iotHubIp
{
    if (!_iotHubIp) {
        _iotHubIp = [UILabel z_frame:CGRectMake(self.iotHubTitleLb.x, self.iotHubName.bottom + 5, self.iotHubView.width - self.iotHubTitleLb.x, 20) Text:@"39.23.123.31" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    
    return _iotHubIp;
}

- (UILabel *)xinghaoTitleLb
{
    if (!_xinghaoTitleLb) {
        CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 85 : 120;
        _xinghaoTitleLb = [UILabel z_frame:CGRectMake(self.moduleImgV.x, self.moduleImgV.bottom + 20, w, 28) Text:NSLocalizedString(@"设备型号", nil) fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _xinghaoTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _xinghaoTitleLb;
}

- (UILabel *)xinghaoLb
{
    if (!_xinghaoLb) {
        _xinghaoLb = [UILabel z_frame:CGRectMake(self.xinghaoTitleLb.x, self.xinghaoTitleLb.bottom + 8, self.width - self.iotHubTitleLb.x*2, 24) Text:@"SPMB_16DIO_003E" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _xinghaoLb;
}

- (UILabel *)thingIdTitleLb
{
    if (!_thingIdTitleLb) {
        _thingIdTitleLb = [UILabel z_frame:CGRectMake(self.moduleImgV.x, self.xinghaoLb.bottom + 15, 81, 28) Text:@"thing ID" fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _thingIdTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _thingIdTitleLb;
}

- (UILabel *)thingIdLb
{
    if (!_thingIdLb) {
        _thingIdLb = [UILabel z_frame:CGRectMake(self.thingIdTitleLb.x, self.thingIdTitleLb.bottom + 8, self.width - self.thingIdTitleLb.x*2, 24) Text:@"2342376578658768" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _thingIdLb;
}

- (UILabel *)regIdTitleLb
{
    if (!_regIdTitleLb) {
        CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 71 : 130;
        _regIdTitleLb = [UILabel z_frame:CGRectMake(self.moduleImgV.x, self.thingIdLb.bottom + 15, w, 28) Text:NSLocalizedString(@"注册ID", nil) fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _regIdTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _regIdTitleLb;
}

- (UILabel *)regIdLb
{
    if (!_regIdLb) {
        _regIdLb = [UILabel z_frame:CGRectMake(self.regIdTitleLb.x, self.regIdTitleLb.bottom + 8, self.width - self.regIdTitleLb.x*2, 24) Text:@"--" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _regIdLb;
}


@end
