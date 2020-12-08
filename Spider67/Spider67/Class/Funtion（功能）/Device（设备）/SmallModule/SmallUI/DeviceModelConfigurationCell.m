//
//  DeviceModelConfigurationCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceModelConfigurationCell.h"
#import "ModuleView.h"
#import "ModuleNumView.h"
#import "ModulesListModel.h"

@interface DeviceModelConfigurationCell ()

@property (nonatomic, strong) UIButton* xinHaoBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfoBtn;
@property (nonatomic, strong) UILabel* modTypeLb;
@property (nonatomic, strong) ModuleView* modView;
@property (nonatomic, strong) ModuleNumView* modNumView;

@end
@implementation DeviceModelConfigurationCell

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

}

- (void)setModel:(ModulesListModel *)model
{
    _model = model;
    _titleLb.text = _model.modulename;
    _modTypeLb.text = _model.moduletype;
    _modView.group_id = _deviceDict[@"group_id"];
    _modView.model = _model;
    _modNumView.model = _model;
    
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
    [self addSubview:self.modTypeLb];
    [self addSubview:self.modView];
    [self addSubview:self.modNumView];
}


#pragma mark - lazy

- (UIButton *)xinHaoBtn
{
    if (!_xinHaoBtn) {
        _xinHaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 24, 24)];
    }
    return _xinHaoBtn;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(self.xinHaoBtn.right + 6, 0, 160, 24) Text:@"module_0,module_1" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
        _titleLb.centerY = self.xinHaoBtn.centerY;
    }
    return _titleLb;
}

- (UILabel *)modTypeLb
{
    if (!_modTypeLb) {
        _modTypeLb = [UILabel z_frame:CGRectMake(self.titleLb.x, self.titleLb.bottom + 5, 126, 26) Text:@"867584032215324" fontSize:14 color:[UIColor colorWithHex:@"#F26E1D"] isbold:NO cornerRadius:13 backgroundColor:[UIColor colorWithHex:@"#F26E1D" alpha:0.1]];
        _modTypeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _modTypeLb;
}

- (ModuleView *)modView
{
    if (!_modView) {
        _modView = [[ModuleView alloc] initWithFrame:CGRectMake(32, self.modTypeLb.bottom + 20, SPH(110), SPH(472))];
    }
    return _modView;
}

- (ModuleNumView *)modNumView
{
    if (!_modNumView) {
        _modNumView = [[ModuleNumView alloc] initWithFrame:CGRectMake(self.modView.right + 17, 0, 154, 277)];
        _modNumView.centerY = self.modView.centerY;
    }
    return _modNumView;
}

@end
