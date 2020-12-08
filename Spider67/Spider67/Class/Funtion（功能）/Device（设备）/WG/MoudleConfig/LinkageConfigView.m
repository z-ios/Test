//
//  LinkageConfigView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LinkageConfigView.h"
#import "ChannelWarnInfoView.h"
#import "LinkageTableView.h"
#import "LinkagePerformView.h"

@interface LinkageConfigView ()

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;
@property (nonatomic, strong) UIButton* sure_btn;

@property (nonatomic, strong) ChannelWarnInfoView* infoView;
@property (nonatomic, strong) LinkageTableView* tableView;
@property (nonatomic, strong) LinkagePerformView* performView;

@end
@implementation LinkageConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  whiteColor];
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.moreInfo_btn];
    [self addSubview:self.infoView];
    
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.infoView.pab_lb.text = _pabStr;
    self.infoView.channelType_lb.text = _moduletype;
    self.infoView.channnelName_lb.text = dict[@"channelname"];
    self.infoView.defineName_lb.text = dict[@"channeltitle"];
    
    if ([dict[@"channelname"] hasPrefix:@"module_0"]) {
        self.performView.dict = dict;
        self.performView.linkageList = dict[@"logic_in"];
        [self addSubview:self.performView];
        self.sure_btn.frame = CGRectMake(25, self.performView.bottom + 35,self.width - 50 , 52);
        self.sure_btn.tag = 101;
    }else{
        self.tableView.linkageList = dict[@"logic_out"];
        [self addSubview:self.tableView];
        self.sure_btn.tag = 102;
    }
    [self addSubview:self.sure_btn];
    
}

- (void)sure_btnClick:(UIButton *)btn
{
    if (self.performView.perform_tf.text.length == 0) {
        [MBhud showText:NSLocalizedString(@"请选择执行channel", nil) addView:zAppWindow];
        return;
    }
    if (self.performView.relationStr.length == 0) {
        [MBhud showText:NSLocalizedString(@"请选择执行动作", nil) addView:zAppWindow];
        return;
    }
    if (btn.tag == 101) {
        NSDictionary* dict = @{
            @"device_id": _dict[@"device_id"],
            @"channel_in": _dict[@"channelname"],
            @"relation": self.performView.relationStr,
            @"relationval": @0,
            @"channel_out": self.performView.perform_tf.text
        };
        [CenterNet.shared saveLinkageChannelCompletionParm:dict completion:^(BOOL success) {
            
        }];
    }else if (btn.tag == 102) {
        
    }
    [self dismissView];
}

- (void)cancelBtnClick
{
   [self dismissView];
}

- (void)moreInfo_btnClick
{
    [DescriptionMaskView showPageViewWithtype:SmallLinkage];
}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.x = zScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:NSLocalizedString(@"联动配置", nil) fontSize:SPFont(30) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_titleLb sizeToFit];
    }
    return _titleLb;
}

- (UIButton *)moreInfo_btn
{
    if (!_moreInfo_btn) {
        _moreInfo_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleLb.right + 15, 0, 24, 24)];
        [_moreInfo_btn setImage:[SVGKImage imageNamed:@"icon_confi_information"].UIImage forState:UIControlStateNormal];
        _moreInfo_btn.centerY = self.titleLb.centerY;
        [_moreInfo_btn addTarget:self action:@selector(moreInfo_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreInfo_btn;
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_back_big"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sure_btn
{
    if (!_sure_btn) {
        _sure_btn = [UIButton z_frame:CGRectMake(25, self.height - 49 - 52,self.width - 50 , 52)
                             fontSize:18
                         cornerRadius:6
                      backgroundColor:[UIColor colorWithHex:@"#26C464"]
                           titleColor:[UIColor colorWithHex:@"#FFFFFF"]
                                title:NSLocalizedString(@"确定", nil)
                               isbold:YES
                               Target:self
                               action:@selector(sure_btnClick:)
                     ];
    }

    return _sure_btn;
}

- (ChannelWarnInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[ChannelWarnInfoView alloc] initWithFrame:CGRectMake(25, self.titleLb.bottom + 25, self.width - 50, 133)];
    }
    
    return _infoView;
}


#pragma mark - 懒加载
- (LinkageTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[LinkageTableView alloc] initWithFrame:CGRectMake(25, self.infoView.bottom + 25, self.width - 50, self.height - (self.infoView.bottom + 25)) style:(UITableViewStylePlain)];
        
    }
    return _tableView;
}

- (LinkagePerformView *)performView
{
    if (!_performView) {
        _performView = [[LinkagePerformView alloc] initWithFrame:CGRectMake(25, self.infoView.bottom + 25, self.width - 50, 222)];
    }
    return _performView;
}


@end
