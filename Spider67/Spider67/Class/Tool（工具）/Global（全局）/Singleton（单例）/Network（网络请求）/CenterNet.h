//
//  CenterNetManager.h
//  GuiZhouYiDong
//
//  Created by elco on 2018/4/27.
//  Copyright © 2018年 elco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CenterNet : NSObject

/// 全局访问点
+ (instancetype _Nullable )shared;

@property (nonatomic, copy) NSString* _Nullable token;


// 登录
- (void)netToLoginParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion;
// 测试
- (void)testSeaverIpWithIpStr:(nullable NSString *)ipStr;
// 设备查询
- (void)deviceCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable dataList))completion;
// 修改密码
- (void)ChangePasswordParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion;
// 设备验证
- (void)deviceVerifyParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success,NSDictionary* _Nullable dict))completion;
// 查询iothub实例
- (void)checkIoTHubCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable dataList))completion;
// 设备注册
- (void)deviceRegisterParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success,NSDictionary* _Nullable dict))completion;
// 群组查询
- (void)groupCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable  dataList))completion;
// 删除设备
- (void)deleteDeviceParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(BOOL success))completion;
// 设备详情
- (void)DeviceEditorParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSDictionary* _Nullable dict,BOOL success))completion;
// 完善群组
- (void)DeviceGroupParm:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion;
// 获取频道配置
- (void)ChannelConfigParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion;
// 频道写值
- (void)ChannelWriteValueParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName value:(NSString *_Nullable)value completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion;
// 保存频道配置
- (void)ChannelConfigSaveDeviceId:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName defineName:(NSString *_Nullable)defineName channelType:(NSString *_Nullable)channelType  completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion;
// 查询告警标签
- (void)checkWarnItemCompletionParm:(NSString *_Nullable)groupId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion;
// 配置告警
- (void)saveWarnItemCompletionParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(BOOL success))completion;
// 获取可用配置channel
- (void)linkageChannelCompletionParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion;
// 查询联动配置
- (void)checkLinkageChannelCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion;
// 保存联动配置
- (void)saveLinkageChannelCompletionParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(BOOL success))completion;
// 查询公式
- (void)checkFormulaCompletionParm:(NSString *_Nullable)groupId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion;
// 保存公式
- (void)saveFormulaCompletionParm:(NSDictionary *_Nullable)params deviceId:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(BOOL success))completion;
// 查询上报周期
- (void)checkReportPeriodCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSString * _Nullable  periodNumberStr))completion;
// 设置上报周期
- (void)saveReportPeriodCompletionParm:(NSString *_Nullable)deviceId value:(NSString *_Nonnull)value completion:(void (^ __nullable)(BOOL success))completion;
// 查询FATO
- (void)checkFotaCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion;
// 保存FATO
- (void)saveFotaCompletionParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion;
// 下发指令FATO
- (void)orderFotaCompletionParm:(NSString *_Nullable)deviceId  completion:(void (^ __nullable)(BOOL success))completion;
// 下发配置
- (void)sendConfigDeviceId:(NSString *_Nullable)deviceId hubId:(NSString *_Nullable)hubId completion:(void (^ __nullable)(BOOL success,NSString* _Nullable failStr))completion;
// 下发联动配置
- (void)sendLogicDeviceId:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(BOOL success,NSString* _Nullable failStr))completion;
// 报警日志
- (void)logAlarmParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion;
// 删除报警日志
- (void)delAlarmLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion;
// 操作日志
- (void)logSendParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion;
// 删除操作日志
- (void)delSendLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion;
// channel日志
- (void)logChannelParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion;
// 删除channel日志
- (void)delChannelLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion;
// 编辑日志
- (void)logEditorParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion;
// 删除编辑日志
- (void)delEditorLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion;

@end

