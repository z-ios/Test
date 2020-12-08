//
//  SingleScreenController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleScreenController.h"
#import "SingleAlarmScreenScrollView.h"

@interface SingleScreenController ()<DevicePtc>

@property (nonatomic, strong) SingleAlarmScreenScrollView* scrollV;
@property (nonatomic, strong) UIButton* dismissBtn;
@property (nonatomic, strong) UIButton* allResetBtn;

@end

@implementation SingleScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dismissBtn];
    [self.view addSubview:self.allResetBtn];
    [self.view addSubview:self.scrollV];
    self.scrollV.device_id = _device_id;
    self.scrollV.group_id = _group_id;
    self.scrollV.selDict = _selDict;
    
}

#pragma mark - 点击方法
- (void)dismissBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 全部重置
- (void)allResetBtnClick
{
    [self.scrollV allResetData];
}

- (void)screenDataAlarmArr:(NSArray *)alarmArr channelArr:(NSArray *)channelArr sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr
{
    if ([self.zdelegate respondsToSelector:@selector(screenDataAlarmArr:channelArr:sdateStr:edateStr:)]) {
        [self.zdelegate screenDataAlarmArr:alarmArr channelArr:channelArr sdateStr:sdateStr edateStr:edateStr];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy

- (UIButton *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_dismissBtn setImage:[SVGKImage imageNamed:@"icon_registor_close"].UIImage forState:UIControlStateNormal];
        [_dismissBtn addTarget:self action:@selector(dismissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}

- (UIButton *)allResetBtn
{
    if (!_allResetBtn) {
        _allResetBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 105, 0, 100, 36)];
        [_allResetBtn setTitle:NSLocalizedString(@"全部重置", nil) forState:UIControlStateNormal];
        [_allResetBtn setTitleColor:[UIColor colorWithHex:@"#4D8CEB"] forState:UIControlStateNormal];
        [_allResetBtn addTarget:self action:@selector(allResetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _allResetBtn.centerY = self.dismissBtn.centerY;
    }
    return _allResetBtn;
}

- (SingleAlarmScreenScrollView *)scrollV
{
    if (!_scrollV) {
        _scrollV = [[SingleAlarmScreenScrollView alloc] initWithFrame:CGRectMake(0, self.dismissBtn.bottom, self.view.width, self.view.height - self.dismissBtn.bottom )];
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.zdelegate = self;
    }
    
    return _scrollV;
}

@end
