//
//  SendConfigController.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendConfigController.h"
#import "SendConfigTabView.h"
#import "SendSuccessView.h"

@interface SendConfigController ()

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) SendConfigTabView* tableView;
@property (nonatomic, strong) UIButton* sendBtn;
@property (nonatomic, copy) NSString* hubId;
@end

@implementation SendConfigController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = NSLocalizedString(@"下发配置", nil);
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.view addSubview:self.title_lb];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sendBtn];
    
    [CenterNet.shared DeviceEditorParm:_deviceId completion:^(NSDictionary *dict, BOOL success) {
        if (success) {
            self.tableView.datas = dict[@"modules"];
            self.hubId = dict[@"device"][@"hubid"];
            NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? [NSString stringWithFormat:@"共配置了%zd条",self.tableView.datas.count] : [NSString stringWithFormat:@"A total of %zd are configured",self.tableView.datas.count];
            self.title_lb.text = textStr;
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

- (void)sendBtnClick
{
    [self addActivityIndicator];
    [CenterNet.shared sendConfigDeviceId:_deviceId hubId:_hubId completion:^(BOOL success, NSString * _Nullable failStr) {
        [SendSuccessView showSuccess:success vc:self note:failStr completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

// 添加小菊花
- (void)addActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]init];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_sendBtn addSubview:activityIndicator];
    //设置小菊花的frame
    activityIndicator.frame= _sendBtn.bounds;
    //设置小菊花颜色
    activityIndicator.color = [UIColor whiteColor];
    //设置背景颜色
    activityIndicator.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    activityIndicator.hidesWhenStopped = true;
    //开始旋转
    [activityIndicator startAnimating];
}

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(16, Height_NavBar + 20, self.view.width - 32, 20)
                                     Text:@"共配置了4条"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#4D8CEB"]
                                   isbold:NO
                          ];
       }
       return _title_lb;
}

- (SendConfigTabView *)tableView
{
    if (!_tableView) {
        _tableView = _tableView = [[SendConfigTabView alloc] initWithFrame:CGRectMake(0, self.title_lb.bottom + 10, self.view.width, self.view.height - (self.title_lb.bottom + 10)) style:(UITableViewStyleGrouped)];
    }
    return _tableView;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton z_frame:CGRectMake(16, self.view.height - 44 - 50, self.view.width - 32, 50)
                            fontSize:18
                        cornerRadius:6
                     backgroundColor:[UIColor colorWithHex:@"#26C464"]
                          titleColor:[UIColor whiteColor]
                               title:NSLocalizedString(@"下发配置", nil)
                              isbold:YES
                              Target:self
                              action:@selector(sendBtnClick)
                    ];
    }
    return _sendBtn;
}

@end
