//
//  BlePtc.h
//  Spider67Ble
//
//  Created by apple on 17/7/10.
//  Copyright © 2019 elco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BlePtc <NSObject>

@optional
// 开启蓝牙
- (void)bleOpen;
// 蓝牙扫描结果
- (void)bleScanResDiscoverPeripheral:(CBPeripheral *)peripheral;
// 连接成功
- (void)connectSuccessCentralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;
// 掉线
- (void)bleCentralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral;
// 读取到服务
- (void)bleDiscoverServicesPeripheral:(CBPeripheral *)peripheral;
// 读写特征
- (void)bleDidDiscoverCharacteristics:(CBCharacteristic *)c peripheral:(CBPeripheral *)peripheral type:(NSString *)type;
// 获取读取结果
- (void)bleReadRes:(NSString *)res;
- (void)bleReadRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
