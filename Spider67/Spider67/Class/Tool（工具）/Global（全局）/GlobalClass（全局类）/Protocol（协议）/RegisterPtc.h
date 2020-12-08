//
//  RegisterPtc.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BtnView;
@protocol RegisterPtc <NSObject>

@optional

// 按钮点击方法
- (void)nextClick;
- (void)stepClick;
- (void)cancelClick;

// 在非搜索界面断开连接提示重连
- (void)bleDisconnnectedBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral;
// 重连三次
- (void)bleDisconnnectedBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral isReline:(BOOL)isReline;
// 在非搜索界面连接成功
- (void)bleConnnectedSuccessBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral;
// 蓝牙读取数据成功
- (void)bleReadValueSuccessBleRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral;
// wifi配置
- (void)wifiContentFinishType:(BOOL)isFinish;
// 切换4g wifi
- (void)changeNetAndWifiType:(NSString *)typeStr;
// 把服务器端口和地址传到iothub配置
- (void)netIpAndPortWithSeverIp:(NSString *)severIp severPort:(NSString *)severPort biaoshima:(NSString *)biaoshimaStr xinghao:(NSString *)xinghaoStr;
// 选择之后的ip和iothub名字
- (void)selectediotHubInfo:(NSDictionary *)dict;
// 验证失败
- (void)iotHubcheckFail;
// 界面显示出发
- (void)collectViewCellWillAppearDictData:(NSDictionary *)dictData;
// 取消重连
- (void)cancelBleConnected;
// 蓝牙重连
- (void)BluetoothReconnection;
// 传值thingId
- (void)iothubThingId:(NSString *)thingId;
// 传值设备名字和群组
- (void)deviceName:(NSString *)devieceName groupName:(NSString *)groupName registerId:(NSString *)registerId note:(NSDictionary *)note;

@end

NS_ASSUME_NONNULL_END
