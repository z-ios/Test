//
//  WgView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgView.h"
#import "MoudleSelectAlertView.h"
#import "ChannelListModel.h"
#import "PointView.h"

@interface WgView ()

@property (nonatomic, strong) UIImageView* topImgView;
@property (nonatomic, strong) UIImageView* modle0_imgView;
@property (nonatomic, strong) UIImageView* modle1_imgView;
@property (nonatomic, strong) UIImageView* modle2_imgView;
@property (nonatomic, strong) UIImageView* modle3_imgView;
@property (nonatomic, strong) UIImageView* modle4_imgView;
@property (nonatomic, strong) UIImageView* modle5_imgView;
@property (nonatomic, strong) UIImageView* modle6_imgView;
@property (nonatomic, strong) UIImageView* modle7_imgView;
@property (nonatomic, strong) UIImageView* bottomView;
@property (nonatomic, copy) NSString* dev_id;

@end
@implementation WgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UIGestureRecognizer Handles
-(void) handleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"---单击手势-------%zd",recognizer.view.tag);
    MoudleSelectAlertView* eview = [[MoudleSelectAlertView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 257)];
    if (recognizer.view.tag > 103) {
        eview.moduletype = _moduletypeStr1;
    }else{
        eview.moduletype = _moduletypeStr0;
    }
    eview.mod_num = recognizer.view.tag;
    eview.dev_id = _deviceDict[@"id"];
    eview.group_id = _deviceDict[@"group_id"];
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
    nkView.contentView = eview;
    [nkView show];
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#2F3238"];
    self.layer.cornerRadius = 30;

    // 添加子控件
    [self addSubview:self.topImgView];
    [self addSubview:self.modle0_imgView];
    [self addSubview:self.modle1_imgView];
    [self addSubview:self.modle2_imgView];
    [self addSubview:self.modle3_imgView];
    [self addSubview:self.modle4_imgView];
    [self addSubview:self.modle5_imgView];
    [self addSubview:self.modle6_imgView];
    [self addSubview:self.modle7_imgView];
    [self addSubview:self.bottomView];
    
    //
    self.modle0_imgView.tag = 100;
    self.modle1_imgView.tag = 101;
    self.modle2_imgView.tag = 102;
    self.modle3_imgView.tag = 103;
    self.modle4_imgView.tag = 104;
    self.modle5_imgView.tag = 105;
    self.modle6_imgView.tag = 106;
    self.modle7_imgView.tag = 107;
    
    NSString* aa = [[NSUserDefaults standardUserDefaults] objectForKey:@"wgpoint"];
    if ([NSObject StringIsNullOrEmpty:aa]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [PointView showPointView:self.modle0_imgView];
                   });
    }
    
}
#pragma  mark - 赋值

- (void)setChannels0:(NSArray<ChannelListModel *> *)channels0
{
    _channels0 = channels0;
    [self mod0setChannelValue:_channels0];
    
}

- (void)setChannels1:(NSArray<ChannelListModel *> *)channels1
{
    _channels1 = channels1;
    [self mod1setChannelValue:_channels1];
    
}

- (void)mod0setChannelValue:(NSArray<ChannelListModel *> *)channels0
{
    // mod0
    if ([channels0[0].originalvalue isEqualToString:@"true"] && [channels0[1].originalvalue isEqualToString:@"true"]) {
        _modle0_imgView.image = [UIImage imageNamed:@"device_p0ab"];
    }else if ([channels0[0].originalvalue isEqualToString:@"false"] && [channels0[1].originalvalue isEqualToString:@"false"]) {
        _modle0_imgView.image = [UIImage imageNamed:@"device_p0"];
    }else if ([channels0[0].originalvalue isEqualToString:@"false"] && [channels0[1].originalvalue isEqualToString:@"true"]) {
        _modle0_imgView.image = [UIImage imageNamed:@"device_p0b"];
    }else if ([channels0[0].originalvalue isEqualToString:@"false"] && [channels0[1].originalvalue isEqualToString:@"true"]) {
        _modle0_imgView.image = [UIImage imageNamed:@"device_p0a"];
    }
    // mod1
    if ([channels0[2].originalvalue isEqualToString:@"true"] && [channels0[3].originalvalue isEqualToString:@"true"]) {
        _modle1_imgView.image = [UIImage imageNamed:@"device_p1ab"];
    }else if ([channels0[2].originalvalue isEqualToString:@"false"] && [channels0[3].originalvalue isEqualToString:@"false"]) {
        _modle1_imgView.image = [UIImage imageNamed:@"device_p1"];
    }else if ([channels0[2].originalvalue isEqualToString:@"false"] && [channels0[3].originalvalue isEqualToString:@"true"]) {
        _modle1_imgView.image = [UIImage imageNamed:@"device_p1b"];
    }else if ([channels0[2].originalvalue isEqualToString:@"false"] && [channels0[3].originalvalue isEqualToString:@"true"]) {
        _modle1_imgView.image = [UIImage imageNamed:@"device_p1a"];
    }
    // mod2
    if ([channels0[4].originalvalue isEqualToString:@"true"] && [channels0[5].originalvalue isEqualToString:@"true"]) {
        _modle2_imgView.image = [UIImage imageNamed:@"device_p2ab"];
    }else if ([channels0[4].originalvalue isEqualToString:@"false"] && [channels0[5].originalvalue isEqualToString:@"false"]) {
        _modle2_imgView.image = [UIImage imageNamed:@"device_p2"];
    }else if ([channels0[4].originalvalue isEqualToString:@"false"] && [channels0[5].originalvalue isEqualToString:@"true"]) {
        _modle2_imgView.image = [UIImage imageNamed:@"device_p2b"];
    }else if ([channels0[4].originalvalue isEqualToString:@"false"] && [channels0[5].originalvalue isEqualToString:@"true"]) {
        _modle2_imgView.image = [UIImage imageNamed:@"device_p2a"];
    }
    // mod3
    if ([channels0[6].originalvalue isEqualToString:@"true"] && [channels0[7].originalvalue isEqualToString:@"true"]) {
        _modle3_imgView.image = [UIImage imageNamed:@"device_p3ab"];
    }else if ([channels0[6].originalvalue isEqualToString:@"false"] && [channels0[7].originalvalue isEqualToString:@"false"]) {
        _modle3_imgView.image = [UIImage imageNamed:@"device_p3"];
    }else if ([channels0[6].originalvalue isEqualToString:@"false"] && [channels0[7].originalvalue isEqualToString:@"true"]) {
        _modle3_imgView.image = [UIImage imageNamed:@"device_p3b"];
    }else if ([channels0[6].originalvalue isEqualToString:@"false"] && [channels0[7].originalvalue isEqualToString:@"true"]) {
        _modle3_imgView.image = [UIImage imageNamed:@"device_p3a"];
    }
    
}

- (void)mod1setChannelValue:(NSArray<ChannelListModel *> *)channels1
{
    // mod4
    if ([channels1[0].originalvalue isEqualToString:@"true"] && [channels1[1].originalvalue isEqualToString:@"true"]) {
        _modle4_imgView.image = [UIImage imageNamed:@"device_p4ab"];
    }else if ([channels1[0].originalvalue isEqualToString:@"false"] && [channels1[1].originalvalue isEqualToString:@"false"]) {
        _modle4_imgView.image = [UIImage imageNamed:@"device_p4"];
    }else if ([channels1[0].originalvalue isEqualToString:@"false"] && [channels1[1].originalvalue isEqualToString:@"true"]) {
        _modle4_imgView.image = [UIImage imageNamed:@"device_p4b"];
    }else if ([channels1[0].originalvalue isEqualToString:@"false"] && [channels1[1].originalvalue isEqualToString:@"true"]) {
        _modle4_imgView.image = [UIImage imageNamed:@"device_p4a"];
    }
    // mod5
    if ([channels1[2].originalvalue isEqualToString:@"true"] && [channels1[3].originalvalue isEqualToString:@"true"]) {
        _modle5_imgView.image = [UIImage imageNamed:@"device_p5ab"];
    }else if ([channels1[2].originalvalue isEqualToString:@"false"] && [channels1[3].originalvalue isEqualToString:@"false"]) {
        _modle5_imgView.image = [UIImage imageNamed:@"device_p5"];
    }else if ([channels1[2].originalvalue isEqualToString:@"false"] && [channels1[3].originalvalue isEqualToString:@"true"]) {
        _modle5_imgView.image = [UIImage imageNamed:@"device_p5b"];
    }else if ([channels1[2].originalvalue isEqualToString:@"false"] && [channels1[3].originalvalue isEqualToString:@"true"]) {
        _modle5_imgView.image = [UIImage imageNamed:@"device_p5a"];
    }
    // mod6
    if ([channels1[4].originalvalue isEqualToString:@"true"] && [channels1[5].originalvalue isEqualToString:@"true"]) {
        _modle6_imgView.image = [UIImage imageNamed:@"device_p6ab"];
    }else if ([channels1[4].originalvalue isEqualToString:@"false"] && [channels1[5].originalvalue isEqualToString:@"false"]) {
        _modle6_imgView.image = [UIImage imageNamed:@"device_p6"];
    }else if ([channels1[4].originalvalue isEqualToString:@"false"] && [channels1[5].originalvalue isEqualToString:@"true"]) {
        _modle6_imgView.image = [UIImage imageNamed:@"device_p6b"];
    }else if ([channels1[4].originalvalue isEqualToString:@"false"] && [channels1[5].originalvalue isEqualToString:@"true"]) {
        _modle6_imgView.image = [UIImage imageNamed:@"device_p6a"];
    }
    // mod7
    if ([channels1[6].originalvalue isEqualToString:@"true"] && [channels1[7].originalvalue isEqualToString:@"true"]) {
        _modle7_imgView.image = [UIImage imageNamed:@"device_p7ab"];
    }else if ([channels1[6].originalvalue isEqualToString:@"false"] && [channels1[7].originalvalue isEqualToString:@"false"]) {
        _modle7_imgView.image = [UIImage imageNamed:@"device_p7"];
    }else if ([channels1[6].originalvalue isEqualToString:@"false"] && [channels1[7].originalvalue isEqualToString:@"true"]) {
        _modle7_imgView.image = [UIImage imageNamed:@"device_p7b"];
    }else if ([channels1[6].originalvalue isEqualToString:@"false"] && [channels1[7].originalvalue isEqualToString:@"true"]) {
        _modle7_imgView.image = [UIImage imageNamed:@"device_p7a"];
    }
    
}


- (UIImageView *)topImgView
{
    if (!_topImgView) {
        _topImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, SPH(55))];
        _topImgView.image = [UIImage imageNamed:@"device_head"];
    }
    return _topImgView;
}

- (UIImageView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle7_imgView.bottom, self.width, SPH(107))];
        _bottomView.image = [UIImage imageNamed:@"device_feet"];
    }
    return _bottomView;
}

- (UIImageView *)modle0_imgView
{
    if (!_modle0_imgView) {
        _modle0_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.topImgView.bottom, self.width * 0.5, SPH(79))];
        _modle0_imgView.image = [UIImage imageNamed:@"device_p0"];
        _modle0_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle0_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle0_imgView;
}

- (UIImageView *)modle1_imgView
{
    if (!_modle1_imgView) {
        _modle1_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5, self.modle0_imgView.y, self.width * 0.5, SPH(79))];
        _modle1_imgView.image = [UIImage imageNamed:@"device_p1"];
        _modle1_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle1_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle1_imgView;
}

- (UIImageView *)modle2_imgView
{
    if (!_modle2_imgView) {
        _modle2_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle0_imgView.bottom, self.width * 0.5, SPH(79))];
        _modle2_imgView.image = [UIImage imageNamed:@"device_p2"];
        _modle2_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle2_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle2_imgView;
}

- (UIImageView *)modle3_imgView
{
    if (!_modle3_imgView) {
        _modle3_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5, self.modle2_imgView.y, self.width * 0.5, SPH(79))];
        _modle3_imgView.image = [UIImage imageNamed:@"device_p3"];
        _modle3_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle3_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle3_imgView;
}

- (UIImageView *)modle4_imgView
{
    if (!_modle4_imgView) {
        _modle4_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle2_imgView.bottom, self.width * 0.5, SPH(79))];
        _modle4_imgView.image = [UIImage imageNamed:@"device_p4"];
        _modle4_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle4_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle4_imgView;
}

- (UIImageView *)modle5_imgView
{
    if (!_modle5_imgView) {
        _modle5_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5, self.modle4_imgView.y, self.width * 0.5, SPH(79))];
        _modle5_imgView.image = [UIImage imageNamed:@"device_p5"];
        _modle5_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle5_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle5_imgView;
}

- (UIImageView *)modle6_imgView
{
    if (!_modle6_imgView) {
        _modle6_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.modle4_imgView.bottom, self.width * 0.5, SPH(79))];
        _modle6_imgView.image = [UIImage imageNamed:@"device_p6"];
        _modle6_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle6_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle6_imgView;
}

- (UIImageView *)modle7_imgView
{
    if (!_modle7_imgView) {
        _modle7_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5, self.modle6_imgView.y, self.width * 0.5, SPH(79))];
        _modle7_imgView.image = [UIImage imageNamed:@"device_p5"];
        _modle7_imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [_modle7_imgView addGestureRecognizer:tapRecognize];
    }
    return _modle7_imgView;
}

@end
