//
//  SingSendLogCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingSendLogCell.h"
#import "SingleSendLogModel.h"
#import "SingSendLogInfoView.h"

@interface SingSendLogCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UILabel* name_lb;
@property (nonatomic, strong) UILabel* user_lb;
@property (nonatomic, strong) UILabel* state_lb;
@property (nonatomic, strong) UILabel* date_lb;
@property (nonatomic, strong) UIButton* json_btn;

@end
@implementation SingSendLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 96;
        self.width = zScreenWidth;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(SingleSendLogModel *)model
{
    _model = model;
    self.maskView.x = model.bgWith;
    self.name_lb.text = model.operation;
    self.state_lb.text = model.status;
    if ([model.status isEqualToString:@"delivered"]) {
        self.state_lb.textColor = [UIColor colorWithHex:@"#9499A0"];
    }else if ([model.status isEqualToString:@"已下发"]) {
        self.state_lb.textColor = [UIColor colorWithHex:@"#26C464"];
    }else if ([model.status isEqualToString:@"failed"]) {
        self.state_lb.textColor = [UIColor colorWithHex:@"#F1544F"];
    }
    self.user_lb.text = model.operateUserName;
    self.date_lb.text = [NSObject getTimeStrWithString:model.logTime];
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self.contentView addSubview:self.maskView];

    [self.maskView addSubview:self.name_lb];
    [self.maskView addSubview:self.json_btn];
    [self.maskView addSubview:self.state_lb];
    [self.maskView addSubview:self.user_lb];
    [self.maskView addSubview:self.date_lb];
    
}

- (void)json_btnClick
{
    NSLog(@"点击了");
    SingSendLogInfoView* eview = [[SingSendLogInfoView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 573)];
    eview.jsonStr = self.model.sendJson;
    eview.configJsonStr = self.model.configJson;
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

- (UILabel *)name_lb
{
    if (!_name_lb) {
        _name_lb = [UILabel z_frame:CGRectMake(20, 15, self.maskView.width*0.5, 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _name_lb;
}

- (UIButton *)json_btn
{
    if (!_json_btn) {
        _json_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.maskView.width - 24 - 16, 15, 24, 24)];
        [_json_btn setImage:[SVGKImage imageNamed:@"icon_more_detail"].UIImage forState:UIControlStateNormal];
        [_json_btn addTarget:self action:@selector(json_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _json_btn;
}

- (UILabel *)state_lb
{
    if (!_state_lb) {
        _state_lb = [UILabel z_frame:CGRectZero
                                Text:@"已下发"
                            fontSize:14
                               color:[UIColor colorWithHex:@"#26C464"]
                              isbold:NO
                     ];
        _state_lb.width = 100;
        _state_lb.height = 20;
        _state_lb.right = self.json_btn.x - 10;
        _state_lb.centerY = self.json_btn.centerY;
        
        _state_lb.textAlignment = NSTextAlignmentRight;
    }
    return _state_lb;
}

- (UILabel *)user_lb
{
    if (!_user_lb) {
        _user_lb = [UILabel z_frame:CGRectMake(20, self.name_lb.bottom + 12, self.maskView.width * 0.5, 20)
                               Text:@"写值"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
    }
    return _user_lb;
}

- (UILabel *)date_lb
{
    if (!_date_lb) {
        _date_lb = [UILabel z_frame:CGRectMake(self.maskView.width * 0.5 - 16 , self.name_lb.bottom + 12, self.maskView.width * 0.5, 20)
                               Text:@"2020-12-12 12:12:12"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
        _date_lb.textAlignment = NSTextAlignmentRight;
    }
    return _date_lb;
    
}

@end
