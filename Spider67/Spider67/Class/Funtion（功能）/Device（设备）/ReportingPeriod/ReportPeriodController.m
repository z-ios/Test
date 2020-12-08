//
//  ReportPeriodController.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ReportPeriodController.h"
#import "ReportPeriodView.h"

@interface ReportPeriodController ()

@property (nonatomic, strong) ReportPeriodView* reportV;
@property (nonatomic, strong) UIButton* btn;

@end

@implementation ReportPeriodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = NSLocalizedString(@"上报周期设置", nil);
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.view addSubview:self.reportV];
    [self.view addSubview:self.btn];

    [CenterNet.shared checkReportPeriodCompletionParm:_deviceId completion:^(NSString * _Nullable periodNumberStr) {
        if (periodNumberStr.length > 3) {
            NSString *str = [periodNumberStr substringToIndex:periodNumberStr.length - 3];
            self.reportV.NumberStr = str;
        }
       
    }];
    
}

- (void)sureBtnClick
{
    [CenterNet.shared saveReportPeriodCompletionParm:_deviceId value:[NSString stringWithFormat:@"%@000",_reportV.NumberStr] completion:^(BOOL success) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (ReportPeriodView *)reportV
{
    if (!_reportV) {
        _reportV = [[ReportPeriodView alloc] initWithFrame:CGRectMake(16, Height_NavBar + 20, self.view.width - 32, 214)];
        
    }
    return _reportV;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton z_frame:CGRectMake(16, self.reportV.bottom + 35, self.view.width - 32, 50)
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
