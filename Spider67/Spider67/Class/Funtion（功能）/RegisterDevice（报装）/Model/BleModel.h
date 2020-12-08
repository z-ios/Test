//
//  BleModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BleModel : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* identifierString;
@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, copy) NSString *lineState;
@property (nonatomic, strong) CBPeripheral *peripheral;

@end

NS_ASSUME_NONNULL_END
