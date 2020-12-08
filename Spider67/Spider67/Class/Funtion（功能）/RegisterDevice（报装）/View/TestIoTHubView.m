//
//  TestIoTHubView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TestIoTHubView.h"

@interface TestIoTHubView ()

@property (nonatomic, strong) UILabel* biaoshiTitleLb;
@property (nonatomic, strong) UILabel* xinghaoTitleLb;
@property (nonatomic, strong) UILabel* iothubTitleLb;
@property (nonatomic, strong) UILabel* thingidTitleLb;

@end
@implementation TestIoTHubView

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
    
    [self addSubview:self.biaoshiTitleLb];
    [self addSubview:self.biaoshiLb];
    [self addSubview:self.xinghaoTitleLb];
    [self addSubview:self.xinghaoLb];
    [self addSubview:self.iothubTitleLb];
    [self addSubview:self.iothubLb];
    [self addSubview:self.iothubsubLb];
    [self addSubview:self.thingidTitleLb];
    [self addSubview:self.thingidLb];
    
}

- (UILabel *)biaoshiTitleLb
{
    if (!_biaoshiTitleLb) {
        CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 99 : 200;
        _biaoshiTitleLb = [UILabel z_frame:CGRectMake(SPW(30), SPH(30), w, 28) Text:NSLocalizedString(@"设备标识码", nil) fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _biaoshiTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _biaoshiTitleLb;
    
}

- (UILabel *)biaoshiLb
{
    if (!_biaoshiLb) {
        _biaoshiLb = [UILabel z_frame:CGRectMake(self.biaoshiTitleLb.x, self.biaoshiTitleLb.bottom + SPH(8), self.width - self.biaoshiTitleLb.x * 2, 24) Text:@"867584032215324" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _biaoshiLb;
}

- (UILabel *)xinghaoTitleLb
{
    if (!_xinghaoTitleLb) {
        _xinghaoTitleLb = [UILabel z_frame:CGRectMake(SPW(30),self.biaoshiLb.bottom + SPH(15), 57, 28) Text:NSLocalizedString(@"型号", nil) fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _xinghaoTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _xinghaoTitleLb;
}

- (UILabel *)xinghaoLb
{
    if (!_xinghaoLb) {
        _xinghaoLb = [UILabel z_frame:CGRectMake(self.xinghaoTitleLb.x, self.xinghaoTitleLb.bottom + SPH(8), self.width - self.biaoshiTitleLb.x * 2, 24) Text:@"SPMB_16DIO_003E" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _xinghaoLb;
}

- (UILabel *)iothubTitleLb
{
    if (!_iothubTitleLb) {
        CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 105 : 140;
        _iothubTitleLb = [UILabel z_frame:CGRectMake(SPW(30),self.xinghaoLb.bottom + SPH(15), w, 28) Text:NSLocalizedString(@"IoTHub实例", nil) fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _iothubTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _iothubTitleLb;
}

- (UILabel *)iothubLb
{
    if (!_iothubLb) {
        _iothubLb = [UILabel z_frame:CGRectMake(self.iothubTitleLb.x, self.iothubTitleLb.bottom + SPH(8), self.width - self.iothubTitleLb.x * 2, 24) Text:@"阿姆斯特丹测试-1" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _iothubLb;
}

- (UILabel *)iothubsubLb
{
    if (!_iothubsubLb) {
        _iothubsubLb = [UILabel z_frame:CGRectMake(self.iothubLb.x, self.iothubLb.bottom + SPH(5), self.width - self.iothubLb.x * 2, 24) Text:@"39.23.123.31" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _iothubsubLb;
}

- (UILabel *)thingidTitleLb
{
    if (!_thingidTitleLb) {
        _thingidTitleLb = [UILabel z_frame:CGRectMake(SPW(30),self.iothubsubLb.bottom + SPH(15), 81, 28) Text:@"thing ID" fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]];
        _thingidTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _thingidTitleLb;
}

- (UILabel *)thingidLb
{
    if (!_thingidLb) {
        _thingidLb = [UILabel z_frame:CGRectMake(self.thingidTitleLb.x, self.thingidTitleLb.bottom + SPH(8), self.width - self.thingidTitleLb.x * 2, 24) Text:@"--" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _thingidLb;
}



@end
