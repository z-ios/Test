//
//  SingleChannelLogCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/26.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleChannelLogCell.h"
#import "SingleChannelLogModel.h"

@interface SingleChannelLogCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UILabel* port_lb;
@property (nonatomic, strong) UILabel* channelTitle_lb;
@property (nonatomic, strong) UILabel* channeName_lb;
@property (nonatomic, strong) UILabel* date_lb;
@property (nonatomic, strong) UIView* iotView;
@property (nonatomic, strong) UIView* zdView;
@property (nonatomic, strong) UIView* hsView;
@property (nonatomic, strong) UILabel* iot_tl_lb;
@property (nonatomic, strong) UILabel* iot_lb;
@property (nonatomic, strong) UILabel* zd_tl_lb;
@property (nonatomic, strong) UILabel* zd_lb;
@property (nonatomic, strong) UILabel* hs_tl_lb;
@property (nonatomic, strong) UILabel* hs_lb;

@end
@implementation SingleChannelLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 175;
        self.width = zScreenWidth;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(SingleChannelLogModel *)model
{
    _model = model;
    
    self.maskView.x = model.bgWith;
    _port_lb.text = model.port;
    _channelTitle_lb.text = model.channelTitle;
    _channeName_lb.text = model.channelName;
    _date_lb.text = [NSObject getTimeStrWithString:model.logTime];
    
    _iot_lb.text = model.originalVal;
    _zd_lb.text = model.readVal;
    _hs_lb.text = model.calculatedVal;
    
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self addSubview:self.maskView];

    [self.maskView addSubview:self.port_lb];
    [self.maskView addSubview:self.channelTitle_lb];
    [self.maskView addSubview:self.channeName_lb];
    [self.maskView addSubview:self.date_lb];
    
    [self.maskView addSubview:self.iotView];
    [self.iotView addSubview:self.iot_tl_lb];
    [self.iotView addSubview:self.iot_lb];
    
    [self.maskView addSubview:self.zdView];
    [self.zdView addSubview:self.zd_tl_lb];
    [self.zdView addSubview:self.zd_lb];
    
    [self.maskView addSubview:self.hsView];
    [self.hsView addSubview:self.hs_tl_lb];
    [self.hsView addSubview:self.hs_lb];

    
}

-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"icon_checkbox_highlight"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"icon_checkbox_default"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}


//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"icon_checkbox_default"];
                    }
                }
            }
        }
    }
}


#pragma lazy

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(16, 5, self.width - 32, self.height - 10)];
        _maskView.layer.cornerRadius = 16;
        _maskView.backgroundColor = [UIColor whiteColor];
        _maskView.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.08].CGColor;
        _maskView.layer.shadowOffset = CGSizeMake(0,0);
        _maskView.layer.shadowRadius = 12.f;
  
    }
    
    return _maskView;
}

- (UILabel *)port_lb
{
    if (!_port_lb) {
        _port_lb = [UILabel z_frame:CGRectMake(20, 15, 50, 24)
                               Text:@"P0 A"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _port_lb;
}

- (UILabel *)channelTitle_lb
{
    if (!_channelTitle_lb) {
        _channelTitle_lb = [UILabel z_frame:CGRectMake(self.maskView.width * 0.5 - 16, 0, self.maskView.width*0.5, 20)
                                       Text:@"一号水池液位检测"
                                   fontSize:14
                                      color:[UIColor colorWithHex:@"#808080"]
                                     isbold:NO
                            ];
        _channelTitle_lb.centerY = self.port_lb.centerY;
        _channelTitle_lb.textAlignment = NSTextAlignmentRight;
    }
    return _channelTitle_lb;
}

- (UILabel *)channeName_lb
{
    if (!_channeName_lb) {
        _channeName_lb = [UILabel z_frame:CGRectMake(20, self.port_lb.bottom + 8, 140, 20)
                                     Text:@"module_2 channel_0"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#808080"]
                                   isbold:NO
                          ];
    }
    return _channeName_lb;
}

- (UILabel *)date_lb
{
    if (!_date_lb) {
        _date_lb = [UILabel z_frame:CGRectMake(self.maskView.width * 0.5 - 16, self.port_lb.bottom + 8, self.maskView.width * 0.5, 20)
                               Text:@"2020-12-12 12:12:12"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
        _date_lb.textAlignment = NSTextAlignmentRight;
    }
    return _date_lb;
}

- (UIView *)iotView
{
    if (!_iotView) {
        _iotView = [[UIView alloc] initWithFrame:CGRectMake(20, self.channeName_lb.bottom + 15, (self.maskView.width - 60)/3, 63)];
        _iotView.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        _iotView.layer.cornerRadius = 4;
    }
    
    return _iotView;
}

- (UILabel *)iot_tl_lb
{
    if (!_iot_tl_lb) {
        _iot_tl_lb = [UILabel z_frame:CGRectMake(10, 10, self.iotView.width - 10, 20)
                                 Text:NSLocalizedString(@"IoTHub数值", nil)
                             fontSize:14
                                color:[UIColor whiteColor]
                               isbold:NO
                      ];
    }
    return _iot_tl_lb;
}

- (UILabel *)iot_lb
{
    if (!_iot_lb) {
        _iot_lb = [UILabel z_frame:CGRectMake(10, self.iot_tl_lb.bottom + 2, self.iotView.width - 10, 21)
                                 Text:@"435345"
                             fontSize:18
                                color:[UIColor whiteColor]
                               isbold:YES
                      ];
    }
    return _iot_lb;
}

- (UIView *)zdView
{
    if (!_zdView) {
        _zdView = [[UIView alloc] initWithFrame:CGRectMake(self.iotView.right + 10, self.channeName_lb.bottom + 15, (self.maskView.width - 60)/3, 63)];
        _zdView.backgroundColor = [UIColor colorWithHex:@"#4D8CEB"];
        _zdView.layer.cornerRadius = 4;
    }
    
    return _zdView;
}

- (UILabel *)zd_tl_lb
{
    if (!_zd_tl_lb) {
        _zd_tl_lb = [UILabel z_frame:CGRectMake(10, 10, self.zdView.width - 10, 20)
                                 Text:NSLocalizedString(@"终端数值", nil)
                             fontSize:14
                                color:[UIColor whiteColor]
                               isbold:NO
                      ];
    }
    return _zd_tl_lb;
}

- (UILabel *)zd_lb
{
    if (!_zd_lb) {
        _zd_lb = [UILabel z_frame:CGRectMake(10, self.zd_tl_lb.bottom + 2, self.zdView.width - 10, 21)
                                 Text:@"340"
                             fontSize:18
                                color:[UIColor whiteColor]
                               isbold:YES
                      ];
    }
    return _zd_lb;
}

- (UIView *)hsView
{
    if (!_hsView) {
        _hsView = [[UIView alloc] initWithFrame:CGRectMake(self.zdView.right + 10, self.channeName_lb.bottom + 15, (self.maskView.width - 60)/3, 63)];
        _hsView.backgroundColor = [UIColor colorWithHex:@"#AE63EE"];
        _hsView.layer.cornerRadius = 4;
    }
    
    return _hsView;
}

- (UILabel *)hs_tl_lb
{
    if (!_hs_tl_lb) {
        _hs_tl_lb = [UILabel z_frame:CGRectMake(10, 10, self.hsView.width - 10, 20)
                                 Text:NSLocalizedString(@"换算值", nil)
                             fontSize:14
                                color:[UIColor whiteColor]
                               isbold:NO
                      ];
    }
    return _hs_tl_lb;
}

- (UILabel *)hs_lb
{
    if (!_hs_lb) {
        _hs_lb = [UILabel z_frame:CGRectMake(10, self.hs_tl_lb.bottom + 2, self.hsView.width - 10, 21)
                                 Text:@"24.5"
                             fontSize:18
                                color:[UIColor whiteColor]
                               isbold:YES
                      ];
    }
    return _hs_lb;
}
@end
