//
//  SingleEditorLogScreenController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleEditorLogScreenController.h"
#import "SingSelDateView.h"

@interface SingleEditorLogScreenController ()

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UIButton* dismissBtn;
@property (nonatomic, strong) UIButton* allResetBtn;
@property (nonatomic, strong) SingSelDateView* dateView;
@property (nonatomic, strong) UITextField* username_tf;
@property (nonatomic, strong) UIButton* sureBtn;

@end

@implementation SingleEditorLogScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dismissBtn];
    [self.view addSubview:self.allResetBtn];
    [self.view addSubview:self.title_lb];
    [self.view addSubview:self.username_tf];
    [self.view addSubview:self.dateView];
    [self.view addSubview:self.sureBtn];
    
    self.dateView.edate_tf.text = _selDict[@"edateStr"];
    self.dateView.sdate_tf.text = _selDict[@"sdateStr"];
    self.username_tf.text = _selDict[@"userName"];
}

#pragma mark - 点击方法
- (void)dismissBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureBtnClick
{
    if ([self.zdelegate respondsToSelector:@selector(screenDataEditor:sdateStr:edateStr:)]) {
        [self.zdelegate screenDataEditor:self.username_tf.text sdateStr:self.dateView.sdate_tf.text edateStr:self.dateView.edate_tf.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 全部重置
- (void)allResetBtnClick
{
    self.dateView.edate_tf.text = @"";
    self.dateView.sdate_tf.text = @"";
    self.username_tf.text = @"";
}

- (void)screenDataSendArr:(NSArray *)sendArr sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr
{
    if ([self.zdelegate respondsToSelector:@selector(screenDataSendArr:sdateStr:edateStr:)]) {
        [self.zdelegate screenDataSendArr:sendArr sdateStr:sdateStr edateStr:edateStr];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazy

- (UITextField *)username_tf
{
    if (!_username_tf) {
        _username_tf = [[UITextField alloc] initWithFrame:CGRectMake(25, self.title_lb.bottom + 30, self.view.width - 50, 54)];
        _username_tf.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _username_tf.layer.cornerRadius = 6;
        _username_tf.placeholder = NSLocalizedString(@"请输入编辑人姓名", nil);
    }
    return _username_tf;
}


- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(25, self.dismissBtn.bottom + 25, 100, 48) Text:NSLocalizedString(@"筛选", nil) fontSize:34 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _title_lb;
}


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


- (SingSelDateView *)dateView
{
    if (!_dateView) {
        _dateView = [[SingSelDateView alloc] initWithFrame:CGRectMake(25, self.username_tf.bottom + 15, self.view.width - 50, 77)];
        _dateView.backgroundColor = [UIColor whiteColor];
    }
    return _dateView;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(16, self.dateView.bottom + 30, self.view.width - 32, 50) fontSize:18 cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#26C464"] titleColor:[UIColor whiteColor] title:NSLocalizedString(@"确定", nil) isbold:YES Target:self action:@selector(sureBtnClick)];
    }
    return _sureBtn;
}



@end
