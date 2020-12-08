//
//  ModuleView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ModuleView.h"
#import "SmallConfigMeunView.h"
#import "ModulesListModel.h"
#import "ChannelListModel.h"

@interface ModuleView ()

@property (nonatomic, strong) UIImageView* topImgView;

@property (nonatomic, strong) UIImageView* light0_imgView;
@property (nonatomic, strong) UIImageView* light1_imgView;
@property (nonatomic, strong) UIImageView* light2_imgView;
@property (nonatomic, strong) UIImageView* light3_imgView;

@property (nonatomic, strong) UIView* alert_light0_imgView;
@property (nonatomic, strong) UIView* alert_light1_imgView;
@property (nonatomic, strong) UIView* alert_light2_imgView;
@property (nonatomic, strong) UIView* alert_light3_imgView;

@property (nonatomic, strong) UIImageView* modle0_imgView;
@property (nonatomic, strong) UIImageView* modle1_imgView;
@property (nonatomic, strong) UIImageView* modle2_imgView;
@property (nonatomic, strong) UIImageView* modle3_imgView;
@property (nonatomic, strong) UIImageView* bottomView;

@end
@implementation ModuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor colorWithHex:@"#2F3238"];
    self.layer.cornerRadius = 30;
    
    // 添加子控件
    [self addSubview:self.topImgView];
    [self addSubview:self.light0_imgView];
    [self addSubview:self.modle0_imgView];
    [self addSubview:self.light1_imgView];
    [self addSubview:self.modle1_imgView];
    [self addSubview:self.light2_imgView];
    [self addSubview:self.modle2_imgView];
    [self addSubview:self.light3_imgView];
    [self addSubview:self.modle3_imgView];
    [self addSubview:self.bottomView];
    [self.modle0_imgView addSubview:self.alert_light0_imgView];
    [self.modle1_imgView addSubview:self.alert_light1_imgView];
    [self.modle2_imgView addSubview:self.alert_light2_imgView];
    [self.modle3_imgView addSubview:self.alert_light3_imgView];
    
    //
    self.modle0_imgView.tag = 1000;
    self.modle1_imgView.tag = 1001;
    self.modle2_imgView.tag = 1002;
    self.modle3_imgView.tag = 1003;
    
}

- (void)setModel:(ModulesListModel *)model
{
    _model = model;
    
    [self setValue:_model];
    
    
}

- (void)setValue:(ModulesListModel *)model
{
    
    if ([model.moduletype hasPrefix:@"CH3"]) {
        self.light3_imgView.image = [UIImage imageNamed:@"io_none"];
        self.modle3_imgView.image = [UIImage imageNamed:@"io_3p"];
        self.modle3_imgView.userInteractionEnabled = NO;
    }else if ([model.moduletype hasPrefix:@"CH4"]) {
        self.light3_imgView.image = [UIImage imageNamed:@"io_p3"];
        self.modle3_imgView.image = [UIImage imageNamed:@"io_4p"];
        self.modle3_imgView.userInteractionEnabled = YES;
    }
    
    [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull channelModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (channelModel.alarm_type.length > 0) {
            if ([channelModel.alarm_type isEqualToString:@"H"]) {
                switch (idx) {
                    case 0:
                        self.alert_light0_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 1:
                        self.alert_light1_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 2:
                        self.alert_light2_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 3:
                        self.alert_light3_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                        
                    default:
                        break;
                }
            }else{
                switch (idx) {
                    case 0:
                        self.alert_light0_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 1:
                        self.alert_light1_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 2:
                        self.alert_light2_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 3:
                        self.alert_light3_imgView.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }];
}

#pragma mark - UIGestureRecognizer Handles
-(void)handleTap:(UITapGestureRecognizer *)recognizer
{
    SmallConfigMeunView* mmV = [[SmallConfigMeunView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight)];
    mmV.group_id = _group_id;
    mmV.moduletype = _model.moduletype;
    mmV.channelModel = _model.channels[recognizer.view.tag - 1000];
    [zAppWindow.rootViewController.view addSubview:mmV];
}

#pragma mark - lazy
- (UIImageView *)topImgView
{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, SPH(122))];
        _topImgView.image = [UIImage imageNamed:@"io_head"];
    }
    return _topImgView;
}

- (UIImageView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle3_imgView.bottom, self.width, SPH(46))];
        _bottomView.image = [UIImage imageNamed:@"io_feet"];
    }
    return _bottomView;
}

- (UIImageView *)light0_imgView
{
    if (!_light0_imgView) {
        _light0_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.topImgView.bottom, self.width, SPH(22))];
        _light0_imgView.image = [UIImage imageNamed:@"io_p0"];
    }
    return _light0_imgView;
}

- (UIImageView *)modle0_imgView
{
    if (!_modle0_imgView) {
        _modle0_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.light0_imgView.bottom, self.width, SPH(54))];
        _modle0_imgView.image = [UIImage imageNamed:@"io_port"];
        _modle0_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle0_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle0_imgView;
}

- (UIImageView *)light1_imgView
{
    if (!_light1_imgView) {
        _light1_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle0_imgView.bottom, self.width, SPH(22))];
        _light1_imgView.image = [UIImage imageNamed:@"io_p1"];
    }
    return _light1_imgView;
}

- (UIImageView *)modle1_imgView
{
    if (!_modle1_imgView) {
        _modle1_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.light1_imgView.bottom, self.width, SPH(54))];
        _modle1_imgView.image = [UIImage imageNamed:@"io_port"];
        _modle1_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle1_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle1_imgView;
}

- (UIImageView *)light2_imgView
{
    if (!_light2_imgView) {
        _light2_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle1_imgView.bottom, self.width, SPH(22))];
        _light2_imgView.image = [UIImage imageNamed:@"io_p2"];
    }
    return _light2_imgView;
}

- (UIImageView *)modle2_imgView
{
    if (!_modle2_imgView) {
        _modle2_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.light2_imgView.bottom, self.width, SPH(54))];
        _modle2_imgView.image = [UIImage imageNamed:@"io_port"];
        _modle2_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle2_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle2_imgView;
}

- (UIImageView *)light3_imgView
{
    if (!_light3_imgView) {
        _light3_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle2_imgView.bottom, self.width, SPH(22))];
        _light3_imgView.image = [UIImage imageNamed:@"io_p3"];
    }
    return _light3_imgView;
}

- (UIImageView *)modle3_imgView
{
    if (!_modle3_imgView) {
        _modle3_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.light3_imgView.bottom, self.width, SPH(54))];
        _modle3_imgView.image = [UIImage imageNamed:@"io_4p"];
        _modle3_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle3_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle3_imgView;
}

- (UIView *)alert_light0_imgView
{
    if (!_alert_light0_imgView) {
        _alert_light0_imgView = [[UIView alloc] initWithFrame:CGRectMake(self.modle0_imgView.width*0.5 + SPH(35), (self.modle0_imgView.height - SPH(10))*0.5, SPH(10), SPH(10))];
        _alert_light0_imgView.layer.cornerRadius = SPH(5);

    }
    
    return _alert_light0_imgView;
}

- (UIView *)alert_light1_imgView
{
    if (!_alert_light1_imgView) {
        _alert_light1_imgView = [[UIView alloc] initWithFrame:CGRectMake(self.modle1_imgView.width*0.5 + SPH(35), (self.modle1_imgView.height - SPH(10))*0.5, SPH(10), SPH(10))];
        _alert_light1_imgView.layer.cornerRadius = SPH(5);

    }
    
    return _alert_light1_imgView;
}

- (UIView *)alert_light2_imgView
{
    if (!_alert_light2_imgView) {
        _alert_light2_imgView = [[UIView alloc] initWithFrame:CGRectMake(self.modle2_imgView.width*0.5 + SPH(35), (self.modle2_imgView.height - SPH(10))*0.5, SPH(10), SPH(10))];
        _alert_light2_imgView.layer.cornerRadius = SPH(5);
    }
    
    return _alert_light2_imgView;
}

- (UIView *)alert_light3_imgView
{
    if (!_alert_light3_imgView) {
        _alert_light3_imgView = [[UIView alloc] initWithFrame:CGRectMake(self.modle3_imgView.width*0.5 + SPH(35), (self.modle3_imgView.height - SPH(10))*0.5, SPH(10), SPH(10))];
        _alert_light3_imgView.layer.cornerRadius = SPH(5);
    }
    
    return _alert_light3_imgView;
}

@end
