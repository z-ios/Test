//
//  RegisterController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/9.
//  Copyright © 2020 apple. All rights reserved.
//

#import "RegisterController.h"
#import "LZHStepProgressView.h"
#import "RegisterContentView.h"

@interface RegisterController ()

@property (nonatomic, strong) UITableView* tableView;
@property(nonatomic,strong) LZHStepProgressView * StepProgressTransverse ;
@property(nonatomic,strong) RegisterContentView* contentV;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    UILabel* titleLab = [UILabel z_frame:CGRectMake((self.view.width - SPW(100)) * 0.5, SPH(56), SPW(100), SPH(22)) Text:@"设备注册" fontSize:SPFont(17) color:[UIColor colorWithHex:@"#000000"] isbold:YES];
    [self.view addSubview:titleLab];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(16, 0, 36, 36)];
    btn.centerY = titleLab.centerY;
    [btn setImage:[SVGKImage imageNamed:@"icon_registor_close"].UIImage forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //横向
    _StepProgressTransverse = [[LZHStepProgressView alloc]initWithFrame:CGRectMake(SPW(27), btn.bottom + SPH(30), self.view.width-SPW(27)*2, 44) setDirection:YES setCount:6];
    [self.view addSubview:self.StepProgressTransverse];
    
    // 内容view
    
    [self.view addSubview:self.contentV];
    
    zWEAKSELF
    // 上一步
    self.contentV.stepBlock = ^{
        weakSelf.StepProgressTransverse.errorImageName = @"";
        [weakSelf.StepProgressTransverse lastStep];
        weakSelf.contentV.scrollIndex = weakSelf.StepProgressTransverse.TransverseRecordIndex;
    };
    // 下一步
    self.contentV.nextBlock = ^{
        [weakSelf.StepProgressTransverse nextStep];
        weakSelf.contentV.scrollIndex = weakSelf.StepProgressTransverse.TransverseRecordIndex;
    };
    
    self.contentV.cancelBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.contentV.checkFailBlock = ^{
        weakSelf.StepProgressTransverse.errorImageName = @"icon_dr_process_fail";
        [weakSelf.StepProgressTransverse changTransverseLinkViewAnimations];
        
    };
    
    self.contentV.resetIndexBlock = ^{
        weakSelf.StepProgressTransverse.TransverseRecordIndex = 0;
        weakSelf.contentV.scrollIndex = weakSelf.StepProgressTransverse.TransverseRecordIndex;
    };
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bleConnectAlert) name:@"bleConnectalert" object:nil];
    
    
}

- (void)bleConnectAlert
{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"系统蓝牙未开启", nil)
                                                                             message:NSLocalizedString(@"请开启蓝牙，否则无法进行[设备注册]，若蓝牙已授权，请检查【控制中心】蓝牙是否开启", nil)
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"设置", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [okAction setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
    [cancelAction setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)dismissBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - lazy

- (RegisterContentView *)contentV
{
    if (!_contentV) {
        _contentV = [[RegisterContentView alloc] initWithFrame:CGRectMake(0, _StepProgressTransverse.bottom + SPH(30), self.view.width, self.view.height -(_StepProgressTransverse.bottom + SPH(30)))];
    }
    
    return _contentV;
}

@end
