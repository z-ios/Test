//
//  BleLineCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BleLineCell.h"
#import "BleModel.h"

@interface BleLineCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UILabel* bleNameLb;
@property (nonatomic, strong) UIImageView* stateImageView;
@property (nonatomic, strong) UILabel* stateLb;
@property (nonatomic, strong) UILabel* uuidTitleLb;
@property (nonatomic, strong) UILabel* uuidLb;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;

@end
@implementation BleLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = SPH(143);
        self.width = zScreenWidth - 24;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(BleModel *)model
{
    _model = model;
    _bleNameLb.text = SafeString(model.name);
    _uuidLb.text = SafeString(model.identifierString);
    if ([model.lineState isEqualToString:NSLocalizedString(@"连接中...", nil)]) {
        _stateLb.text = SafeString(model.lineState);
        [self connectingState];
    } else if ([model.lineState isEqualToString:NSLocalizedString(@"未连接", nil)]) {
        _stateLb.text = SafeString(model.lineState);
        [self disConnectState];
    }else{
        _stateLb.text = SafeString(model.lineState);
        [self connectState];
    }
    
    [_bleNameLb sizeToFit];
    [_uuidLb sizeToFit];
    _stateLb.width = 0;
    [_stateLb sizeToFit];
    _stateLb.x = self.width - _stateLb.width - 20;
    _activityIndicator.x = _stateLb.x - 6 - 20;

    
}


- (void)connectState
{
    _maskView.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    _bleNameLb.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    _stateImageView.image = [SVGKImage imageNamed:@"icon_register_device_bluetooth_online"].UIImage;
    _uuidTitleLb.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    _uuidTitleLb.textColor = [UIColor colorWithHex:@"#26C464"];
    _uuidLb.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    _stateLb.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    self.activityIndicator.hidden = YES;
}

- (void)disConnectState
{
    _maskView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    _bleNameLb.textColor = [UIColor colorWithHex:@"#121212"];
    _stateImageView.image = [SVGKImage imageNamed:@"icon_register_device_bluetooth_offilie"].UIImage;
    _uuidTitleLb.backgroundColor = [UIColor colorWithHex:@"#F26E1D" alpha:0.1];
    _uuidTitleLb.textColor = [UIColor colorWithHex:@"#F26E1D"];
    _uuidLb.textColor = [UIColor colorWithHex:@"#747474"];
    _stateLb.textColor = [UIColor colorWithHex:@"#808080"];
    self.activityIndicator.hidden = YES;
}

- (void)connectingState
{
    _maskView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    _bleNameLb.textColor = [UIColor colorWithHex:@"#121212"];
    _stateImageView.image = [SVGKImage imageNamed:@"icon_register_device_bluetooth_offilie"].UIImage;
    _uuidTitleLb.backgroundColor = [UIColor colorWithHex:@"#F26E1D" alpha:0.1];
    _uuidTitleLb.textColor = [UIColor colorWithHex:@"#F26E1D"];
    _uuidLb.textColor = [UIColor colorWithHex:@"#747474"];
    _stateLb.textColor = [UIColor colorWithHex:@"#26C464"];
    self.activityIndicator.hidden = NO;
    
}

- (void)setupUI{
    
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.maskView];
    [self.maskView addSubview:self.bleNameLb];
    [self.maskView addSubview:self.stateImageView];
    [self.maskView addSubview:self.stateLb];
    [self.maskView addSubview:self.uuidTitleLb];
    [self.maskView addSubview:self.uuidLb];
    [self.maskView addSubview:self.activityIndicator];
    
}


#pragma mark - lazy

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(4, 7.5 , self.width - 8, self.height - 15)];
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.1].CGColor;
        _maskView.layer.shadowOffset = CGSizeMake(0, 0);
        _maskView.layer.shadowOpacity = 1.0f;
        _maskView.layer.cornerRadius = 16.0f;
    }
    return _maskView;
}

- (UILabel *)bleNameLb
{
    if (!_bleNameLb) {
        _bleNameLb = [UILabel z_frame:CGRectMake(SPW(20), SPH(20), SPW(100), SPH(24)) Text:@"ELCO_uart" fontSize:SPFont(17) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _bleNameLb;
}

- (UIImageView *)stateImageView
{
    if (!_stateImageView) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bleNameLb.right, 0, 28, 28)];
        _stateImageView.centerY = self.bleNameLb.centerY;
        _stateImageView.image = [SVGKImage imageNamed:@"icon_register_device_bluetooth_offilie"].UIImage;
    }
    return _stateImageView;
}

- (UILabel *)stateLb
{
    if (!_stateLb) {
        _stateLb = [UILabel z_frame:CGRectZero Text:@"未连接" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
//        _stateLb.width = self.width - self.stateImageView.right - 20;
        _stateLb.height = 20;
        _stateLb.centerY = self.stateImageView.centerY;
        _stateLb.textAlignment = NSTextAlignmentRight;
       
    }
    return _stateLb;
}

- (UILabel *)uuidTitleLb
{
    if (!_uuidTitleLb) {
        _uuidTitleLb = [UILabel z_frame:CGRectMake(_bleNameLb.x, _bleNameLb.bottom + SPH(15), 63, 24) Text:@"UUID" fontSize:14 color:[UIColor colorWithHex:@"#F26E1D"] isbold:NO cornerRadius:12 backgroundColor:[UIColor colorWithHex:@"#F26E1D" alpha:0.1]];
        _uuidTitleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _uuidTitleLb;
}

- (UILabel *)uuidLb
{
    if (!_uuidLb) {
        _uuidLb = [UILabel z_frame:CGRectMake(_uuidTitleLb.x, _uuidTitleLb.bottom + 5, self.width - _uuidTitleLb.x * 2, 20) Text:@"3924875982389648959435609845079436" fontSize:14 color:[UIColor colorWithHex:@"#747474"] isbold:NO];
       }
       return _uuidLb;
}


- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.width = 20;
        _activityIndicator.height = 20;
        _activityIndicator.x = _stateLb.x - 6 - 20;
        _activityIndicator.centerY = _stateLb.centerY;
        _activityIndicator.color = [UIColor colorWithHex:@"#26C464"];
    }
    
    return _activityIndicator;
}


@end
