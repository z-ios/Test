//
//  TestIoTHubCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TestIoTHubCollectionViewCell.h"
#import "BtnView.h"
#import "TestIoTHubView.h"

@interface TestIoTHubCollectionViewCell ()

@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) TestIoTHubView* iothubView;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* subtitleLb;
@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, assign) NSInteger idx;
@property (strong, nonatomic) MSWeakTimer *timer;
@property (nonatomic, strong) UILabel* timerLabel;
@property (nonatomic, strong) BluetoothEquipment* ble;
@property (nonatomic, strong) CBPeripheral *peripheral;

@end
@implementation TestIoTHubCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        [self setupUI];
    }
    return self;
}

#pragma mark - 页面显示触发代理方法
- (void)collectViewCellWillAppearDictData:(NSDictionary *)dictData
{
    
    _ble = dictData[@"ble"];
    _peripheral = dictData[@"peripheral"];
    _iothubView.biaoshiLb.text = dictData[@"biaoshimaStr"];
    _iothubView.xinghaoLb.text = dictData[@"xinghaoStr"];
    _iothubView.iothubLb.text = dictData[@"iotHubName"];
    _iothubView.iothubsubLb.text = dictData[@"iothubIp"];
    [self checkFirst];
    [self.activityIndicator startAnimating];
    [self sheBeiYanZheng:dictData];
    
    _idx = 0;
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(mainThreadTimerDidFire:)
                                                    userInfo:dictData
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
    
}

- (void)sheBeiYanZheng:(NSDictionary *)iothubdict
{
    NSString* wifiMac = @"";
    NSString* imei = @"";
    if ([_iothubView.xinghaoLb.text isEqualToString:@"SPMB-16DIO-002"]) {
        wifiMac = _iothubView.biaoshiLb.text;
    }else{
        imei = _iothubView.biaoshiLb.text;
    }
    
    NSDictionary* dict = @{
        @"group_id": CenterManager.shared.group_id,
        @"imei": imei,
        @"wifiMac": wifiMac,
        @"devicename": @"",
        @"hub_instancename": iothubdict[@"iotHubName"],
        @"hub_version": iothubdict[@"version"],
        @"hub_protocol": iothubdict[@"protocol"],
        @"hub_domain": iothubdict[@"iothubIp"],
        @"hub_mqttport": @([iothubdict[@"iothubPort"] integerValue]),
        @"hub_apiprefix": @"",
        @"hub_username": iothubdict[@"username"],
        @"hub_password": iothubdict[@"password"],
        @"remarks": @""
    };
    [CenterNet.shared deviceVerifyParam:dict completion:^(BOOL success, NSDictionary *dict) {
        if (success) {
            [self checkSuccess];
            self.iothubView.thingidLb.text = dict[@"hubid"];
        }else{
            if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hans"]) {
                self.subtitleLb.text = dict[@"message_cn"];
            }else{
                self.subtitleLb.text = dict[@"message_en"];
            }
        }
    }];
}

#pragma mark - MSWeakTimerDelegate

- (void)mainThreadTimerDidFire:(MSWeakTimer *)timer
{
    NSDictionary* timeDict =  timer.userInfo;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%zds",_idx++];
    
    if (_idx == 10) {// 第二次请求
        [self sheBeiYanZheng:timeDict];
    }else if (_idx == 20) {// 第三次请求
        [self sheBeiYanZheng:timeDict];
    }else if (_idx == 30) {
        [self checkFail];
    }
}

- (void)checkFirst
{
    self.titleLb.width = self.width - 32;
    self.titleLb.text = NSLocalizedString(@"验证中...", nil);
    [self.titleLb sizeToFit];
    self.imgV.hidden = YES;
    self.subtitleLb.hidden = YES;
    self.activityIndicator.hidden = NO;
    self.timerLabel.hidden = NO;
    
}

- (void)checkSuccess
{
    self.titleLb.width = self.width - 32;
    self.titleLb.text = NSLocalizedString(@"验证通过", nil);
    [self.titleLb sizeToFit];
    self.imgV.hidden = NO;
    self.imgV.image = [SVGKImage imageNamed:@"icon_check"].UIImage;
    self.subtitleLb.hidden = NO;
    self.activityIndicator.hidden = YES;
    self.timerLabel.hidden = YES;
    [self.timer invalidate];
    _btnV.typeBtnStr = @"两个按钮可点击";
}
- (void)checkFail
{
    self.titleLb.width = self.width - 32;
    self.titleLb.text = NSLocalizedString(@"验证失败", nil);
    [self.titleLb sizeToFit];
    self.imgV.hidden = NO;
    self.imgV.image = [SVGKImage imageNamed:@"icon_dr_process_fail"].UIImage;
    self.subtitleLb.hidden = NO;
    self.activityIndicator.hidden = YES;
    self.timerLabel.hidden = YES;
    [self.timer invalidate];
    _btnV.typeBtnStr = @"取消验证";
    if ([self.delegate respondsToSelector:@selector(iotHubcheckFail)]) {
        [self.delegate iotHubcheckFail];
    }
}

- (void)setupUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    if (IS_IPHONE_Xx) {
           self.scrollView.contentSize = CGSizeMake(0, SPH(600));
       }else{
           self.scrollView.contentSize = CGSizeMake(0, SPH(700));
       }
    [self.scrollView addSubview:self.titleLb];
    [self.scrollView addSubview:self.imgV];
    [self.scrollView addSubview:self.subtitleLb];
    [self.scrollView addSubview:self.iothubView];
    [self.scrollView addSubview:self.activityIndicator];
    [self.scrollView addSubview:self.timerLabel];
    [self addSubview:self.btnV];
    
}

#pragma mark - btnV点击代理方法-

- (void)stepClick
{
    [self.timer invalidate];
    [MBhud.shared showText:NSLocalizedString(@"设备重连中...", nil) addView:zAppWindow location:zScreenHeight*0.35 completion:^(MBProgressHUD * _Nonnull hud) {
        [MBhud showText:NSLocalizedString(@"连接超时", nil) addView:zAppWindow];
    }];
    [_ble setUpConnectPeripheral:_peripheral];
    
}

- (void)nextClick
{
    if ([self.delegate respondsToSelector:@selector(iothubThingId:)]) {
        [self.delegate iothubThingId:_iothubView.thingidLb.text];
    }
    
    if ([self.delegate respondsToSelector:@selector(nextClick)]) {
        [self.delegate nextClick];
    }

}

- (void)cancelClick
{
    if ([self.delegate respondsToSelector:@selector(cancelClick)]) {
        [self.delegate cancelClick];
    }
}

#pragma mark - 蓝牙连接成功
- (void)bleConnnectedSuccessBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral
{
    [MBhud.shared.hud hideAnimated:YES];
    [MBhud showText:NSLocalizedString(@"连接成功", nil) addView:zAppWindow];
    if ([self.delegate respondsToSelector:@selector(stepClick)]) {
        [self.delegate stepClick];
    }
}


#pragma mark - 控件懒加载

- (BtnView *)btnV
{
    if (!_btnV) {
        _btnV = [[BtnView alloc] initWithFrame:CGRectMake(SPW(16), self.height - SPH(44) - SPH(52), self.width - SPW(16)*2, SPH(52))];
        _btnV.delegate = self;
        _btnV.typeBtnStr = @"两个按钮不可点击";
    }
    
    return _btnV;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, SPH(30), self.width - 32, SPH(33)) Text:NSLocalizedString(@"验证中...", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
        [_titleLb sizeToFit];
    }
    return _titleLb;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLb.right + 10, 0, 24, 24)];
        _imgV.centerY = self.titleLb.centerY;
        _imgV.image = [SVGKImage imageNamed:@"icon_check"].UIImage;
        _imgV.hidden = YES;
    }
    
    return _imgV;
}

- (UILabel *)subtitleLb
{
    if (!_subtitleLb) {
        _subtitleLb = [UILabel z_frame:CGRectMake(25,_titleLb.bottom + SPH(8), self.width - 32, SPH(20)) Text:@"此设备已注册在IoTHub中" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _subtitleLb.hidden = YES;
    }
    
    return _subtitleLb;
}

- (TestIoTHubView *)iothubView
{
    if (!_iothubView) {
        _iothubView = [[TestIoTHubView alloc] initWithFrame:CGRectMake(SPW(25), _subtitleLb.bottom + SPH(20), self.width - SPW(50), 370)];
    }
    return _iothubView;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.frame = CGRectMake(self.titleLb.right + 10, 0, 24, 24);
        _activityIndicator.centerY = self.titleLb.centerY;
        
    }
    
    return _activityIndicator;

}

- (UILabel *)timerLabel
{
    if (!_timerLabel) {
        _timerLabel = [UILabel z_frame:CGRectMake(self.activityIndicator.right  + 10,0, 100, SPH(20)) Text:@"0s" fontSize:17 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        _timerLabel.centerY = self.titleLb.centerY;

    }
    
    return _timerLabel;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


@end
