//
//  ServerSetController.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ServerSetController.h"
#import "BzView.h"
#import "IPView.h"
#import "PortView.h"
#import "XieYiView.h"
#import "ServerListController.h"

@interface ServerSetController ()<ServerPtc>

@property (nonatomic, strong) BzView* bzV;
@property (nonatomic, strong) IPView* ipV;
@property (nonatomic, strong) PortView* portV;
@property (nonatomic, strong) XieYiView* xyV;

@end

@implementation ServerSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = NSLocalizedString(@"服务器指向", nil);
    
    UIBarButtonItem* leftItem = [UIBarButtonItem itemWithNormalIcon:@"icon_back_nav" highlightedIcon:nil target:self action:@selector(backToVc)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHex:@"#F9F9F9" alpha:0.94];
    [self setupUI];
}

- (void)backToVc
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI{
    
    //备注
    [self.view addSubview:self.bzV];
    
    // IP
    [self.view addSubview:self.ipV];
    
    // portV
    [self.view addSubview:self.portV];
    
    // 协议
    [self.view addSubview:self.xyV];
    
    
    
    // 测试服务器
    UIButton* testBtn = [UIButton z_frame:CGRectMake(SPW(16), _xyV.bottom + SPH(50), self.view.width - SPW(32), SPH(52))
                                 fontSize:SPFont(18)
                             cornerRadius:6
                          backgroundColor:[UIColor colorWithHex:@"#26C464" alpha:0.20]
                               titleColor:[UIColor colorWithHex:@"#26C464"]
                                    title:NSLocalizedString(@"测试服务器", nil)
                                   isbold:YES
                                   Target:self
                                   action:@selector(testBtnClick)
                         ];
    [self.view addSubview:testBtn];
    
    // 确定
    UIButton* sureBtn = [UIButton z_frame:CGRectMake(SPW(16), testBtn.bottom + SPH(10), self.view.width - SPW(32), SPH(52))
                                    fontSize:SPFont(18)
                                cornerRadius:6
                             backgroundColor:[UIColor colorWithHex:@"#26C464"]
                                  titleColor:[UIColor whiteColor]
                                       title:NSLocalizedString(@"确定", nil)
                                      isbold:YES
                                      Target:self
                                      action:@selector(sureBtnClick)
                            ];
    [self.view addSubview:sureBtn];
    
    // 默认值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self readValue];
         });
   
    
}

- (void)readValue
{
    NSDictionary* dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"readValue"];
    if (dict) {
        [self severListselectedData:dict];
    }else{
           NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
              dictM[@"devIp"] = @"60.29.126.12";
              dictM[@"devPort"] = @"5502";
              dictM[@"devTitle"] = @"默认IP";
              dictM[@"devpro"] = @"http";
              dictM[@"devType"] = @(0);
        [[NSUserDefaults standardUserDefaults] setObject:dictM.copy forKey:@"readValue"];
        [self severListselectedData:dictM.copy];
    }
}

- (void)testBtnClick
{
    NSString* ipStr;
    
    if (self.ipV.typeNum == 0) {
        if (self.ipV.tf1.text.length > 0 && self.ipV.tf2.text.length > 0 && self.ipV.tf3.text.length > 0 && self.ipV.tf4.text.length > 0 && self.portV.ptf.text.length > 0) {
            NSArray* arr = @[self.ipV.tf1.text,self.ipV.tf2.text,self.ipV.tf3.text,self.ipV.tf4.text];
            ipStr = [arr componentsJoinedByString:@"."];
            //               ipStr = [NSString stringWithFormat:@"%@:%@",ipStr,self.portV.ptf.text];
        }else{
            [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
            return;
        }
    }else{
        
        if (self.ipV.domainTf.text.length > 0) {
            ipStr = self.ipV.domainTf.text;
        }else{
            [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
            return;
        }
    }
    if (self.portV.ptf.text.length == 0) {
        [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
        return;
    }
    
    NSString* urlStr = [NSString stringWithFormat:@"%@://%@:%@",self.xyV.xyStr,ipStr,self.portV.ptf.text];
    
    [CenterNet.shared testSeaverIpWithIpStr:urlStr];
}
- (void)sureBtnClick
{
    NSString* ipStr;
    
    if (self.ipV.typeNum == 0) {
        if (self.ipV.tf1.text.length > 0 && self.ipV.tf2.text.length > 0 && self.ipV.tf3.text.length > 0 && self.ipV.tf4.text.length > 0 && self.portV.ptf.text.length > 0) {
            NSArray* arr = @[self.ipV.tf1.text,self.ipV.tf2.text,self.ipV.tf3.text,self.ipV.tf4.text];
            ipStr = [arr componentsJoinedByString:@"."];
            //               ipStr = [NSString stringWithFormat:@"%@:%@",ipStr,self.portV.ptf.text];
        }else{
            [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
            return;
        }
    }else{
        
        if (self.ipV.domainTf.text.length > 0) {
            ipStr = self.ipV.domainTf.text;
        }else{
            [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
            return;
        }
    }
    if (self.portV.ptf.text.length == 0) {
        [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:self.navigationController.view];
        return;
    }
    NSLog(@"%@",ipStr);
    
    // 存值
    NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverhistory"];
    NSMutableArray* arrM = [NSMutableArray array];
    [arrM addObjectsFromArray:arr];
    __block BOOL iscontent = NO;
    [arrM enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (([obj[@"devIp"] isEqualToString:ipStr] && [obj[@"devPort"] isEqualToString:self.portV.ptf.text])) {
            iscontent = YES;
        }
    }];
    if (iscontent == NO) {
        NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
        dictM[@"devIp"] = ipStr;
        dictM[@"devPort"] = self.portV.ptf.text;
        dictM[@"devTitle"] = self.bzV.beizhuTf.text;
        dictM[@"devpro"] = self.xyV.xyStr;
        dictM[@"devType"] = @(self.ipV.typeNum);
        [arrM insertObject:dictM atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:arrM.copy forKey:@"serverhistory"];
    }
    
    // 存默认值
    NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
    dictM[@"devIp"] = ipStr;
    dictM[@"devPort"] = self.portV.ptf.text;
    dictM[@"devTitle"] = self.bzV.beizhuTf.text;
    dictM[@"devpro"] = self.xyV.xyStr;
    dictM[@"devType"] = @(self.ipV.typeNum);
    [[NSUserDefaults standardUserDefaults] setObject:dictM.copy forKey:@"readValue"];
    
    NSString* urlStr = [NSString stringWithFormat:@"%@://%@:%@",self.xyV.xyStr,ipStr,self.portV.ptf.text];
    [[NSUserDefaults standardUserDefaults] setObject:urlStr forKey:@"serverIp"];
    [MBhud showText:@"设置成功" addView:self.navigationController.view];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 服务器列表
- (void)showServerList
{
    ServerListController* vc = [[ServerListController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 从列表选择数据
- (void)severListselectedData:(NSDictionary *)dict
{
    NSLog(@"%@",dict);
    self.bzV.beizhuTf.text = dict[@"devTitle"];
    self.portV.ptf.text = dict[@"devPort"];
    self.xyV.xyStr = dict[@"devpro"];
    self.ipV.typeNum = [dict[@"devType"] intValue];
    if ([dict[@"devType"] intValue] == 0) {
        NSString *string = dict[@"devIp"];
        NSArray  *array = [string componentsSeparatedByString:@"."];
        self.ipV.tf1.text = array[0];
        self.ipV.tf2.text = array[1];
        self.ipV.tf3.text = array[2];
        self.ipV.tf4.text = array[3];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.ipV.domainTf.text = dict[@"devIp"];
        });
    }
}

#pragma mark - lazy
- (BzView *)bzV
{
    if (!_bzV) {
        _bzV = [[BzView alloc] initWithFrame:CGRectMake(SPW(16), Height_NavBar + SPH(10), self.view.width - SPW(32), SPH(71))];
        _bzV.delegate = self;
    }

    return _bzV;
}

- (IPView *)ipV
{
    if (!_ipV) {
        _ipV = [[IPView alloc] initWithFrame:CGRectMake(SPW(16),self.bzV.bottom + SPH(10), self.view.width - SPW(32), SPH(104))];
        _ipV.delegate = self;
        
    }
    
    return _ipV;
}

- (PortView *)portV
{
    if (!_portV) {
        _portV = [[PortView alloc] initWithFrame:CGRectMake(SPW(16), self.ipV.bottom + SPH(20), self.view.width - SPW(32), SPH(71))];
        _portV.delegate = self;
      }

      return _portV;
}

- (XieYiView *)xyV
{
    if (!_xyV) {
        _xyV = [[XieYiView alloc] initWithFrame:CGRectMake(SPW(16), self.portV.bottom + SPH(20), self.view.width - SPW(32), SPH(90))];
    }

         return _xyV;
}

@end
