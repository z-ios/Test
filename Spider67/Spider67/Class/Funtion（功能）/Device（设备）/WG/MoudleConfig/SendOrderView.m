//
//  SendOrderView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendOrderView.h"

@interface SendOrderView ()

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;
@property (nonatomic, strong) UILabel* dangqianzhi_t_lb;
@property (nonatomic, strong) UILabel* dangqianzhi_lb;
@property (nonatomic, strong) UILabel* dangqianzhi_l_lb;

@property (nonatomic, strong) UILabel* writeValue_t_lb;
@property (nonatomic, strong) UILabel* writeValue_state_lb;
@property (nonatomic, strong) UISwitch* writeValue_state_sw;

@property (nonatomic, strong) UIButton* sendOrder_btn;
@property (nonatomic, strong) UIButton* sure_btn;

@end
@implementation SendOrderView

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
    [self addSubview:self.dangqianzhi_t_lb];
    [self addSubview:self.dangqianzhi_lb];
    [self addSubview:self.dangqianzhi_l_lb];
    [self addSubview:self.writeValue_t_lb];
    [self addSubview:self.writeValue_state_lb];
    [self addSubview:self.writeValue_state_sw];
    [self addSubview:self.sendOrder_btn];
    [self addSubview:self.sure_btn];

}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.dangqianzhi_lb.text = _dict[@"originalvalue"];
}

-(void)mySwtichValueChange:(UISwitch *)mySwitch {
    if (mySwitch.on == YES) {
        NSLog(@"开启状态");
        self.writeValue_state_lb.text = @"闭合";
    }else {
        NSLog(@"关闭状态");
        self.writeValue_state_lb.text = @"断开";
    }
}


- (void)sendOrder_btnClick
{
    NSString* value = _writeValue_state_sw.on == YES ? @"true" : @"false";
    [CenterNet.shared ChannelWriteValueParm:_dict[@"device_id"] channelName:_dict[@"channelname"] value:value completion:^(NSDictionary *dict) {}];
}

- (void)sure_btnClick
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

- (void)cancelBtnClick
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

- (void)moreInfo_btnClick
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"对数字量channel执行闭合、断开操作", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertT setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
    [actionSheet addAction:alertT];
    [zAppWindow.rootViewController presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:NSLocalizedString(@"下发写值命令", nil) fontSize:SPFont(30) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
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

- (UILabel *)dangqianzhi_t_lb
{
    if (!_dangqianzhi_t_lb) {
           _dangqianzhi_t_lb = [UILabel z_frame:CGRectMake(25, self.titleLb.bottom + 25, 300, 20) Text:NSLocalizedString(@"当前值", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
       }
       return _dangqianzhi_t_lb;
}

- (UILabel *)dangqianzhi_lb
{
    if (!_dangqianzhi_lb) {
        _dangqianzhi_lb = [UILabel z_frame:CGRectMake(0, self.titleLb.bottom + 65, 300, 40) Text:@"--" fontSize:28 color:[UIColor colorWithHex:@"#26C464"] isbold:YES];
        _dangqianzhi_lb.centerX = self.width * 0.5;
        _dangqianzhi_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _dangqianzhi_lb;
}

- (UILabel *)dangqianzhi_l_lb
{
    if (!_dangqianzhi_l_lb) {
        _dangqianzhi_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(25, self.dangqianzhi_lb.bottom + 15, self.width - 50, 1)];
        _dangqianzhi_l_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _dangqianzhi_l_lb;
}

- (UILabel *)writeValue_t_lb
{
    if (!_writeValue_t_lb) {
        _writeValue_t_lb = [UILabel z_frame:CGRectMake(25, self.dangqianzhi_l_lb.bottom + 25, 300, 20) Text:NSLocalizedString(@"写值动作", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _writeValue_t_lb;
}

- (UILabel *)writeValue_state_lb
{
    if (!_writeValue_state_lb) {
           _writeValue_state_lb = [UILabel z_frame:CGRectMake(25, self.writeValue_t_lb.bottom + 8, 300, 24) Text:NSLocalizedString(@"断开", nil) fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
       }
       return _writeValue_state_lb;
}

- (UISwitch *)writeValue_state_sw
{
    if (!_writeValue_state_sw) {
        _writeValue_state_sw = [[UISwitch alloc] init];
        _writeValue_state_sw.x = self.width - 25 - _writeValue_state_sw.width;
        _writeValue_state_sw.centerY = self.writeValue_state_lb.centerY;
        //添加事件
        [_writeValue_state_sw addTarget:self action:@selector(mySwtichValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _writeValue_state_sw;
}

- (UIButton *)sendOrder_btn
{
    if (!_sendOrder_btn) {
        _sendOrder_btn = [UIButton z_frame:CGRectMake(25, self.writeValue_state_lb.bottom + 39,self.width - 50 , 52)
                                  fontSize:18
                              cornerRadius:6
                           backgroundColor:[UIColor colorWithHex:@"#E0F5E8"]
                                titleColor:[UIColor colorWithHex:@"#26C464"]
                                     title:NSLocalizedString(@"下发命令", nil)
                                    isbold:YES
                                    Target:self
                                    action:@selector(sendOrder_btnClick)
                          ];
    }
    
    return _sendOrder_btn;
}

- (UIButton *)sure_btn
{
    if (!_sure_btn) {
        _sure_btn = [UIButton z_frame:CGRectMake(25, self.sendOrder_btn.bottom + 15,self.width - 50 , 52)
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
