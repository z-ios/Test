//
//  EditPropertiesCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "EditPropertiesCollectionViewCell.h"
#import "BtnView.h"
#import "TestIoTHubView.h"

@interface EditPropertiesCollectionViewCell ()<UITextFieldDelegate,LDYSelectivityAlertViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, strong) TestIoTHubView* iothubView;
@property (nonatomic, strong) UITextField* groupTf;
@property (nonatomic, strong) NSMutableDictionary* edict;
@property (nonatomic, strong) UITextField* deviceNameTf;
@property (nonatomic, strong) NSMutableArray* groupList;

@end
@implementation EditPropertiesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
//        self.backgroundColor = [UIColor redColor];
//        [self setupUI];
    }
    return self;
}

- (NSMutableDictionary *)edict
{
    if (!_edict) {
        _edict = [NSMutableDictionary dictionary];
        _edict[@"groupId"] = @"00000000-0000-0000-0000-000000000000";
    }
    return _edict;
}

- (NSMutableArray *)groupList
{
    if (!_groupList) {
        _groupList = [NSMutableArray array];
    }
    return _groupList;
}

#pragma mark - 页面显示触发代理方法
- (void)collectViewCellWillAppearDictData:(NSDictionary *)dictData
{
    [self setupUI];
    _iothubView.biaoshiLb.text = dictData[@"biaoshimaStr"];
    _iothubView.xinghaoLb.text = dictData[@"xinghaoStr"];
    _iothubView.iothubLb.text = dictData[@"iotHubName"];
    _iothubView.iothubsubLb.text = dictData[@"iothubIp"];
    _iothubView.thingidLb.text = dictData[@"thingId"];

    _btnV.typeBtnStr = @"两个按钮可点击";
    [self.edict addEntriesFromDictionary:dictData] ;
 
}

- (void)setupUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.scrollView];
    if (IS_IPHONE_Xx) {
           self.scrollView.contentSize = CGSizeMake(0, SPH(800));
       }else{
           self.scrollView.contentSize = CGSizeMake(0, SPH(950));
       }
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(25, SPH(30), self.width - 32, SPH(33)) Text:NSLocalizedString(@"编辑属性", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    [titleLb sizeToFit];
    [self.scrollView addSubview:titleLb];
    
    UILabel* subtitleLb = [UILabel z_frame:CGRectMake(25, titleLb.bottom + SPH(8), self.width - 32, SPH(20)) Text:NSLocalizedString(@"注：此两项均为选填项目", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [subtitleLb sizeToFit];
    [self.scrollView addSubview:subtitleLb];
    
    UILabel* groupLb = [UILabel z_frame:CGRectMake(25, subtitleLb.bottom + SPH(22), self.width - 32, SPH(20)) Text:NSLocalizedString(@"所属群组", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self.scrollView addSubview:groupLb];
    
    _groupTf = [UITextField  z_frame:CGRectMake(25, groupLb.bottom + 3, self.width - 50, 48)
                                         bgColor:nil
                                    cornerRadius:0
                                     borderWidth:0
                                     borderColor:nil
                                            text:nil
                                        textFont:[UIFont systemFontOfSize:17]
                                       textColor:[UIColor colorWithHex:@"#121212"]
                                     placeholder:nil
                                 placeholderFont:nil
                                placeholderColor:nil
                                     leftImgName:nil
                                     leftImgSize:CGSizeZero
                                    rightImgName:@"icon_arrow_dropdown"
                                    rightImgSize:CGSizeMake(40, 24)
                            ];
    _groupTf.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_groupTf];
    _groupTf.delegate = self;
    if ([CenterManager.shared.role_id integerValue] == 1) {
        _groupTf.text = NSLocalizedString(@"未分组", nil);
    }else{
        _groupTf.text = CenterManager.shared.groupname;
    }
    
    UILabel* deviceNameLb = [UILabel z_frame:CGRectMake(25, _groupTf.bottom + SPH(10), self.width - 32, SPH(20)) Text:NSLocalizedString(@"设备名称", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self.scrollView addSubview:deviceNameLb];
    
    _deviceNameTf = [[UITextField alloc] initWithFrame:CGRectMake(25, deviceNameLb.bottom + 3, self.width - 50, 48)];
    _deviceNameTf.borderStyle = UITextBorderStyleRoundedRect;
    [self.scrollView addSubview:_deviceNameTf];
    
    UILabel* lineLb = [[UILabel alloc] initWithFrame:CGRectMake(35, _deviceNameTf.bottom + 25, self.width - 70, 1)];
    lineLb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [self.scrollView addSubview:lineLb];
    
    _iothubView = [[TestIoTHubView alloc] initWithFrame:CGRectMake(25, lineLb.bottom + 25, self.width - 50, 370)];
    [self.scrollView addSubview:_iothubView];
    
    [self addSubview:self.btnV];
    
}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _groupTf) {
        
        if ([CenterManager.shared.role_id integerValue] == 1) {
            // 选择群组
            [CenterNet.shared groupCheckDataCompletion:^(BOOL success, NSArray * _Nullable dataList) {
                [self.groupList removeAllObjects];
                [self.groupList addObjectsFromArray:dataList];
                [self.groupList addObject:@{@"groupname":@"未分组",@"id":@"00000000-0000-0000-0000-000000000000"}];
                NSMutableArray* arrM = [NSMutableArray array];
                [self.groupList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    [arrM addObject:dict[@"groupname"]];
                }];
                [self selectdatatitle:@"选择群组" datas:arrM.copy];
            }];
        }else{
            [MBhud showText:@"不可选择群组" addView:zAppWindow];
        }
        
        return NO;
    }
    return YES;
}

#pragma mark - 选择群组的代理方法
-  (void)selectdatatitle:(NSString *)title datas:(NSArray *)datas
{
    LDYSelectivityAlertView *ldySAV = [[LDYSelectivityAlertView alloc]initWithTitle:title datas:datas ifSupportMultiple:NO];
    ldySAV.delegate = self;
    [ldySAV show];
}
- (void)singleChoiceBlockData:(NSString *)data
{
    
    [self.groupList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dict[@"groupname"] isEqualToString:data]) {
            self.edict[@"groupId"] = dict[@"id"];
            self.groupTf.text = dict[@"groupname"];
        }
    }];
}
#pragma mark - 注册设备
- (void)registerDevice
{
    NSString* wifiMac = @"";
    NSString* imei = @"";
    if ([_edict[@"xinghaoStr"] isEqualToString:@"SPMB-16DIO-002"]) {
        wifiMac = _edict[@"biaoshimaStr"];
    }else{
        imei = _edict[@"biaoshimaStr"];;
    }

    NSDictionary* dict = @{
        @"group_id": _edict[@"groupId"],
      @"imei": imei,
      @"wifiMac": wifiMac,
        @"devicename": _deviceNameTf.text,
      @"hub_instancename": _edict[@"iotHubName"],
      @"hub_version": _edict[@"version"],
      @"hub_protocol": _edict[@"protocol"],
      @"hub_domain": _edict[@"iothubIp"],
      @"hub_mqttport": @([_edict[@"iothubPort"] integerValue]),
      @"hub_apiprefix": @"",
      @"hub_username": _edict[@"username"],
      @"hub_password": _edict[@"password"],
      @"remarks": @""
    };
    
    [CenterNet.shared deviceRegisterParam:dict completion:^(BOOL success, NSDictionary *dict) {
        
        NSString *registerId = @"";
        if (success) {// 注册成功
            
            NSString* rrr = dict[@"message_cn"];
            NSArray *array = [rrr componentsSeparatedByString:@","];
            NSString* ddd = array[0];
            registerId = [ddd substringFromIndex:12];
            
        }else{// 注册失败
            
        }
        
        if ([self.delegate respondsToSelector:@selector(deviceName:groupName:registerId:note:)]) {
            [self.delegate deviceName:self.deviceNameTf.text groupName:self.groupTf.text registerId:registerId note:dict];
        }
        if ([self.delegate respondsToSelector:@selector(nextClick)]) {
            [self.delegate nextClick];
        }
        
    }];

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
    [self registerDevice];
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


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}


@end
