//
//  ChannelWarnDetailsView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ChannelWarnDetailsView.h"
#import "ChannelSelectWarnView.h"
#import "ShowWarnLabel.h"

@interface ChannelWarnDetailsView ()

@property (nonatomic, strong) UILabel* true_lb;
@property (nonatomic, strong) UILabel* false_lb;
@property (nonatomic, strong) UIButton* trueAlert_btn;
@property (nonatomic, strong) UIButton* falseAlert_btn;

@end
@implementation ChannelWarnDetailsView

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
    
    [self addSubview:self.true_lb];
    [self addSubview:self.trueAlert_btn];
    [self addSubview:self.false_lb];
    [self addSubview:self.falseAlert_btn];

    
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    _alarm_color_H = _dict[@"alarm_color_H"];
    _alarm_color_L = _dict[@"alarm_color_L"];
    _alarm_tag_H = _dict[@"alarm_tag_H"];
    _alarm_tag_L = _dict[@"alarm_tag_L"];
    if (_alarm_color_H.length > 0) {
        [self ShowSelectWarnLabelWithType:@"H" colorStr:_dict[@"alarm_color_H"] valueStr:_dict[@"alarm_tag_H"]];
    }
    if (_alarm_color_L.length > 0) {
        [self ShowSelectWarnLabelWithType:@"L" colorStr:_dict[@"alarm_color_L"] valueStr:_dict[@"alarm_tag_L"]];
    }
}


- (void)trueAlert_btnClick
{
    [self showSelectWarnView:@"H"];
}

- (void)falseAlert_btnClick
{
    [self showSelectWarnView:@"L"];
}

- (void)showSelectWarnView:(NSString *)type
{
    [CenterNet.shared checkWarnItemCompletionParm:_group_id completion:^(NSArray * _Nullable dataList) {
        ChannelSelectWarnView* eview = [[ChannelSelectWarnView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 554)];
        eview.warnItems = dataList;
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
        nkView.contentView = eview;
        [nkView show];
        eview.selectWarnData = ^(NSString * _Nonnull colorStr, NSString * _Nonnull valueStr) {
            [self ShowSelectWarnLabelWithType:type colorStr:colorStr valueStr:valueStr];
        };
    }];
}

- (void)ShowSelectWarnLabelWithType:(NSString *)type colorStr:(NSString *)colorStr valueStr:(NSString *)valueStr
{
    ShowWarnLabel* lb = [ShowWarnLabel new];
    lb.text = valueStr;
    CGSize contentSize = [NSObject sizeWidthWidth:valueStr font:[UIFont systemFontOfSize:17] maxHeight:58];
    CGFloat lb_Width = contentSize.width + 93;
    if ([type isEqualToString:@"H"]) {
        lb.frame = CGRectMake(20, self.true_lb.bottom + 10, lb_Width, 58);
        self.trueAlert_btn.hidden = YES;
        lb.deletWarmItem = ^{
            self.trueAlert_btn.hidden = NO;
            self.alarm_color_H = @"";
            self.alarm_tag_H = @"";
        };
        _alarm_color_H = colorStr;
        _alarm_tag_H = valueStr;
    }else{
        lb.frame = CGRectMake(20, self.false_lb.bottom + 10, lb_Width, 58);
        self.falseAlert_btn.hidden = YES;
        lb.deletWarmItem = ^{
            self.falseAlert_btn.hidden = NO;
            self.alarm_color_L = @"";
            self.alarm_tag_L = @"";
        };
        _alarm_color_L = colorStr;
        _alarm_tag_L = valueStr;
    }
    
    lb.colorView.frame = CGRectMake(15, (lb.height - 24)*0.5, 24, 24);
    lb.colorView.backgroundColor = [UIColor colorWithHex:colorStr];
    lb.deleBtn.frame = CGRectMake(lb_Width - 24 - 10, (lb.height - 24)*0.5, 24, 24);
    
    [self addSubview:lb];
    
}

#pragma mark - lazy

- (UILabel *)true_lb
{
    if (!_true_lb) {
        _true_lb = [UILabel z_frame:CGRectMake(20, 20, self.width - 40, 20)
                              Text:@"闭合（true）"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _true_lb;
}

- (UIButton *)trueAlert_btn
{
    if (!_trueAlert_btn) {
        _trueAlert_btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.true_lb.bottom + 10, 190, 58)];
        [_trueAlert_btn setImage:[UIImage imageNamed:[[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"tag_notset_chinese" : @"tag_notset_english"] forState:UIControlStateNormal];
        [_trueAlert_btn addTarget:self action:@selector(trueAlert_btnClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _trueAlert_btn;
}

- (UILabel *)false_lb
{
    if (!_false_lb) {
        _false_lb = [UILabel z_frame:CGRectMake(20, self.trueAlert_btn.bottom + 15, self.width - 40, 20)
                              Text:@"断开（false）"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _false_lb;
}

- (UIButton *)falseAlert_btn
{
    if (!_falseAlert_btn) {
        _falseAlert_btn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.false_lb.bottom + 10, 190, 58)];
        [_falseAlert_btn setImage:[UIImage imageNamed:[[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"tag_notset_chinese" : @"tag_notset_english"] forState:UIControlStateNormal];
        [_falseAlert_btn addTarget:self action:@selector(falseAlert_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _falseAlert_btn;
}



@end
