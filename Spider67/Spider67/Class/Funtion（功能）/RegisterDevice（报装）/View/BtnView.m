//
//  BtnView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BtnView.h"

@interface BtnView ()

@property (nonatomic, strong) UIButton* stepBtn;
@property (nonatomic, strong) UIButton* nextBtn;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, assign) NSInteger idx;

@end
@implementation BtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
//    self.backgroundColor = [UIColor redColor];
    
    
}

- (void)setTypeBtnStr:(NSString *)typeBtnStr
{
    _typeBtnStr = typeBtnStr;
    
    if ([typeBtnStr isEqualToString:@"一个按钮不可点击"]) {
        [self setOneNextBtn_off];
    } else if ([typeBtnStr isEqualToString:@"一个按钮可点击"]) {
        [self setOneNextBtn_on];
    }else if ([typeBtnStr isEqualToString:@"两个按钮不可点击"]) {
        [self setTwoNextBtn_off];
    }else if ([typeBtnStr isEqualToString:@"两个按钮可点击"]) {
        [self setTwoNextBtn_on];
    }else if ([typeBtnStr isEqualToString:@"两个按钮等待"]) {
        [self setTwoNextBtn_wait];
    }else if ([typeBtnStr isEqualToString:@"取消验证"]) {
        [self setTwoNextBtn_cancel];
    }else if ([typeBtnStr isEqualToString:@"取消注册"]) {
        [self setTwoNextBtn_cancelregister];
    }else if ([typeBtnStr isEqualToString:@"完成注册"]) {
        [self setOneNextBtn_finish];
    }else if ([typeBtnStr isEqualToString:@"两个按钮都不可点击"]) {
        [self setTwoNextBtn_alloff];
    }
    

    
}



- (void)setOneNextBtn_off
{
    [self addSubview:self.nextBtn];
    _nextBtn.enabled = NO;
    _nextBtn.backgroundColor = [UIColor colorWithHex:@"#E5E5E5"];
    [_nextBtn setTitleColor:[UIColor colorWithHex:@"#B5B5B5"] forState:UIControlStateNormal];
    _nextBtn.frame = self.bounds;
}

- (void)setOneNextBtn_on
{
    _nextBtn.enabled = YES;
    _nextBtn.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.frame = self.bounds;
}

- (void)setOneNextBtn_finish
{
    _nextBtn.enabled = YES;
    _nextBtn.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.frame = self.bounds;
    [self.nextBtn setTitle:NSLocalizedString(@"完成注册", nil) forState:UIControlStateNormal];
    self.stepBtn.hidden = YES;
}

- (void)setTwoNextBtn_off
{
    
    [self addSubview:self.stepBtn];
    [self addSubview:self.nextBtn];
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.enabled = NO;
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#E5E5E5"];
    [self.nextBtn setTitleColor:[UIColor colorWithHex:@"#B5B5B5"] forState:UIControlStateNormal];
    [self.nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.activityIndicator.hidden = YES;
    self.stepBtn.backgroundColor = [UIColor colorWithHex:@"#E0F5E8"];
    [self.stepBtn setTitleColor:[UIColor colorWithHex:@"#26C464"] forState:UIControlStateNormal];

}

- (void)setTwoNextBtn_alloff
{
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.enabled = NO;
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#E5E5E5"];
    [self.nextBtn setTitleColor:[UIColor colorWithHex:@"#B5B5B5"] forState:UIControlStateNormal];
    [self.nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.activityIndicator.hidden = YES;
    self.stepBtn.backgroundColor = [UIColor colorWithHex:@"#E5E5E5"];
    [self.stepBtn setTitleColor:[UIColor colorWithHex:@"#B5B5B5"] forState:UIControlStateNormal];
}

- (void)setTwoNextBtn_on
{
    [self.timer invalidate];
    [self addSubview:self.stepBtn];
    [self addSubview:self.nextBtn];
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.enabled = YES;
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    self.stepBtn.backgroundColor = [UIColor colorWithHex:@"#E0F5E8"];
    [self.stepBtn setTitleColor:[UIColor colorWithHex:@"#26C464"] forState:UIControlStateNormal];
    
    self.activityIndicator.hidden = YES;
}

- (void)setTwoNextBtn_wait
{
    
//    [self addSubview:self.stepBtn];
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn addSubview:self.activityIndicator];
    self.nextBtn.imageView.backgroundColor = [UIColor redColor];
    self.activityIndicator.frame = self.nextBtn.imageView.frame;
    [self.nextBtn setTitle:@"  0s" forState:UIControlStateNormal];
    self.nextBtn.enabled = NO;
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
           target:self
         selector:@selector(mainThreadTimerDidFire:)
         userInfo:nil
          repeats:YES
    dispatchQueue:dispatch_get_main_queue()];
    _idx = 0;

}

- (void)setTwoNextBtn_cancel
{
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.enabled = YES;
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#F1544F" alpha:0.16];
    [self.nextBtn setTitleColor:[UIColor colorWithHex:@"#F1544F"] forState:UIControlStateNormal];
    [self.nextBtn setTitle:NSLocalizedString(@"取消注册", nil) forState:UIControlStateNormal];
    self.activityIndicator.hidden = YES;
    
}

- (void)setTwoNextBtn_cancelregister
{
    self.nextBtn.frame = CGRectMake(self.stepBtn.right + 10, 0, self.width - 120 - 10, self.height);
    self.nextBtn.enabled = YES;
    self.nextBtn.backgroundColor = [UIColor colorWithHex:@"#F1544F"];
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn setTitle:NSLocalizedString(@"取消注册", nil) forState:UIControlStateNormal];
    self.activityIndicator.hidden = YES;
}

#pragma mark - MSWeakTimerDelegate

- (void)mainThreadTimerDidFire:(MSWeakTimer *)timer
{
  [self.nextBtn setTitle:[NSString stringWithFormat:@"  %zds",_idx++] forState:UIControlStateNormal];
    if (_idx == 11) {
        [timer invalidate];
        [self setTwoNextBtn_on];
        MBhud.shared.hud.label.text = NSLocalizedString(@"命令发送超时，请重试...", nil);
        [MBhud.shared.hud hideAnimated:YES afterDelay:2];
    }
}

#pragma mark - Click
- (void)oneNextBtnClick:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"取消注册", nil)] || [btn.titleLabel.text isEqualToString:NSLocalizedString(@"完成注册", nil)]) {
        if ([self.delegate respondsToSelector:@selector(cancelClick)]) {
            [self.delegate cancelClick];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(nextClick)]) {
            [self.delegate nextClick];
        }
    }
}

- (void)bfBtnClick
{
    if ([self.delegate respondsToSelector:@selector(stepClick)]) {
        [self.delegate stepClick];
    }
}

#pragma mark - lazy
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton z_frame:self.bounds fontSize:SPFont(18) cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#E5E5E5"] titleColor:[UIColor colorWithHex:@"#B5B5B5"] title:NSLocalizedString(@"下一步", nil) isbold:YES Target:self action:@selector(oneNextBtnClick:)];
           _nextBtn.enabled = NO;
    }
    return _nextBtn;
}

- (UIButton *)stepBtn
{
    if (!_stepBtn) {
        _stepBtn = [UIButton z_frame:CGRectMake(0, 0, 120, self.height) fontSize:SPFont(18) cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#E0F5E8"] titleColor:[UIColor colorWithHex:@"#26C464"] title:NSLocalizedString(@"上一步", nil) isbold:YES Target:self action:@selector(bfBtnClick)];
    }
    
    return _stepBtn;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        [_activityIndicator startAnimating];
    }
    
    return _activityIndicator;
}

@end
