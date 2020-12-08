//
//  BluetoothEquipment.h
//  蓝牙
//
//  Created by elco on 2018/5/16.
//  Copyright © 2018年 elco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BlePtc.h"

@interface BluetoothEquipment : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(nonatomic,strong)CBCentralManager* centralManager;

- (void)initCentralManager;//初始化中心设备管理器
- (void)setUpConnectPeripheral:(CBPeripheral *)peripheral;// 建立连接
- (void)setWriteInstruction:(NSString *)writeInstruction writeCharacteristic:(CBCharacteristic *) writeCharacteristic blePeripheral:(CBPeripheral *)blePeripheral;
- (void)setWriteInstruction:(NSString *)writeInstruction blePeripheral:(CBPeripheral *)blePeripheral;
@property (nonatomic, strong) CBCharacteristic* c;
@property (nonatomic, weak) id<BlePtc> delegate;

@end
