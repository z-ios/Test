//
//  HeaderView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UILabel* wgNameLb;
@property (nonatomic, strong) UILabel* xinhaoNumLb;
@property (nonatomic, strong) UIImageView* xinhaoImgV;

@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self addSubview:self.wgNameLb];
    [self addSubview:self.xinhaoImgV];
    [self addSubview:self.xinhaoNumLb];
    
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    
    _wgNameLb.text = deviceDict[@"devicename"];
    _xinhaoNumLb.text = [NSString stringWithFormat:@"%@",deviceDict[@"csq"]];
    if ([deviceDict[@"csq"] integerValue] < 6) {
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_0"].UIImage;
    }else if ([deviceDict[@"csq"] integerValue] < 11) {
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_1"].UIImage;
    }else if ([deviceDict[@"csq"] integerValue] < 16) {
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_2"].UIImage;
    }else if ([deviceDict[@"csq"] integerValue] < 21) {
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_3"].UIImage;
    }else if ([deviceDict[@"csq"] integerValue] < 26) {
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_4"].UIImage;
    }else{
        self.xinhaoImgV.image = [SVGKImage imageNamed:@"icon_signal_5"].UIImage;
    }
}

- (UILabel *)wgNameLb
{
    if (!_wgNameLb) {
        _wgNameLb = [UILabel z_frame:CGRectMake(20, self.height - 24, self.width*0.5, 24) Text:@"办公室测试设备" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    }
    
    return _wgNameLb;
}

- (UIImageView *)xinhaoImgV
{
    if (!_xinhaoImgV) {
        _xinhaoImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 24 - 20, 0, 24, 24)];
        _xinhaoImgV.centerY = self.wgNameLb.centerY;
    }
    return _xinhaoImgV;
}

- (UILabel *)xinhaoNumLb
{
    if (!_xinhaoNumLb) {
        _xinhaoNumLb = [UILabel z_frame:CGRectMake(self.xinhaoImgV.x - 30, 0, 20, 20) Text:@"23" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _xinhaoNumLb.centerY = _xinhaoImgV.centerY;
    }
    
    return _xinhaoNumLb;
}

@end
