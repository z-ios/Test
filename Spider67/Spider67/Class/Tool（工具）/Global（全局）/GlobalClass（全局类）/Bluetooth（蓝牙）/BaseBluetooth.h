//
//  BaseBluetooth.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseBluetooth : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(nonatomic,strong)CBCentralManager* centralManager;

- (void)initCentralManager;//初始化中心设备管理器
- (void)setUpConnectPeripheral:(CBPeripheral *)peripheral;// 建立连接
-(void)setWriteInstruction:(NSString *)writeInstruction writeCharacteristic:(CBCharacteristic *) writeCharacteristic blePeripheral:(CBPeripheral *)blePeripheral;

@property (nonatomic, strong) CBCharacteristic* c;

@end

NS_ASSUME_NONNULL_END
