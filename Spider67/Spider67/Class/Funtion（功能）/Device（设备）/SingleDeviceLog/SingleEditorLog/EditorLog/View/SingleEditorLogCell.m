//
//  SingleEditorLogCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleEditorLogCell.h"
#import "SingleEditorLogModel.h"
#import "SingleEditorLogContentView.h"

@interface SingleEditorLogCell ()

@property (nonatomic, strong) UIView* maskView;
@property (nonatomic, strong) UILabel* user_lb;
@property (nonatomic, strong) UILabel* date_lb;
@property (nonatomic, strong) UIView* contentV;
@property (nonatomic, strong) UILabel* content_lb;
@property (nonatomic, strong) UIButton* lookMoreBtn;

@end
@implementation SingleEditorLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 165;
        self.width = zScreenWidth;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(SingleEditorLogModel *)model
{
    _model = model;
    
    self.maskView.x = model.bgWith;
    self.user_lb.text = model.username;
    self.date_lb.text = [NSObject getTimeStrWithString:model.logTime];
    self.content_lb.text = model.editContent;

}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self.contentView addSubview:self.maskView];
    [self.maskView addSubview:self.user_lb];
    [self.maskView addSubview:self.date_lb];
    [self.maskView addSubview:self.contentV];
    [self.contentV addSubview:self.content_lb];
    [self.contentV addSubview:self.lookMoreBtn];
    
}

- (void)lookMoreBtnClick
{
    SingleEditorLogContentView* eview = [[SingleEditorLogContentView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 476)];
    eview.contentStr = self.model.editContent;
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

- (UILabel *)user_lb
{
    if (!_user_lb) {
        _user_lb = [UILabel z_frame:CGRectMake(20, 20, self.maskView.width*0.5 - 20, 24)
                               Text:@"admin"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _user_lb;
}

- (UILabel *)date_lb
{
    if (!_date_lb) {
        _date_lb = [UILabel z_frame:CGRectMake(self.maskView.width*0.5 - 20, 20, self.maskView.width*0.5, 24)
                               Text:@"admin"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
        _date_lb.textAlignment = NSTextAlignmentRight;
    }
    return _date_lb;
}

- (UIView *)contentV
{
    if (!_contentV) {
        _contentV = [[UIView alloc] initWithFrame:CGRectMake(20, self.user_lb.bottom + 10, self.maskView.width - 40, 81)];
        _contentV.backgroundColor = [UIColor colorWithHex:@"#FEF8EF"];
        _contentV.layer.cornerRadius = 4;
    }
    
    return _contentV;
}

- (UILabel *)content_lb
{
    if (!_content_lb) {
        _content_lb = [UILabel z_frame:CGRectMake(10, 10, self.contentV.width - 20, 42)
                               Text:@"下发联动5条：module_0 channel_2 闭合 module_1 channel_1 断开；module_1 ……"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#5A544B"]
                             isbold:NO
                    ];
    }
    return _content_lb;
}

- (UIButton *)lookMoreBtn
{
    if (!_lookMoreBtn) {
        _lookMoreBtn = [UIButton z_svg_setImageName:@"icon_note"
                                           fontSize:12
                                         titleColor:[UIColor colorWithHex:@"#F9B01F"]
                                              title:NSLocalizedString(@"查看详细内容", nil)
                                             isbold:NO
                        ];
        _lookMoreBtn.frame = CGRectMake(self.contentV.width - 106, self.content_lb.bottom + 5, 96, 20);
        [_lookMoreBtn addTarget:self action:@selector(lookMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _lookMoreBtn;
}

@end

