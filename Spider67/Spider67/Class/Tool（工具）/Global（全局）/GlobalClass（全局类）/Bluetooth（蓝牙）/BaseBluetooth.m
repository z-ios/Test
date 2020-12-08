//
//  BaseBluetooth.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BaseBluetooth.h"

@implementation BaseBluetooth

#pragma mark - 传入解锁指令
-(void)setWriteInstruction:(NSString *)writeInstruction writeCharacteristic:(CBCharacteristic *) writeCharacteristic blePeripheral:(CBPeripheral *)blePeripheral{
    if (writeInstruction) {
        NSData* writeValue = [self dataWithString:writeInstruction];
        [blePeripheral writeValue:writeValue forCharacteristic:writeCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

//初始化中心设备管理器
- (void)initCentralManager{
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

//创建完成CBCentralManager对象之后会回调的代理方法
- (void)centralManagerDidUpdateState:(CBCentralManager *)central;
{
    switch (central.state) {
        case CBManagerStateUnknown:
        {    // 未知状态
            NSLog(@" 蓝牙状态 - 未知状态 ");
        }
            break;
        case CBManagerStateResetting:
        {   // 正在重置，与系统服务暂时丢失
            NSLog(@" 蓝牙状态 - 正在重置，与系统服务暂时丢失 ");
        }
            break;
        case CBManagerStateUnsupported:
        {   // 不支持蓝牙
            NSLog(@" 蓝牙状态 - 不支持蓝牙 ");
        }
            break;
        case CBManagerStateUnauthorized:
        {   // 未授权
            NSLog(@" 蓝牙状态 - 未授权 ");
        }
            break;
        case CBManagerStatePoweredOff:
        {   // 关闭
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bleConnectalert" object:nil];
            NSLog(@" 蓝牙状态 - 关闭 ");
        }
            break;
        case CBManagerStatePoweredOn:
        {   // 开启并可用
//            if ([self.delegate respondsToSelector:@selector(bleOpen)]) {
//                [self.delegate bleOpen];
//            }
//            [self.centralManager scanForPeripheralsWithServices:nil options:nil];
            
            NSLog(@" 蓝牙 - 开启并可用 ");
        }
            break;
            
        default:
            break;
    }

}

//执行扫描的动作之后，如果扫描到外设了，就会自动回调下面的协议方法了
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;{
    
//    if ([self.delegate respondsToSelector:@selector(bleScanResDiscoverPeripheral:)]) {
//        [self.delegate bleScanResDiscoverPeripheral:peripheral];
//    }
    
    peripheral.delegate = self;

    NSLog(@"扫描中。。。。。。。。。。。");
}

- (void)setUpConnectPeripheral:(CBPeripheral *)peripheral
{

    peripheral.delegate = self;
    [_centralManager connectPeripheral:peripheral options:nil];
}


//如果连接成功，就会回调下面的协议方法了
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
   
//    if ([self.delegate respondsToSelector:@selector(connectSuccessCentralManager:didConnectPeripheral:)]) {
//        [self.delegate connectSuccessCentralManager:central didConnectPeripheral:peripheral];
//    }
    
    [peripheral discoverServices:nil];

}



//掉线
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
//    if ([self.delegate respondsToSelector:@selector(bleCentralManager:didDisconnectPeripheral:)]) {
//        [self.delegate bleCentralManager:central didDisconnectPeripheral:peripheral];
//    }

}

//连接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
{
//    if ([self.delegate respondsToSelector:@selector(bleCentralManager:didDisconnectPeripheral:)]) {
//        [self.delegate bleCentralManager:central didDisconnectPeripheral:peripheral];
//    }
}

//一旦我们读取到外设的相关服务UUID就会回调下面的方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;
{
    
//    if ([self.delegate respondsToSelector:@selector(bleDiscoverServicesPeripheral:)]) {
//        [self.delegate bleDiscoverServicesPeripheral:peripheral];
//    }

}
//如果我们成功读取某个特征值UUID，就会回调下面的方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;{
    for(int i=0; i < service.characteristics.count; i++) {
        
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        
        NSLog(@"特征 UUID: %@ (%@)", c.UUID.data, c.UUID);
        
        if ([[c UUID] isEqual:[CBUUID UUIDWithString:@"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"]]){
            
//            if ([self.delegate respondsToSelector:@selector(bleDidDiscoverCharacteristics:peripheral:type:)]) {
//                [self.delegate bleDidDiscoverCharacteristics:c peripheral:peripheral type:@"w"];
//            }
            _c = c;
        }
        
        //读取蓝牙4.0设备电量的特征值
        if ([[c UUID] isEqual:[CBUUID UUIDWithString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]]){
            
//            if ([self.delegate respondsToSelector:@selector(bleDidDiscoverCharacteristics:peripheral:type:)]) {
//                [self.delegate bleDidDiscoverCharacteristics:c peripheral:peripheral type:@"r"];
//            }
        }
    }
}
//向peripheral中写入数据后的回调函数
- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"write value success(写入成功) : %@---%@", characteristic,peripheral.identifier.UUIDString);
}
//获取外设发来的数据,不论是read和notify,获取数据都从这个方法中读取
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    [peripheral readRSSI];
    
    NSLog(@"%@",peripheral);

    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"6E400003-B5A3-F393-E0A9-E50E24DCCA9E"]]){
        NSData* data = characteristic.value;
        NSString* value = [self hexadecimalString:data];
        NSString* valueStr = [self stringFromHexString:value];
        if (valueStr) {
//            if ([self.delegate respondsToSelector:@selector(bleReadRes:)]) {
//                [self.delegate bleReadRes:valueStr];
//            }
//            if ([self.delegate respondsToSelector:@selector(bleReadRes:Peripheral:)]) {
//                [self.delegate bleReadRes:valueStr Peripheral:peripheral];
//            }
        }
    }
}



#pragma mark - tool

//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
}
//将传入的NSString类型转换成ASCII码并返回
- (NSData*)dataWithString:(NSString *)string{
    unsigned char *bytes = (unsigned char *)[string UTF8String];
    NSInteger len = string.length;
    return [NSData dataWithBytes:bytes length:len];
}

-(NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr] ;
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
//    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
    
}



@end
