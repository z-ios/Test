//
//  LinkagePerformView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LinkagePerformView.h"
#import "LinkageChannelSelectView.h"
#import "LinkageChannelSelectModel.h"

@interface LinkagePerformView ()<UITextFieldDelegate,DevicePtc>

@property (nonatomic, strong) UILabel* performch_t_lb;
@property (nonatomic, strong) UILabel* performdz_t_lb;
@property (nonatomic, strong) UIButton* perform_tb_btn;
@property (nonatomic, strong) UIButton* perform_qf_btn;
@property (nonatomic, strong) UIImageView* perform_tb_btn_imgv;
@property (nonatomic, strong) UIImageView* perform_qf_btn_imgv;

@end
@implementation LinkagePerformView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.layer.shadowOpacity = 10;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    self.relationStr = @"";

    [self addSubview:self.performch_t_lb];
    [self addSubview:self.perform_tf];
    [self addSubview:self.performdz_t_lb];
    [self addSubview:self.perform_tb_btn];
    [self addSubview:self.perform_qf_btn];
    [self.perform_tb_btn addSubview:self.perform_tb_btn_imgv];
    [self.perform_qf_btn addSubview:self.perform_qf_btn_imgv];
    
}

- (void)setLinkageList:(NSArray *)linkageList
{
    _linkageList = linkageList;
    if (linkageList.count > 0) {
        
        self.perform_tf.text = linkageList[0][@"channel_out"];
        
        if ([linkageList[0][@"relation"] isEqualToString:@"="]) {
            [self select_tb_btn];
        }else{
            [self select_qf_btn];
        }
        
        
    }
}

- (void)perform_tb_btnClick
{
    [self select_tb_btn];
}

- (void)perform_qf_btnClick
{
    [self select_qf_btn];
}

- (void)select_tb_btn
{
    _perform_tb_btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _perform_tb_btn.layer.borderWidth = 1;
    _perform_tb_btn_imgv.hidden = NO;
    
    _perform_qf_btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _perform_qf_btn.layer.borderWidth = 0.5;
    _perform_qf_btn_imgv.hidden = YES;
    
    self.relationStr = @"=";
}

- (void)select_qf_btn
{
    _perform_qf_btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    _perform_qf_btn.layer.borderWidth = 1;
    _perform_qf_btn_imgv.hidden = NO;
    
    _perform_tb_btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    _perform_tb_btn.layer.borderWidth = 0.5;
    _perform_tb_btn_imgv.hidden = YES;
    
    self.relationStr = @"!=";
}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _perform_tf) {
        
        [CenterNet.shared linkageChannelCompletionParm:_dict[@"device_id"] channelName:_dict[@"channelname"] completion:^(NSArray * _Nullable dataList) {
            NSArray* modelList = [NSArray yy_modelArrayWithClass:[LinkageChannelSelectModel class] json:dataList];
            LinkageChannelSelectView* eview = [[LinkageChannelSelectView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 495)];
            eview.delegate = self;
            eview.modelDatas = modelList;
            NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
            nkView.contentView = eview;
            [nkView show];
        }];
        
        return NO;
    }
    return YES;
}

- (void)selectLinkageChannel:(NSString *)port channnelName:(NSString *)channnelName
{
    _perform_tf.text = channnelName;
}

#pragma mark -  lazy

- (UILabel *)performch_t_lb
{
    if (!_performch_t_lb) {
        _performch_t_lb = [UILabel z_frame:CGRectMake(20, 20, 200, 20)
                                      Text:NSLocalizedString(@"执行channel", nil)
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _performch_t_lb;
}

- (UITextField *)perform_tf
{
    if (!_perform_tf) {
        _perform_tf = [UITextField  z_frame:CGRectMake(self.performch_t_lb.x, self.performch_t_lb.bottom + 5, self.width - 40, 52)
                                    bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                               cornerRadius:6
                                borderWidth:0
                                borderColor:nil
                                       text:nil
                                   textFont:[UIFont systemFontOfSize:17]
                                  textColor:[UIColor colorWithHex:@"#121212"]
                                placeholder:NSLocalizedString(@"未设置", nil)
                            placeholderFont:nil
                           placeholderColor:nil
                                leftImgName:nil
                                leftImgSize:CGSizeZero
                               rightImgName:@"icon_arrow_dropdown"
                               rightImgSize:CGSizeMake(40, 24)
                       ];
        
        _perform_tf.delegate = self;
    }
    return _perform_tf;
}

- (UILabel *)performdz_t_lb
{
    if (!_performdz_t_lb) {
        _performdz_t_lb = [UILabel z_frame:CGRectMake(20, self.perform_tf.bottom + 15, 200, 20)
                                      Text:NSLocalizedString(@"执行动作", nil)
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _performdz_t_lb;
}

- (UIButton *)perform_tb_btn
{
    if (!_perform_tb_btn) {
        _perform_tb_btn = [UIButton z_frame:CGRectMake(20, self.performdz_t_lb.bottom + 5, (self.width - 40 - 15)*0.5, 64)
                                   fontSize:17
                               cornerRadius:4
                                borderWidth:0.5
                                borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                            backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                                 titleColor:[UIColor colorWithHex:@"#121212"]
                                      title:NSLocalizedString(@"同步", nil)
                                     isbold:NO
                                     Target:self
                                     action:@selector(perform_tb_btnClick)
                           ];
    }
    return _perform_tb_btn;
}

- (UIButton *)perform_qf_btn
{
    if (!_perform_qf_btn) {
        _perform_qf_btn = [UIButton z_frame:CGRectMake(self.perform_tb_btn.right + 15, self.performdz_t_lb.bottom + 5, (self.width - 40 - 15)*0.5, 64)
                                   fontSize:17
                               cornerRadius:4
                                borderWidth:0.5
                                borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                            backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                                 titleColor:[UIColor colorWithHex:@"#121212"]
                                      title:NSLocalizedString(@"取反", nil)
                                     isbold:NO
                                     Target:self
                                     action:@selector(perform_qf_btnClick)
                           ];

    }
    return _perform_qf_btn;
}

- (UIImageView *)perform_tb_btn_imgv
{
    if (!_perform_tb_btn_imgv) {
        _perform_tb_btn_imgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.perform_tb_btn.width - 18, 0, 18, 18)];
        _perform_tb_btn_imgv.hidden = YES;
        _perform_tb_btn_imgv.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    }
    return _perform_tb_btn_imgv;
}

- (UIImageView *)perform_qf_btn_imgv
{
    if (!_perform_qf_btn_imgv) {
        _perform_qf_btn_imgv = [[UIImageView alloc] initWithFrame:CGRectMake(self.perform_qf_btn.width - 18, 0, 18, 18)];
        _perform_qf_btn_imgv.hidden = YES;
        _perform_qf_btn_imgv.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
    }
    return _perform_qf_btn_imgv;
}


@end
