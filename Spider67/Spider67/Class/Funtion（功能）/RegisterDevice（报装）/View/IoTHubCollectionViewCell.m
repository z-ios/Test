//
//  IoTHubCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IoTHubCollectionViewCell.h"
#import "IoTHubTabCell.h"
#import "IoTHubModel.h"
#import "BtnView.h"

@interface IoTHubCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<IoTHubModel *>* iotHubModelList;
@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, copy) NSString* flagStr;
@property (nonatomic, copy) NSString* readipStr;
@property (nonatomic, copy) NSString* readportStr;
@property (nonatomic, strong) BluetoothEquipment* ble;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) NSMutableDictionary* dictM;

@end
@implementation IoTHubCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (NSMutableDictionary *)dictM
{
    if (!_dictM) {
        _dictM = [NSMutableDictionary dictionary];
    }
    return _dictM;
}

#pragma mark - 页面显示触发代理方法
- (void)collectViewCellWillAppearDictData:(NSDictionary *)dictData
{
    _ble = dictData[@"ble"];
    _peripheral = dictData[@"peripheral"];
    _readipStr = dictData[@"severIp"];
    _readportStr = dictData[@"severPort"];
    
    [CenterNet .shared checkIoTHubCompletion:^(BOOL success, NSArray * _Nullable dataList) {
        
        self.iotHubModelList = [NSArray yy_modelArrayWithClass:[IoTHubModel class] json:dataList];
        
        for (IoTHubModel * _Nonnull model in self.iotHubModelList) {
            if ([[NSString stringWithFormat:@"%@",model.mqttport] isEqualToString:self.readportStr] && [model.domain isEqualToString:self.readipStr]) {
                model.isSelected = YES;
                self.btnV.typeBtnStr = @"两个按钮可点击";
                break;
            }else{
                model.isSelected = NO;
            }
        }
        
        [self.tableView reloadData];
        
    }];
    
}

#pragma mark - 蓝牙连接成功
- (void)bleConnnectedSuccessBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral
{
    [MBhud.shared.hud hideAnimated:YES];
    [MBhud showText:NSLocalizedString(@"连接成功", nil) addView:zAppWindow];
    if ([self.delegate respondsToSelector:@selector(BluetoothReconnection)]) {
        [self.delegate BluetoothReconnection];
    }
    __block BOOL iscontent = NO;
    [self.iotHubModelList enumerateObjectsUsingBlock:^(IoTHubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.iothubCellLineFlag = NO;
        if (obj.isSelected == YES) {
            iscontent = YES;
        }
    }];
    [self.tableView reloadData];
    if (iscontent) {
        self.btnV.typeBtnStr = @"两个按钮可点击";
    }else{
        self.btnV.typeBtnStr = @"两个按钮不可点击";
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
        [self.iotHubModelList enumerateObjectsUsingBlock:^(IoTHubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.iothubCellLineFlag = YES;
        }];
        [self.tableView reloadData];
        self.btnV.typeBtnStr = @"两个按钮都不可点击";
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


- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(25, SPH(30), self.width - 32, SPH(33)) Text:@"IoTHub实例" fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    [titleLb sizeToFit];
    [self addSubview:titleLb];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SPW(25), titleLb.bottom+7.5, self.width - SPW(50), self.height - (titleLb.bottom + SPH(15))) style:(UITableViewStylePlain)];
    _tableView.backgroundColor =  [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.rowHeight = SPH(64);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SPH(80), 0);
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    
    [_tableView registerClass:[IoTHubTabCell class] forCellReuseIdentifier:@"IoTHubTabCell"];
    
    [self addSubview:self.btnV];

}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.iotHubModelList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IoTHubTabCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IoTHubTabCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _iotHubModelList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_iotHubModelList enumerateObjectsUsingBlock:^(IoTHubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == idx) {
            obj.isSelected = YES;
            self.btnV.typeBtnStr = @"两个按钮可点击";
        }else{
            obj.isSelected = NO;
        }
    }];
    [tableView reloadData];
}

#pragma mark - 发送命令
- (void)sendBleWriteOrder
{
    _btnV.typeBtnStr = @"两个按钮等待";
    _flagStr = @"握手";
    // 发送命令
    [_ble setWriteInstruction:@"AT+HANDSHAKE=1234\r\n" blePeripheral:_peripheral];
    [MBhud.shared once_showText:@"正在写入握手命令..." addView:self location:self.height *0.2];
    
}
#pragma mark - 蓝牙读取结果
- (void)bleReadValueSuccessBleRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral
{
    if ([res isEqualToString:@"ERROR\r\n"]) {
        MBhud.shared.hud.label.text = @"写入数据失败,请重试";
        [MBhud.shared.hud hideAnimated:YES afterDelay:2];
        MBhud.shared.hud.completionBlock = ^{
            self.btnV.typeBtnStr = @"两个按钮可点击";
            [self.btnV.timer invalidate];
        };
    }else{
        if ([_flagStr isEqualToString:@"握手"] && [res isEqualToString:@"OK\r\n"]) {
            MBhud.shared.hud.label.text = @"正在写入ip...";
            _flagStr = @"写入ip";
            NSString* ipOrder = [NSString stringWithFormat:@"AT+IP=%@\r\n",self.dictM[@"domain"]];
            if (ipOrder.length>20) {
                if (ipOrder.length - 2 > 20) {
                    NSString* beName = [ipOrder substringToIndex:20];
                    NSString *afName = [ipOrder substringFromIndex:20];
                    [_ble setWriteInstruction:beName blePeripheral:peripheral];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                    });
                }else{
                    NSString* beName = [ipOrder substringToIndex:ipOrder.length - 3];
                    NSString *afName = [ipOrder substringFromIndex:ipOrder.length - 3];
                    [_ble setWriteInstruction:beName blePeripheral:peripheral];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.ble setWriteInstruction:afName blePeripheral:peripheral];
                    });
                }
   
            }else{
                [_ble setWriteInstruction:ipOrder blePeripheral:peripheral];
            }
        }else if ([_flagStr isEqualToString:@"写入ip"] && [res isEqualToString:@"OK\r\n"]) {
            MBhud.shared.hud.label.text = @"正在写入port...";
            _flagStr = @"写入port";
            NSString* portOrder = [NSString stringWithFormat:@"AT+PORT=%@",self.dictM[@"mqttport"]];
            [_ble setWriteInstruction:[NSString stringWithFormat:@"%@\r\n",portOrder] blePeripheral:peripheral];
        }else if ([_flagStr isEqualToString:@"写入port"] && [res isEqualToString:@"OK\r\n"]) {
            MBhud.shared.hud.label.text = @"写入完成";
            [MBhud.shared.hud hideAnimated:YES afterDelay:2];
            [self.btnV.timer invalidate];
            self.btnV.typeBtnStr = @"两个按钮可点击";
            if ([self.delegate respondsToSelector:@selector(selectediotHubInfo:)]) {
                [self.delegate selectediotHubInfo:self.dictM.copy];
            }
            if ([self.delegate respondsToSelector:@selector(nextClick)]) {
                [self.delegate nextClick];
            }
        }
    }
}


#pragma mark - btnV点击代理方法-

- (void)stepClick
{
    if ([self.delegate respondsToSelector:@selector(stepClick)]) {
        [self.delegate stepClick];
    }
}

- (void)nextClick
{
    [_iotHubModelList enumerateObjectsUsingBlock:^(IoTHubModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected == YES) {
            
            self.dictM[@"domain"] = obj.domain;
            self.dictM[@"mqttport"] = obj.mqttport;
            self.dictM[@"instancename"] = obj.instancename;
            self.dictM[@"protocol"] = obj.protocol;
            self.dictM[@"password"] = obj.password;
            self.dictM[@"username"] = obj.username;
            self.dictM[@"version"] = obj.version;
            
        }
    }];
    
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

@end
