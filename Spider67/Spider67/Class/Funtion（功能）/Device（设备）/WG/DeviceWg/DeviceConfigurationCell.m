//
//  DeviceConfigurationCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceConfigurationCell.h"
#import "WgView.h"
#import "WgEditorView.h"
#import "ModulesListModel.h"

@interface DeviceConfigurationCell ()

@property (nonatomic, strong) UIButton* xinHaoBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfoBtn;
@property (nonatomic, strong) UILabel* imeiLb;
@property (nonatomic, strong) WgView* wgView;
@property (nonatomic, strong) WgEditorView* wgEditorView;

@end
@implementation DeviceConfigurationCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 赋值

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    
    if ([deviceDict[@"csq"] integerValue] < 6) {
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_0"].UIImage forState:UIControlStateNormal];
    }else if ([deviceDict[@"csq"] integerValue] < 11) {
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_1"].UIImage forState:UIControlStateNormal];
    }else if ([deviceDict[@"csq"] integerValue] < 16) {
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_2"].UIImage forState:UIControlStateNormal];
    }else if ([deviceDict[@"csq"] integerValue] < 21) {
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_3"].UIImage forState:UIControlStateNormal];
    }else if ([deviceDict[@"csq"] integerValue] < 26) {
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_4"].UIImage forState:UIControlStateNormal];
    }else{
        [_xinHaoBtn setImage:[SVGKImage imageNamed:@"icon_signal_5"].UIImage forState:UIControlStateNormal];
    }
    
    _imeiLb.text = deviceDict[@"imei"];
    
    _wgView.deviceDict = _deviceDict;

}

- (void)setModel0:(ModulesListModel *)model0
{
    _model0 = model0;
    _wgView.channels0 = _model0.channels;
    _wgView.moduletypeStr0 = _model0.moduletype;
}

- (void)setModel1:(ModulesListModel *)model1
{
    _model1 = model1;
    _wgView.channels1 = _model1.channels;
    _wgView.moduletypeStr1 = _model1.moduletype;
    _titleLb.text = [NSString stringWithFormat:@"%@,%@",_model0.modulename,_model1.modulename];
}


#pragma mark - 点击进入详情
- (void)moreInfoBtnClick
{
    WgEditorView* wgEditorView = [[WgEditorView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    wgEditorView.model0 = _model0;
    wgEditorView.model1 = _model1;
    wgEditorView.deviceDict = _deviceDict;
    [zAppWindow addSubview:wgEditorView];
}

- (void)setupUI{
    
    self.backgroundColor=  [UIColor whiteColor];
    self.layer.cornerRadius = 24;
    self.clipsToBounds = NO;
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.08].CGColor;
    self.layer.shadowOpacity = 12;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    [self addSubview:self.xinHaoBtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.moreInfoBtn];
    [self addSubview:self.imeiLb];
    [self addSubview:self.wgView];
    
}

#pragma mark - lazy

- (UIButton *)xinHaoBtn
{
    if (!_xinHaoBtn) {
        _xinHaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, SPH(20), 24, SPH(24))];
    }
    return _xinHaoBtn;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(self.xinHaoBtn.right + 6, 0, 160, SPH(24)) Text:@"module_0,module_1" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
        _titleLb.centerY = self.xinHaoBtn.centerY;
    }
    return _titleLb;
}

- (UIButton *)moreInfoBtn
{
    if (!_moreInfoBtn) {
        _moreInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 20-24, SPH(20), 24, 24)];
        [_moreInfoBtn setImage:[SVGKImage imageNamed:@"icon_information_device"].UIImage forState:UIControlStateNormal];
        [_moreInfoBtn addTarget:self action:@selector(moreInfoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreInfoBtn;
}

- (UILabel *)imeiLb
{
    if (!_imeiLb) {
        _imeiLb = [UILabel z_frame:CGRectMake(self.titleLb.x, self.titleLb.bottom + 5, 152, 26) Text:@"867584032215324" fontSize:14 color:[UIColor colorWithHex:@"#1D68F2"] isbold:NO cornerRadius:13 backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]];
        _imeiLb.textAlignment = NSTextAlignmentCenter;
    }
    return _imeiLb;
}

- (WgView *)wgView
{
    if (!_wgView) {
        _wgView = [[WgView alloc] initWithFrame:CGRectMake((self.width - 200)*0.5, self.imeiLb.bottom + 20, SPH(220), SPH(478))];
    }
    return _wgView;
}

- (WgEditorView *)wgEditorView
{
    if (!_wgEditorView) {
        _wgEditorView = [[WgEditorView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    }
    return _wgEditorView;
}

@end
