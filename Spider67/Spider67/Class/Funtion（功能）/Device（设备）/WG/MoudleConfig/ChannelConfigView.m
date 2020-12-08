//
//  ChannelConfigView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ChannelConfigView.h"
#import "ChannelConfigBtnView.h"

@interface ChannelConfigView ()<DevicePtc>

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;

@property (nonatomic, strong) UITextField* name_tf;

@property (nonatomic, strong) UILabel* type_lb;

@property (nonatomic, strong) ChannelConfigBtnView* btnView;

@property (nonatomic, strong) UIButton* sure_btn;


@end
@implementation ChannelConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  whiteColor];
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.moreInfo_btn];
    [self addSubview:self.name_tf];
    [self addSubview:self.type_lb];
    [self addSubview:self.btnView];
    [self addSubview:self.sure_btn];
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    _btnView.typeStr = dict[@"channeltype"];
    _name_tf.text = dict[@"channeltitle"];
    if ([_moduletype isEqualToString:@"CH8_DUP_M12"] || [_moduletype isEqualToString:@"CH8_DUP_M8"]) {
        _btnView.btnNames = @[@"OUTPUT",@"INPUT",@"UNIVERSAL"];
        _btnView.height = 143;
        _sure_btn.y = _btnView.bottom + 50;
    }else if ([_moduletype isEqualToString:@"CH8_DI_M12"] || [_moduletype isEqualToString:@"CH8_DI_M8"]) {
        _btnView.btnNames = @[@"INPUT"];
    }else if ([_moduletype isEqualToString:@"CH8_DO_M12"] || [_moduletype isEqualToString:@"CH8_DO_M8"]) {
        _btnView.btnNames = @[@"OUTPUT"];
    }
}

- (void)cancelBtnClick
{
   [self dismissView];
}

- (void)moreInfo_btnClick
{
    [DescriptionMaskView showPageViewWithtype:WgChannel];
}

- (void)sure_btnClick
{
    [CenterNet.shared ChannelConfigSaveDeviceId:_dict[@"device_id"] channelName:_dict[@"channelname"] defineName:_name_tf.text channelType:_btnView.typeStr completion:^(NSDictionary *dict) {
        [self dismissView];
    }];
    
}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.x = zScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

//- (void)selectChannelType:(NSString *)channelType
//{
////    _channeltype = channelType;
//}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:NSLocalizedString(@"channel配置", nil) fontSize:SPFont(30) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_titleLb sizeToFit];
    }
    return _titleLb;
}

- (UIButton *)moreInfo_btn
{
    if (!_moreInfo_btn) {
        _moreInfo_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleLb.right + 15, 0, 24, 24)];
        [_moreInfo_btn setImage:[SVGKImage imageNamed:@"icon_confi_information"].UIImage forState:UIControlStateNormal];
        _moreInfo_btn.centerY = self.titleLb.centerY;
        [_moreInfo_btn addTarget:self action:@selector(moreInfo_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreInfo_btn;
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_back_big"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UITextField *)name_tf
{
    if (!_name_tf) {
        _name_tf = [[UITextField alloc] initWithFrame:CGRectMake(self.titleLb.x, self.titleLb.bottom + 25, self.width - 50, 54)];
        _name_tf.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _name_tf.placeholder = NSLocalizedString(@"请输入输入自定义名称", nil);
        _name_tf.layer.cornerRadius = 6;
        _name_tf.layer.masksToBounds = YES;
        _name_tf.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    return _name_tf;
}

- (UILabel *)type_lb
{
    if (!_type_lb) {
        _type_lb = [UILabel z_frame:CGRectMake(25, self.name_tf.bottom + 10, 60, 40) Text:@"type" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _type_lb;
}

- (ChannelConfigBtnView *)btnView
{
    if (!_btnView) {
        _btnView = [[ChannelConfigBtnView alloc] initWithFrame:CGRectMake(25, self.type_lb.bottom + 5, self.width - 50, 64)];
//        _btnView.delegate = self;
    }
    return _btnView;
}

- (UIButton *)sure_btn
{
    if (!_sure_btn) {
        _sure_btn = [UIButton z_frame:CGRectMake(25, self.btnView.bottom + 50,self.width - 50 , 52)
                             fontSize:18
                         cornerRadius:6
                      backgroundColor:[UIColor colorWithHex:@"#26C464"]
                           titleColor:[UIColor colorWithHex:@"#FFFFFF"]
                                title:NSLocalizedString(@"确定", nil)
                               isbold:YES
                               Target:self
                               action:@selector(sure_btnClick)
                     ];
    }
    
    return _sure_btn;
}

@end
