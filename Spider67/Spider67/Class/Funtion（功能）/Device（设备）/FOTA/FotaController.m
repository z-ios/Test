//
//  FotaController.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FotaController.h"
#import "FotaTopView.h"
#import "FotaBottomView.h"

@interface FotaController ()

@property (nonatomic, strong) FotaTopView* topView;
@property (nonatomic, strong) FotaBottomView* bottomView;
@property (nonatomic, strong) UIButton* btn;

@end

@implementation FotaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = NSLocalizedString(@"FOTA管理", nil);
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.btn];
    
    [CenterNet.shared checkFotaCompletionParm:_deviceId completion:^(NSDictionary * _Nullable dict) {
        self.topView.fotaDict = dict;
        self.bottomView.fotaDict = dict;
        self.bottomView.deviceId = self.deviceId;
        self.topView.deviceId = self.deviceId;
    }];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bottomView.y = self.topView.bottom + 15;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.bottomView.y = self.topView.bottom + 15;
    self.btn.y = self.bottomView.bottom + 35;
    
}

- (void)sureBtnClick
{
    [self.bottomView saveConfigDataCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
//    [CenterNet.shared saveReportPeriodCompletionParm:_deviceId value:_reportV.NumberStr completion:^(BOOL success) {
//        if (success) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
}

- (FotaTopView *)topView
{
    if (!_topView) {
        _topView = [[FotaTopView alloc] initWithFrame:CGRectMake(16, Height_NavBar + 20, self.view.width - 32, 196)];
    }
    
    return _topView;
}

- (FotaBottomView *)bottomView
{
    if (!_bottomView) {
//        CGFloat magH = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? 221 : 241;
        _bottomView = [[FotaBottomView alloc] initWithFrame:CGRectMake(16, self.topView.bottom + 15, self.view.width - 32, 241)];
    }
    return _bottomView;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton z_frame:CGRectMake(16, self.bottomView.bottom + 35, self.view.width - 32, 50)
                        fontSize:18
                    cornerRadius:6
                 backgroundColor:[UIColor colorWithHex:@"#26C464"]
                      titleColor:[UIColor whiteColor]
                           title:NSLocalizedString(@"保存", nil)
                          isbold:YES
                          Target:self
                          action:@selector(sureBtnClick)
                ];
    }
    return _btn;
}


@end
