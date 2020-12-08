//
//  NetLineCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "NetLineCollectionViewCell.h"
#import "LineTypeView.h"
#import "BtnView.h"
#import "WifiContentView.h"

@interface NetLineCollectionViewCell ()

@property (nonatomic, strong) UILabel* biaoShiMaLb;
@property (nonatomic, strong) UILabel* xingHaoLb;
  
@property (nonatomic, strong) LineTypeView* lineView;
@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) WifiContentView* wifiView;

@property (nonatomic, copy) NSString* flagStr;
@property (nonatomic, copy) NSString* xinghaoStr;
@property (nonatomic, copy) NSString* biaoshimaStr;
@property (nonatomic, copy) NSString* ssidStr;
@property (nonatomic, copy) NSString* pwdStr;
@property (nonatomic, copy) NSString* netTypeStr;
@property (nonatomic, copy) NSString* orderType;
@property (nonatomic, copy) NSString* ipStr;
@property (nonatomic, copy) NSString* portStr;
@property (nonatomic, strong) BluetoothEquipment* ble;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, assign) CGFloat scrollFlag;

@end
@implementation NetLineCollectionViewCell

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendBleReadOrder];
    });
}
#pragma mark - 蓝牙连接成功
- (void)bleConnnectedSuccessBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral
{
    [MBhud.shared.hud hideAnimated:YES];
    [MBhud showText:NSLocalizedString(@"连接成功", nil) addView:zAppWindow];
    if ([self.delegate respondsToSelector:@selector(BluetoothReconnection)]) {
        [self.delegate BluetoothReconnection];
    }
}
#pragma mark - 蓝牙重连提示
- (void)bleDisconnnectedBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral
{
    [MBhud.shared.hud hideAnimated:YES];
    
    UIAlertController *action = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"当前设备蓝牙已断开，是否重连？若取消则返回第一步", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"重新连接", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ble setUpConnectPeripheral:peripheral];
        [MBhud.shared showText:NSLocalizedString(@"设备重连中...", nil) addView:zAppWindow location:zScreenHeight*0.35 completion:^(MBProgressHUD * _Nonnull hud) {
            [MBhud showText:NSLocalizedString(@"连接超时", nil) addView:zAppWindow];
        }];
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if ([self.delegate respondsToSelector:@selector(cancelBleConnected)]) {
            [self.delegate cancelBleConnected];
        }
    }];
    [alertT setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
    [alertF setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
    [action addAction:alertT];
    [action addAction:alertF];
    
    [zAppWindow.rootViewController.presentedViewController presentViewController:action animated:YES completion:nil];
    
    self.btnV.typeBtnStr = @"两个按钮不可点击";
    [self.btnV.timer invalidate];
    
}
#pragma mark - setupUI
- (void)setupUI{
    
    _scrollFlag = 100;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.scrollView];
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(25, SPH(30), 0, SPH(33)) Text:NSLocalizedString(@"联网方式", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    [titleLb sizeToFit];
    [self.scrollView addSubview:titleLb];
    
    CGFloat w = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 71 : 140;
    UILabel* biaoShiMaTitleLb = [UILabel z_frame:CGRectMake(titleLb.x,titleLb.bottom + SPH(26), w, 28)
                                            Text:NSLocalizedString(@"标识码", nil)
                                        fontSize:SPFont(14)
                                           color:[UIColor colorWithHex:@"#646664"]
                                          isbold:NO
                                    cornerRadius:14
                                 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                                 ];
    biaoShiMaTitleLb.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:biaoShiMaTitleLb];
    
    _biaoShiMaLb = [UILabel z_frame:CGRectMake(biaoShiMaTitleLb.x, biaoShiMaTitleLb.bottom + 8, self.width - biaoShiMaTitleLb.x * 2, SPH(25)) Text:NSLocalizedString(@"正在获取标识码...", nil) fontSize:SPFont(18) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self.scrollView addSubview:_biaoShiMaLb];
    
    UILabel* xingHaoTitleLb = [UILabel z_frame:CGRectMake(titleLb.x,_biaoShiMaLb.bottom + SPH(15), SPW(57), 28)
                                            Text:NSLocalizedString(@"型号", nil)
                                        fontSize:SPFont(14)
                                           color:[UIColor colorWithHex:@"#646664"]
                                          isbold:NO
                                    cornerRadius:14
                                 backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                                 ];
    xingHaoTitleLb.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:xingHaoTitleLb];
    
    _xingHaoLb = [UILabel z_frame:CGRectMake(xingHaoTitleLb.x, xingHaoTitleLb.bottom + 8, _biaoShiMaLb.width, SPH(25)) Text:NSLocalizedString(@"正在获取型号...", nil) fontSize:SPFont(18) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self.scrollView addSubview:_xingHaoLb];
    
    [self addSubview:self.btnV];

}

#pragma mark - 发送写入信息命令
- (void)sendBleWriteOrder
{
    _btnV.typeBtnStr = @"两个按钮等待";
    
    if (![_xinghaoStr isEqualToString:@"SPMB-16DIO-001"]) {
        _orderType = @"写入";
    }else{
        // 读取读取ip和port
        _orderType = @"读取IP和port";
    }
    _flagStr = @"握手";
    // 发送命令
    [_ble setWriteInstruction:@"AT+HANDSHAKE=1234\r\n" blePeripheral:_peripheral];
    [MBhud.shared once_showText:@"正在写入握手命令..." addView:self location:self.height *0.2];
}

#pragma mark - 发送读取信息命令
- (void)sendBleReadOrder
{
    _flagStr = @"握手";
    _orderType = @"读取型号";
    [_ble setWriteInstruction:@"AT+HANDSHAKE=1234\r\n" blePeripheral:_peripheral];
    [MBhud.shared once_showText:@"正在写入握手命令..." addView:self.scrollView location:self.scrollView.height *0.2];
}


#pragma mark - 蓝牙读取结果
- (void)bleReadValueSuccessBleRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral
{
    
    if ([_orderType isEqualToString:@"写入"]) {
        if ([res isEqualToString:@"ERROR\r\n"]) {
            MBhud.shared.hud.label.text = @"写入数据失败,请重试";
            [MBhud.shared.hud hideAnimated:YES afterDelay:2];
            MBhud.shared.hud.completionBlock = ^{
                self.btnV.typeBtnStr = @"两个按钮可点击";
                [self.btnV.timer invalidate];
            };
        }else{
            if ([_flagStr isEqualToString:@"握手"] && [res isEqualToString:@"OK\r\n"]) {
                
                if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-002"]) {
                    MBhud.shared.hud.label.text = @"正在写入ssid...";
                    _flagStr = @"写入ssid";
                    NSString* ssidOrder = [NSString stringWithFormat:@"AT+SSID=%@\r\n",_wifiView.ssidTf.text];
                    
                    if (ssidOrder.length>20) {
                        if (ssidOrder.length - 2 > 20) {
                            NSString* beName = [ssidOrder substringToIndex:20];
                            NSString *afName = [ssidOrder substringFromIndex:20];
                            [_ble setWriteInstruction:beName blePeripheral:peripheral];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                            });
                        }else{
                            NSString* beName = [ssidOrder substringToIndex:ssidOrder.length - 3];
                            NSString *afName = [ssidOrder substringFromIndex:ssidOrder.length - 3];
                            [_ble setWriteInstruction:beName blePeripheral:peripheral];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                            });
                        }
                        
                    }else{
                        [_ble setWriteInstruction:ssidOrder blePeripheral:peripheral];
                    }
                }else{
                    
                    _flagStr = @"写入联网方式";
                    MBhud.shared.hud.label.text = @"正在写入联网方式...";
                    [_ble setWriteInstruction:[NSString stringWithFormat:@"AT+NETWORK=%@\r\n",_netTypeStr] blePeripheral:_peripheral];
                }
                
            }else if ([_flagStr isEqualToString:@"写入ssid"] && [res isEqualToString:@"OK\r\n"]) {
                MBhud.shared.hud.label.text = @"正在写入wifi密码...";
                _flagStr = @"写入wifi密码";
                NSString* pwdOrder = [NSString stringWithFormat:@"AT+PASSWORD=%@\r\n",_wifiView.pwdTf.text];
                if (pwdOrder.length>20) {
                    if (pwdOrder.length - 2 > 20) {
                        NSString* beName = [pwdOrder substringToIndex:20];
                        NSString *afName = [pwdOrder substringFromIndex:20];
                        [_ble setWriteInstruction:beName blePeripheral:peripheral];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                        });
                    }else{
                        NSString* beName = [pwdOrder substringToIndex:pwdOrder.length - 3];
                        NSString *afName = [pwdOrder substringFromIndex:pwdOrder.length - 3];
                        [_ble setWriteInstruction:beName blePeripheral:peripheral];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                        });
                    }
                    
                }else{
                    [_ble setWriteInstruction:pwdOrder blePeripheral:peripheral];
                }
            }else if ([_flagStr isEqualToString:@"写入wifi密码"] && [res isEqualToString:@"OK\r\n"]) {
                MBhud.shared.hud.label.text = @"正在获取服务器IP...";
                _orderType = @"读取IP和port";
                _flagStr = @"IP";
                [_ble setWriteInstruction:@"AT+IP\r\n" blePeripheral:peripheral];
            }else if ([_flagStr isEqualToString:@"写入联网方式"] && [res isEqualToString:@"OK\r\n"] ) {
                if ([_netTypeStr integerValue] == 2) {
                    _flagStr = @"写入ssid";
                    MBhud.shared.hud.label.text = @"正在写入ssid...";
                    NSString* ssidOrder = [NSString stringWithFormat:@"AT+SSID=%@\r\n",_wifiView.ssidTf.text];
                    if (ssidOrder.length>20) {
                        if (ssidOrder.length - 2 > 20) {
                            NSString* beName = [ssidOrder substringToIndex:20];
                            NSString *afName = [ssidOrder substringFromIndex:20];
                            [_ble setWriteInstruction:beName blePeripheral:peripheral];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                            });
                        }else{
                            NSString* beName = [ssidOrder substringToIndex:ssidOrder.length - 3];
                            NSString *afName = [ssidOrder substringFromIndex:ssidOrder.length - 3];
                            [_ble setWriteInstruction:beName blePeripheral:peripheral];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                            });
                        }
                        
                    }else{
                        [_ble setWriteInstruction:ssidOrder blePeripheral:peripheral];
                    }
                }else{// 选择4g模式
                    MBhud.shared.hud.label.text = @"正在获取服务器IP...";
                    _flagStr = @"IP";
                    _orderType = @"读取IP和port";
                    [_ble setWriteInstruction:@"AT+IP\r\n" blePeripheral:peripheral];
                }
            }
        }
    }else if ([_orderType isEqualToString:@"读取型号"]) {
        if ([res isEqualToString:@"ERROR\r\n"]) {
            MBhud.shared.hud.label.text = @"获取数据失败";
            [MBhud.shared.hud hideAnimated:YES afterDelay:2];
            MBhud.shared.hud.completionBlock = ^{
                if ([self.delegate respondsToSelector:@selector(stepClick)]) {
                    [self.delegate stepClick];
                }
            };
        }else{
            if ([_flagStr isEqualToString:@"握手"] && [res isEqualToString:@"OK\r\n"]) {
                _flagStr = @"型号";
                MBhud.shared.hud.label.text = @"正在获取设备型号...";
                [_ble setWriteInstruction:@"AT+DEVICETYPE\r\n" blePeripheral:peripheral];
            }else if ([_flagStr isEqualToString:@"型号"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+DEVICETYPE\r\n"]) {
                _xinghaoStr = [res substringToIndex:res.length - 2];
                if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-002"]) {// 单wifi
                    _flagStr = @"标识码wifimac";
                    [_ble setWriteInstruction:@"AT+WIFIMAC\r\n" blePeripheral:peripheral];
                }else{
                    _flagStr = @"标识码";
                    [_ble setWriteInstruction:@"AT+LTEIMEI\r\n" blePeripheral:peripheral];
                }
                MBhud.shared.hud.label.text = @"正在获取标识码...";
            }else if ([_flagStr isEqualToString:@"标识码wifimac"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+WIFIMAC\r\n"]) {
                _biaoshimaStr = [res substringToIndex:res.length - 2];
                MBhud.shared.hud.label.text = @"正在获取WIFI用户名...";
                _flagStr = @"ssid";
                [_ble setWriteInstruction:@"AT+SSID\r\n" blePeripheral:peripheral];
            }else if ([_flagStr isEqualToString:@"标识码"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+LTEIMEI\r\n"]) {
                _biaoshimaStr = [res substringToIndex:res.length - 2];
                MBhud.shared.hud.label.text = @"正在获取WIFI用户名...";
                _flagStr = @"ssid";
                [_ble setWriteInstruction:@"AT+SSID\r\n" blePeripheral:peripheral];
            }else if ([_flagStr isEqualToString:@"ssid"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+SSID\r\n"]) {
                MBhud.shared.hud.label.text = @"正在获取WIFI密码...";
                _ssidStr = [res substringToIndex:res.length - 2];
                _flagStr = @"PASSWORD";
                [_ble setWriteInstruction:@"AT+PASSWORD\r\n" blePeripheral:peripheral];
            }else if ([_flagStr isEqualToString:@"PASSWORD"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+PASSWORD\r\n"]) {
                _pwdStr = [res substringToIndex:res.length - 2];
                if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-002"]) {// 单wifi
                    MBhud.shared.hud.label.text = @"数据获取成功";
                    [MBhud.shared.hud hideAnimated:YES];
                    [self makeSureLine];
                }else{
                    MBhud.shared.hud.label.text = @"正在获取联网方式...";
                    _flagStr = @"联网方式";
                    [_ble setWriteInstruction:@"AT+NETWORK\r\n" blePeripheral:peripheral];
                }
                
            }else if ([_flagStr isEqualToString:@"联网方式"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+NETWORK\r\n"]) {
                _netTypeStr = [res substringToIndex:res.length - 2];
                NSLog(@"***%@--%@--%@--%@--%@",_xinghaoStr,_biaoshimaStr,_ssidStr,_pwdStr,_netTypeStr);
                MBhud.shared.hud.label.text = @"数据获取成功";
                [MBhud.shared.hud hideAnimated:YES];
                [self makeSureLine];
            }
        }
    }else if ([_orderType isEqualToString:@"读取IP和port"]) {
        if ([_flagStr isEqualToString:@"握手"] && [res isEqualToString:@"OK\r\n"]) {
            MBhud.shared.hud.label.text = @"正在获取服务器IP...";
            _flagStr = @"IP";
            [_ble setWriteInstruction:@"AT+IP\r\n" blePeripheral:peripheral];
        }else if ([_flagStr isEqualToString:@"IP"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+IP\r\n"]) {
            _ipStr = [res substringToIndex:res.length - 2];
            MBhud.shared.hud.label.text = @"正在获取服务器端口...";
            _flagStr = @"port";
            [_ble setWriteInstruction:@"AT+PORT\r\n" blePeripheral:peripheral];
        }else if ([_flagStr isEqualToString:@"port"] && ![res isEqualToString:@"OK\r\n"] && ![res isEqualToString:@"AT+PORT\r\n"]) {
            _portStr = [res substringToIndex:res.length - 2];
            MBhud.shared.hud.label.text = @"数据获取成功";
            [MBhud.shared.hud hideAnimated:YES];
            [self.btnV.timer invalidate];
            if ([self.delegate respondsToSelector:@selector(netIpAndPortWithSeverIp:severPort:biaoshima:xinghao:)]) {
                [self.delegate netIpAndPortWithSeverIp:_ipStr severPort:_portStr biaoshima:_biaoshimaStr xinghao:_xinghaoStr];
            }
            if ([self.delegate respondsToSelector:@selector(nextClick)]) {
                [self.delegate nextClick];
            }
            self.btnV.typeBtnStr = @"两个按钮可点击";
        }
    }
}


#pragma mark - 改变显示状态
- (void)makeSureLine
{
    _xingHaoLb.text = _xinghaoStr;
    _biaoShiMaLb.text = _biaoshimaStr;

    [self.scrollView addSubview:self.lineView];
    
    if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-001"]) {// 单4g
        self.lineView.lineTypeStr = @"4g";
        self.btnV.typeBtnStr = @"两个按钮可点击";
    }else if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-002"]) {// 单wifi
        self.lineView.lineTypeStr = @"wifi";
        [self.scrollView addSubview:self.wifiView];
        self.scrollView.contentSize = CGSizeMake(0, self.height + _scrollFlag);
        if (_ssidStr.length > 0 && _pwdStr.length > 0) {
            self.btnV.typeBtnStr = @"两个按钮可点击";
            self.wifiView.ssidTf.text = _ssidStr;
            self.wifiView.pwdTf.text = _pwdStr;
        }
    }else if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-003"]) {// 4g+wifi
        self.lineView.lineTypeStr = @"4gwifi";
        self.btnV.typeBtnStr = @"两个按钮可点击";
        [self.scrollView addSubview:self.wifiView];
        self.scrollView.contentSize = CGSizeMake(0, self.height + _scrollFlag);
        if ([_netTypeStr integerValue] == 2) {
            [self.lineView wifiBtnClick:self.lineView.wifiBtn];
        }else{
            [self.lineView gBtnClick:self.lineView.gBtn];
        }
        if (_ssidStr.length > 0 && _pwdStr.length > 0) {
            self.btnV.typeBtnStr = @"两个按钮可点击";
            self.wifiView.ssidTf.text = _ssidStr;
            self.wifiView.pwdTf.text = _pwdStr;
        }
    }else if ([_xinghaoStr isEqualToString:@"SPMB-16DIO-003.EU"]) {// 4g+wifi欧版
        self.lineView.lineTypeStr = @"4gwifi";
        self.btnV.typeBtnStr = @"两个按钮可点击";
        [self.scrollView addSubview:self.wifiView];
        self.scrollView.contentSize = CGSizeMake(0, self.height + _scrollFlag);
        if ([_netTypeStr integerValue] == 2) {
            [self.lineView wifiBtnClick:self.lineView.wifiBtn];
        }else{
            [self.lineView gBtnClick:self.lineView.gBtn];
        }
        if (_ssidStr.length > 0 && _pwdStr.length > 0) {
            self.btnV.typeBtnStr = @"两个按钮可点击";
            self.wifiView.ssidTf.text = _ssidStr;
            self.wifiView.pwdTf.text = _pwdStr;
        }
    }
}
#pragma mark - 切换4g，wifi
- (void)changeNetAndWifiType:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"4g"]) {
        self.btnV.typeBtnStr = @"两个按钮可点击";
        [self.wifiView dismiss];
        _netTypeStr = @"1";
    }else {
        [self.wifiView show];
        _netTypeStr = @"2";
    }
}

#pragma mark - wifi输入是否完成
- (void)wifiContentFinishType:(BOOL)isFinish
{
    if (isFinish) {
        self.btnV.typeBtnStr = @"两个按钮可点击";
    }else{
        self.btnV.typeBtnStr = @"两个按钮不可点击";
    }
}


#pragma mark - btnV点击代理方法-

- (void)stepClick
{
    
    UIAlertController *action = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"返回上一步当前连接设备即会断开，确定返回？", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self.ble.centralManager cancelPeripheralConnection:self.peripheral];
              if ([self.delegate respondsToSelector:@selector(stepClick)]) {
                  [self.delegate stepClick];
              }
       }];
       UIAlertAction *alertF = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       }];
       [alertT setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
       [alertF setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
       [action addAction:alertT];
       [action addAction:alertF];
       
       [zAppWindow.rootViewController.presentedViewController presentViewController:action animated:YES completion:nil];
    
}

- (void)nextClick
{
    // 发送命令
    [self sendBleWriteOrder];
    
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

- (LineTypeView *)lineView
{
    if (!_lineView) {
        _lineView = [[LineTypeView alloc] initWithFrame:CGRectMake(_xingHaoLb.x, _xingHaoLb.bottom + SPH(15), self.width - _xingHaoLb.x * 2, 118)];
        _lineView.delegate = self;
    }
    return _lineView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (WifiContentView *)wifiView
{
    if (!_wifiView) {
        _wifiView = [[WifiContentView alloc] initWithFrame:CGRectMake(self.lineView.x, self.lineView.bottom + SPH(25), self.lineView.width, SPH(180))];
        _wifiView.backgroundColor = [UIColor whiteColor];
        _wifiView.delegate = self;
    }
    return _wifiView;
}


@end
