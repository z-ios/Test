//
//  SingleAlarmLogCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleAlarmLogCell.h"
#import "SingleAlarmLogModel.h"
#import "SingleLogInfoView.h"

@interface SingleAlarmLogCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UILabel* port_lb;
@property (nonatomic, strong) UIButton * infoBtn;
@property (nonatomic, strong) UILabel* channelname_lb;
@property (nonatomic, strong) UIView* colorView;
@property (nonatomic, strong) UILabel* tag_lb;
@property (nonatomic, strong) UILabel* channeltitle_lb;
@property (nonatomic, strong) UILabel* date_lb;

@end
@implementation SingleAlarmLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 121;
        self.width = zScreenWidth;
//        self.selectionStyle = +;
        [self setupUI];
    }
    
    return self;
}

- (void)setModel:(SingleAlarmLogModel *)model
{
    _model = model;
    self.maskView.x = model.bgWith;
    self.port_lb.text = model.port;
    self.channelname_lb.text = model.channelName;
    self.colorView.backgroundColor = [UIColor colorWithHex:model.tagColor];
    self.tag_lb.text = model.alarmTag;
    self.tag_lb.width = 0;
    [self.tag_lb sizeToFit];
    self.tag_lb.frame = CGRectMake(self.maskView.width - self.tag_lb.width - 16, 0, self.tag_lb.width, 20);
    self.tag_lb.centerY = self.channelname_lb.centerY;
    self.colorView.x = self.tag_lb.x - 5 - 12;
    self.channeltitle_lb.text = model.channelTitle;
    self.channeltitle_lb.width = 0;
    [self.channeltitle_lb sizeToFit];
    self.channeltitle_lb.frame = CGRectMake(20, self.channelname_lb.bottom + 5, self.channeltitle_lb.width, 20);
    self.date_lb.text = [NSObject getTimeStrWithString:model.logTime];
    self.date_lb.width = 0;
    [self.date_lb sizeToFit];
    self.date_lb.frame = CGRectMake(self.maskView.width - self.date_lb.width - 16, 0, self.date_lb.width, 20);
    self.date_lb.centerY = self.channeltitle_lb.centerY;
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self.contentView addSubview:self.maskView];

    [self.maskView addSubview:self.port_lb];
    [self.maskView addSubview:self.infoBtn];
    [self.maskView addSubview:self.channelname_lb];
    [self.maskView addSubview:self.colorView];
    [self.maskView addSubview:self.tag_lb];
    [self.maskView addSubview:self.channeltitle_lb];
    [self.maskView addSubview:self.date_lb];
    
}

- (void)infoBtnClick
{
    SingleLogInfoView* eview = [[SingleLogInfoView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 341)];
    eview.model = self.model;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
    nkView.contentView = eview;
    [nkView show];
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
        _port_lb = [UILabel z_frame:CGRectMake(20, 15, 60, 24)
                               Text:@"P0_A"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _port_lb;
}

- (UIButton *)infoBtn
{
    if (!_infoBtn) {
        _infoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.maskView.width - 24 - 16, 15, 24, 24)];
        [_infoBtn setImage:[SVGKImage imageNamed:@"icon_confi_information"].UIImage forState:UIControlStateNormal];
        [_infoBtn addTarget:self action:@selector(infoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _infoBtn;
}

- (UILabel *)channelname_lb
{
    if (!_channelname_lb) {
        _channelname_lb = [UILabel z_frame:CGRectMake(20, self.port_lb.bottom + 12, 135, 20)
                                      Text:@"P0_A"
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _channelname_lb;
}

- (UIView *)colorView
{
    if (!_colorView) {
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
        _colorView.centerY = self.channelname_lb.centerY;
        _colorView.layer.cornerRadius = 6;
    }
    return _colorView;
}

- (UILabel *)tag_lb
{
    if (!_tag_lb) {
        _tag_lb = [UILabel z_frame:CGRectZero
                                      Text:@"水位过低一级"
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
        _tag_lb.centerY = self.channelname_lb.centerY;
        _tag_lb.textAlignment = NSTextAlignmentRight;
    }
    return _tag_lb;
}

- (UILabel *)channeltitle_lb
{
    if (!_channeltitle_lb) {
        _channeltitle_lb = [UILabel z_frame:CGRectMake(20, self.channelname_lb.bottom + 5, 0, 20)
                                      Text:@"水位过低一级"
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _channeltitle_lb;
}

- (UILabel *)date_lb
{
    if (!_date_lb) {
        _date_lb = [UILabel z_frame:CGRectZero
                                      Text:@""
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
        _date_lb.centerY = self.channelname_lb.centerY;
        _date_lb.textAlignment = NSTextAlignmentRight;
    }
    return _date_lb;
}



@end
