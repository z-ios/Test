//
//  CenterNetManager.m
//  GuiZhouYiDong
//
//  Created by elco on 2018/4/27.
//  Copyright © 2018年 elco. All rights reserved.
//

#import "CenterNet.h"
#import "NetManager.h"


#define BASEURL [[NSUserDefaults standardUserDefaults] objectForKey:@"serverIp"]
#define USERNAME [[NSUserDefaults standardUserDefaults] objectForKey:@"spd_username"]
#define PASSWORD [[NSUserDefaults standardUserDefaults] objectForKey:@"spd_pwd"]

// 登录
#define loginURL [NSString stringWithFormat:@"%@/api/login",BASEURL]
// 获取设备
#define deviceCheckURL [NSString stringWithFormat:@"%@/api/device/1/30",BASEURL]
// 修改密码
#define changPwdURL [NSString stringWithFormat:@"%@/api/user/pwd",BASEURL]
// 设备验证
#define verifyURL [NSString stringWithFormat:@"%@/api/device/verify",BASEURL]
// 查询iothub
#define checkiothubURL [NSString stringWithFormat:@"%@/api/group/hubconfig",BASEURL]
// 设备注册
#define registerDeviceURL [NSString stringWithFormat:@"%@/api/device",BASEURL]
// 群组查询
#define checkGroupURL [NSString stringWithFormat:@"%@/api/group/1/300",BASEURL]
// 删除设备
#define delDeviceURL [NSString stringWithFormat:@"%@/api/device",BASEURL]
// 设备详情
#define DeviceEditorURL [NSString stringWithFormat:@"%@/api/device/detail",BASEURL]
// 完善群组
#define groupURL [NSString stringWithFormat:@"%@/api/device",BASEURL]
// 频道配置
#define channelConfigURL [NSString stringWithFormat:@"%@/api/device/config",BASEURL]
// 获取告警标签
#define warnItemURL [NSString stringWithFormat:@"%@/api/group/alarmtag",BASEURL]
// 配置报警
#define savewarnURL [NSString stringWithFormat:@"%@/api/device/config/alarm",BASEURL]
// 可用配置channel
#define linkagechannelURL [NSString stringWithFormat:@"%@/api/device/config/logic",BASEURL]
// 公式
#define formulalURL [NSString stringWithFormat:@"%@/api/group/formula",BASEURL]
// 公式
#define saveFormulalURL [NSString stringWithFormat:@"%@/api/device/config/formula",BASEURL]
// 周期
#define ReportPeriodURL [NSString stringWithFormat:@"%@/api/device/interval",BASEURL]
// 查询FATO
#define FotaURL [NSString stringWithFormat:@"%@/api/device/fota",BASEURL]
// 发送配置
#define SendConfigURL [NSString stringWithFormat:@"%@/api/device/config/send",BASEURL]
// 下发联动
#define SendlogicURL [NSString stringWithFormat:@"%@/api/device/config/logic",BASEURL]
// 报警日志
#define logAlarmURL [NSString stringWithFormat:@"%@/api/log/alarm",BASEURL]
// 操作日志
#define logSendURL [NSString stringWithFormat:@"%@/api/log/operate",BASEURL]
// channel日志
#define logChannelURL [NSString stringWithFormat:@"%@/api/log/report",BASEURL]
// 编辑日志
#define logEditorURL [NSString stringWithFormat:@"%@/api/log/edit",BASEURL]

@implementation CenterNet

+ (instancetype)shared{
    
    static CenterNet *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    instance = [CenterNet new];

    });
    return  instance;
}

#pragma mark - 解析token
-(id)jwtDecodeWithJwtString:(NSString *)jwtStr {
    
    NSArray * segments = [jwtStr componentsSeparatedByString:@"."];
    NSString * base64String = [segments objectAtIndex:1];
    int requiredLength = (int)(4 *ceil((float)[base64String length]/4.0));
    int nbrPaddings = requiredLength - (int)[base64String length];
    if(nbrPaddings > 0){
        NSString * pading = [[NSString string] stringByPaddingToLength:nbrPaddings withString:@"=" startingAtIndex:0];
        base64String = [base64String stringByAppendingString:pading];
    }
    base64String = [base64String stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64String = [base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString * decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[decodeString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return jsonDict;
    
}

#pragma mark -  登录
- (void)netToLoginParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在登录..." : @"logging in...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    
    [NetManager.shared afnBodyNetUrl:loginURL method:@"POST" Body:param auth:nil success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSString *result =[[ NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@--%zd",result,statuCode);
        NSDictionary* dict = [self jwtDecodeWithJwtString:result];
        NSLog(@"%@",dict);
        CenterManager.shared.role_id = dict[@"role_id"];
        CenterManager.shared.realname = dict[@"realname"];
        CenterManager.shared.groupname = dict[@"groupname"];
        CenterManager.shared.telephone = dict[@"telephone"];
        CenterManager.shared.group_id = dict[@"group_id"];
        CenterManager.shared.user_id = dict[@"user_id"];
        
        self.token = result;
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"登录成功" : @"login successful";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
//        hud.completionBlock = ^{
//            completion(YES);
//        };
        completion(YES);
//        [self deviceVerify];
    } failure:^(NSError * _Nonnull error) {
        completion(NO);
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"登录失败" : @"Login failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:2];
    }];
    
    [UIView animateWithDuration:0 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
   
}

#pragma mark - 设备验证
- (void)deviceVerifyParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success,NSDictionary* _Nullable dict))completion
{
    [NetManager.shared NSURLSessionUrl:verifyURL method:@"POST" parameters:param auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
           
           if (statuCode == 400) {
               completion(NO,responseObject);
           }else{
               completion(YES,responseObject);
           }

       } failure:^(NSError * _Nonnull error) {
           NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"网络请求失败" : @"Network request failed";
           [MBhud showText:textStr addView:zAppWindow];
       }];
}

#pragma mark - 设备注册
- (void)deviceRegisterParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success,NSDictionary* _Nullable dict))completion
{
    [NetManager.shared NSURLSessionUrl:registerDeviceURL method:@"POST" parameters:param auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        
        if (statuCode == 400) {
            completion(NO,responseObject);
        }else{
            completion(YES,responseObject);
        }

    } failure:^(NSError * _Nonnull error) {
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"网络请求失败" : @"Network request failed";
        [MBhud showText:textStr addView:zAppWindow];
    }];
}

#pragma mark - 测试
- (void)testSeaverIpWithIpStr:(NSString *)ipStr
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在测试服务器..." : @"Testing server...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* urlStr = [NSString stringWithFormat:@"%@/api/health",ipStr];
    [NetManager.shared afnNetUrl:urlStr method:@"GET" parameters:nil auth:nil success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 200) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"测试成功" : @"testing successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"测试失败" : @"Test failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"测试失败" : @"Test failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];
}
#pragma mark - 设备查询
- (void)deviceCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable dataList))completion
{
    [NetManager.shared afnNetUrl:deviceCheckURL method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        
        NSDictionary *dicJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dicJson) {
            completion(YES,dicJson[@"data"]);
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"网络请求失败" : @"Network request failed";
        [MBhud showText:textStr addView:zAppWindow];
        completion(NO,@[]);
    }];
    
}

#pragma mark - 修改密码
- (void)ChangePasswordParam:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在修改密码..." : @"Changing password...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared afnBodyNetUrl:changPwdURL method:@"PATCH" Body:param auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"修改成功" : @"Successfully modified";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"修改失败" : @"fail to edit";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"修改失败" : @"fail to edit";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
    }];
}

#pragma mark - 查询iothub
- (void)checkIoTHubCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable dataList))completion
{
    NSString* url = [NSString stringWithFormat:@"%@/%@",checkiothubURL,CenterManager.shared.group_id];
    
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        
        NSArray *arrJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (arrJson.count > 0) {
            completion(YES,arrJson);
        }else{
            NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有iothub实例数据" : @"No iothub instance data";
            [MBhud showText:textStr addView:zAppWindow];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"网络请求失败" : @"Network request failed";
        [MBhud showText:textStr addView:zAppWindow];
        completion(NO,@[]);
    }];
}

#pragma mark - 群组查询
- (void)groupCheckDataCompletion:(void (^ __nullable)(BOOL success,NSArray * _Nullable  dataList))completion
{
    [NetManager.shared afnNetUrl:checkGroupURL method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSDictionary *dictJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray* arr = dictJson[@"data"];
             if (arr.count > 0) {
                 completion(YES,arr);
             }else{
                 NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有群组数据" : @"No group data";
                 [MBhud showText:textStr addView:zAppWindow];
             }
             
         } failure:^(NSError * _Nonnull error) {
             NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"网络请求失败" : @"Network request failed";
             [MBhud showText:textStr addView:zAppWindow];
             completion(NO,@[]);
         }];
}

#pragma mark - 删除设备
- (void)deleteDeviceParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(BOOL success))completion
{
    [NetManager.shared afnBodyNetUrl:delDeviceURL method:@"DELETE" Body: @[deviceId] auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除成功" : @"successfully deleted";
             [MBhud showText:textStr addView:zAppWindow];
            completion(YES);
        }else{
            NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
            [MBhud showText:textStr addView:zAppWindow];
            completion(NO);
        }
    } failure:^(NSError * _Nonnull error) {
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
        [MBhud showText:textStr addView:zAppWindow];
    }];
}

#pragma mark - 设备详情
- (void)DeviceEditorParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSDictionary* _Nullable dict,BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取数据..." : @"Fetching data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",DeviceEditorURL,deviceId];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSDictionary *dictJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dictJson) {
            NSDictionary* dict = [NSDictionary changeType:dictJson];
            completion(dict,YES);
            [MBhud.shared.hud hideAnimated:YES];
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            completion(@{},NO);
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        completion(@{},NO);
    }];
}

#pragma mark - 完善群组
- (void)DeviceGroupParm:(NSDictionary *_Nullable)param completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在提交信息..." : @"Submitting information...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared afnBodyNetUrl:groupURL method:@"PUT" Body:param auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"编辑成功" : @"Edit successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"编辑失败" : @"Edit failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            completion(NO);
        }
        
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"编辑失败" : @"Edit failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        completion(NO);
    }];
}

#pragma mark - 获取频道配置
- (void)ChannelConfigParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取数据..." : @"Fetching data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",channelConfigURL,deviceId,channelName];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSDictionary *dictJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dictJson) {
            [MBhud.shared.hud hideAnimated:YES];
            NSDictionary* nu_dict = [NSDictionary changeType:dictJson];
            completion(nu_dict);
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];
}

#pragma mark - 频道写值
- (void)ChannelWriteValueParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName value:(NSString *_Nullable)value completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在写入数据..." : @"Writing data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",channelConfigURL,deviceId,channelName];
    [NetManager.shared NSURLSessionUrl:url method:@"POST" parameters:@{@"value":value} auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据写入成功" : @"Data written successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }else{
            MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据写入失败" : @"Data writing failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];

}

#pragma mark - 保存频道配置
- (void)ChannelConfigSaveDeviceId:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName defineName:(NSString *_Nullable)defineName channelType:(NSString *_Nullable)channelType  completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在保存数据..." : @"Saving data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
       
       NSString* url = [NSString stringWithFormat:@"%@/%@/%@",channelConfigURL,deviceId,channelName];
    [NetManager.shared NSURLSessionUrl:url method:@"PUT" parameters:@{@"channelTitle":defineName,@"channelType":channelType} auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
           if (statuCode == 204) {
               
               MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"保存成功" : @"Saved successfully";
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
               completion(responseObject);
           }else{
               MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           }
       } failure:^(NSError * _Nonnull error) {
           
           MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据保存失败" : @"Failed to save data";
           [MBhud.shared.hud hideAnimated:YES afterDelay:1];
       }];
}

#pragma mark - 查询告警标签
- (void)checkWarnItemCompletionParm:(NSString *_Nullable)groupId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取告警数据..." : @"Getting alarm data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",warnItemURL,groupId];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSArray *arrJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (arrJson) {
            if (arrJson.count > 0) {
                completion(arrJson);
                [MBhud.shared.hud hideAnimated:YES];
            }else{
                
                MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有告警数据" : @"No warning data";
                [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            }
            
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
    }];
}

#pragma mark - 配置告警
- (void)saveWarnItemCompletionParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(BOOL success))completion
{
    
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在配置报警信息..." : @"Configuring alarm information...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    
    [NetManager.shared NSURLSessionUrl:savewarnURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
           if (statuCode == 204) {
               
               MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"配置成功" : @"Configuration is successful";
               [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
               completion(YES);
           }else{
               MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           }
       } failure:^(NSError * _Nonnull error) {
           MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"配置失败" : @"Configuration failed";
           [MBhud.shared.hud hideAnimated:YES afterDelay:1];
       }];
}

#pragma mark - 获取可用配置channel
- (void)linkageChannelCompletionParm:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取可用的输出频道..." : @"Getting available output channels...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",linkagechannelURL,deviceId,channelName];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSArray *arrJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (arrJson) {
            if (arrJson.count > 0) {
                completion(arrJson);
                [MBhud.shared.hud hideAnimated:YES];
            }else{
                
                MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有可用的输出频道" : @"No output channel available";
                [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            }
            
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
    }];
}

#pragma mark - 查询联动配置
- (void)checkLinkageChannelCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取联动配置数据..." : @"Obtaining linkage configuration data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",linkagechannelURL,deviceId];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSArray *arrJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (arrJson) {
            NSArray* nu_arr = [NSArray changeType:arrJson];
            completion(nu_arr);
            [MBhud.shared.hud hideAnimated:YES];
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
    }];
}

#pragma mark - 保存联动配置
- (void)saveLinkageChannelCompletionParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在配置联动信息..." : @"Configuring linkage information...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    
    [NetManager.shared NSURLSessionUrl:linkagechannelURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
           if (statuCode == 204) {
               
               MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"配置成功" : @"Configuration is successful";
               [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
               completion(YES);
           }else{
               MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           }
       } failure:^(NSError * _Nonnull error) {
           
           MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"配置失败" : @"Configuration failed";
           [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           
       }];
}

#pragma mark - 查询公式
- (void)checkFormulaCompletionParm:(NSString *_Nullable)groupId completion:(void (^ __nullable)(NSArray * _Nullable  dataList))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取公式数据..." : @"Fetching formula data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
       NSString* url = [NSString stringWithFormat:@"%@/%@",formulalURL,groupId];
       [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
           NSArray *arrJson=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           if (arrJson) {
               if (arrJson.count > 0) {
                   completion(arrJson);
                   [MBhud.shared.hud hideAnimated:YES];
               }else{
                   
                   MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有数据" : @"no data";
                   [MBhud.shared.hud hideAnimated:YES afterDelay:1];
               }
               
           }else{
               
               MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
               
           }
       } failure:^(NSError * _Nonnull error) {
           MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
           [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           
       }];
}

#pragma mark - 保存公式
- (void)saveFormulaCompletionParm:(NSDictionary *_Nullable)params deviceId:(NSString *_Nullable)deviceId channelName:(NSString *_Nullable)channelName completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在保存公式..." : @"Saving formula...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",saveFormulalURL,deviceId,channelName];
    [NetManager.shared NSURLSessionUrl:url method:@"PUT" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"保存成功" : @"Saved successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据保存失败" : @"Failed to save data";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];
}

#pragma mark - 查询上报周期
- (void)checkReportPeriodCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSString * _Nullable  periodNumberStr))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在查询上报周期..." : @"Querying the reporting period...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",ReportPeriodURL,deviceId];
    [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (jsonStr) {
            completion(jsonStr);
            [MBhud.shared.hud hideAnimated:YES];
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";;
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        
    }];
}

#pragma mark - 设置上报周期
- (void)saveReportPeriodCompletionParm:(NSString *_Nullable)deviceId value:(NSString *_Nonnull)value completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在设置上报周期..." : @"Setting escalation period...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@?interval=%@",ReportPeriodURL,deviceId,value];
    [NetManager.shared NSURLSessionUrl:url method:@"PATCH" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"设置成功" : @"Set successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"设置失败" : @"Setup failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];
    
}

#pragma mark - 查询FATO
- (void)checkFotaCompletionParm:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(NSDictionary* _Nullable dict))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取FATO数据..." : @"Fetching FATO data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
       NSString* url = [NSString stringWithFormat:@"%@/%@",FotaURL,deviceId];
       [NetManager.shared afnNetUrl:url method:@"GET" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           if (dic) {
               NSDictionary* fotaDict = [NSDictionary changeType:dic];
               completion(fotaDict);
               [MBhud.shared.hud hideAnimated:YES];
           }else{
               MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
               [MBhud.shared.hud hideAnimated:YES afterDelay:1];
               
           }
       } failure:^(NSError * _Nonnull error) {
           MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"获取失败" : @"Get failed";
           [MBhud.shared.hud hideAnimated:YES afterDelay:1];
           
       }];
}

#pragma mark - 保存FATO
- (void)saveFotaCompletionParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在保存设置..." : @"Saving settings...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared NSURLSessionUrl:FotaURL method:@"PUT" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"设置成功" : @"Set successfully";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"设置失败" : @"Setup failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];

}

#pragma mark - 下发指令FATO
- (void)orderFotaCompletionParm:(NSString *_Nullable)deviceId  completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在下发升级指令..." : @"Issuing upgrade instructions...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",FotaURL,deviceId];
    
    [NetManager.shared NSURLSessionUrl:url method:@"POST" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"下发成功" : @"Successfully issued";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
//            completion(YES);
        }else{
            MBhud.shared.hud.label.text = MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];;
            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"下发失败" : @"Delivery failed";
        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
    }];
    
}

#pragma mark - 下发配置
- (void)sendConfigDeviceId:(NSString *_Nullable)deviceId hubId:(NSString *_Nullable)hubId completion:(void (^ __nullable)(BOOL success,NSString* _Nullable failStr))completion
{
//    [MBhud.shared showHudText:@"正在下发配置..." addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",SendConfigURL,deviceId,hubId];
    [NetManager.shared NSURLSessionUrl:url method:@"POST" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
//            MBhud.shared.hud.label.text = @"下发成功";
//            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES,@"");
        }else{
//            MBhud.shared.hud.label.text = responseObject[@"message_cn"];
//            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            
            NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? responseObject[@"message_cn"] : responseObject[@"message_en"];
            completion(NO,textStr);
//
        }
    } failure:^(NSError * _Nonnull error) {
//        MBhud.shared.hud.label.text = @"下发失败";
//        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"请检测网络配置" : @"Please check the network configuration";
        completion(NO,textStr);
    }];

}

#pragma mark - 下发联动配置
- (void)sendLogicDeviceId:(NSString *_Nullable)deviceId completion:(void (^ __nullable)(BOOL success,NSString* _Nullable failStr))completion
{
//    [MBhud.shared showHudText:@"正在下发联动配置..." addView:zAppWindow];
    NSString* url = [NSString stringWithFormat:@"%@/%@",SendlogicURL,deviceId];
    [NetManager.shared NSURLSessionUrl:url method:@"POST" parameters:nil auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
//            MBhud.shared.hud.label.text = @"下发成功";
//            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES,@"");
        }else{
//            MBhud.shared.hud.label.text = responseObject[@"message_cn"];
//            [MBhud.shared.hud hideAnimated:YES afterDelay:1];
            completion(NO,responseObject[@"message_cn"]);
        }
    } failure:^(NSError * _Nonnull error) {
//        MBhud.shared.hud.label.text = @"下发失败";
//        [MBhud.shared.hud hideAnimated:YES afterDelay:1];
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"请检测网络配置" : @"Please check the network configuration";
        completion(NO,textStr);
    }];
}

#pragma mark - 报警日志
- (void)logAlarmParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion;
{
    [NetManager.shared NSURLSessionUrl:logAlarmURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 200) {
            NSDictionary* dict = responseObject;
            if ([dict[@"total"] integerValue] > 0) {
                completion(dict[@"data"],YES);
            }else{
                completion(@[],YES);
                NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有获取到数据" : @"No data";
                [MBhud showText:textStr addView:zAppWindow];
            }
        }else{
            [MBhud showText:responseObject[@"message_cn"] addView:zAppWindow];
            completion(@[],NO);
        }
    } failure:^(NSError * _Nonnull error) {
        completion(@[],NO);
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
        [MBhud showText:textStr addView:zAppWindow];
    }];
}

#pragma mark - 删除报警日志
- (void)delAlarmLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在删除..." : @"deleting...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared NSURLSessionUrl:logAlarmURL method:@"DELETE" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除成功" : @"successfully deleted";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
        [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
    }];
}

#pragma mark - 操作日志
- (void)logSendParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion
{
    [NetManager.shared NSURLSessionUrl:logSendURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 200) {
            NSDictionary* dict = responseObject;
            if ([dict[@"total"] integerValue] > 0) {
                completion(dict[@"data"],YES);
            }else{
                completion(@[],YES);
                NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有获取到数据" : @"No data";
                [MBhud showText:textStr addView:zAppWindow];
            }
        }else{
            [MBhud showText:responseObject[@"message_cn"] addView:zAppWindow];
            completion(@[],NO);
        }
    } failure:^(NSError * _Nonnull error) {
        completion(@[],NO);
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
        [MBhud showText:textStr addView:zAppWindow];
    }];
}
#pragma mark - 删除操作日志
- (void)delSendLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在删除..." : @"deleting...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared NSURLSessionUrl:logSendURL method:@"DELETE" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除成功" : @"successfully deleted";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
        [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
    }];
}

#pragma mark - channel日志
- (void)logChannelParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion
{
    [NetManager.shared NSURLSessionUrl:logChannelURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 200) {
            NSDictionary* dict = responseObject;
            if ([dict[@"total"] integerValue] > 0) {
                completion(dict[@"data"],YES);
            }else{
                completion(@[],YES);
                NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"没有获取到数据" : @"No data";
                [MBhud showText:textStr addView:zAppWindow];
            }
        }else{
            [MBhud showText:responseObject[@"message_cn"] addView:zAppWindow];
            completion(@[],NO);
        }
    } failure:^(NSError * _Nonnull error) {
        completion(@[],NO);
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"数据获取失败" : @"Data acquisition failed";
        [MBhud showText:textStr addView:zAppWindow];
    }];
}
#pragma mark - 删除channel日志
- (void)delChannelLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion
{
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在删除..." : @"deleting...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [NetManager.shared NSURLSessionUrl:logChannelURL method:@"DELETE" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除成功" : @"successfully deleted";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = @"删除失败";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = @"删除失败";
        [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
    }];
}

#pragma mark - 编辑日志
- (void)logEditorParm:(NSDictionary *_Nullable)params completion:(void (^ __nullable)(NSArray * _Nullable  dataList,BOOL success))completion
{
    [NetManager.shared NSURLSessionUrl:logEditorURL method:@"POST" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 200) {
            NSDictionary* dict = responseObject;
            if ([dict[@"total"] integerValue] > 0) {
                completion(dict[@"data"],YES);
            }else{
                completion(@[],YES);
                [MBhud showText:@"没有获取到数据" addView:zAppWindow];
            }
        }else{
            [MBhud showText:responseObject[@"message_cn"] addView:zAppWindow];
            completion(@[],NO);
        }
    } failure:^(NSError * _Nonnull error) {
        completion(@[],NO);
        [MBhud showText:@"数据获取失败" addView:zAppWindow];
    }];
}
#pragma mark - 删除编辑日志
- (void)delEditorLogParm:(NSDictionary *_Nullable)params  completion:(void (^ __nullable)(BOOL success))completion
{
    [MBhud.shared showHudText:@"正在删除..." addView:zAppWindow];
    [NetManager.shared NSURLSessionUrl:logEditorURL method:@"DELETE" parameters:params auth:self.token success:^(NSUInteger statuCode, id  _Nonnull responseObject) {
        if (statuCode == 204) {
            MBhud.shared.hud.label.text = @"删除成功";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
            completion(YES);
        }else{
            MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
            [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
        }
    } failure:^(NSError * _Nonnull error) {
        MBhud.shared.hud.label.text = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"删除失败" : @"failed to delete";
        [MBhud.shared.hud hideAnimated:YES afterDelay:0.5];
    }];
}

@end
