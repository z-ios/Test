//
//  SendLinkageCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/9.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendLinkageCell.h"
#import "SendLinkageModel.h"
#import "SendLinkageView.h"

@interface SendLinkageCell ()

@property (nonatomic, strong) UIView* backView;
@property (nonatomic, strong) UILabel* in_lb;
@property (nonatomic, strong) UILabel* out_lb;
@property (nonatomic, strong) UILabel* in_channel_lb;
@property (nonatomic, strong) UILabel* out_channel_lb;
@property (nonatomic, strong) UILabel* lj_lb;
@property (nonatomic, strong) UILabel* lj_unit_lb;
@property (nonatomic, strong) UILabel* lj_tl_lb;
@property (nonatomic, strong) UILabel* line1_lb;
@property (nonatomic, strong) UILabel* line2_lb;
@property (nonatomic, strong) UIButton* btn;
@property (nonatomic, strong) SendLinkageView* sendView;

@end
@implementation SendLinkageCell

//- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 16;
//    frame.origin.y += 10;
//    frame.size.height = self.height - 10;
//    frame.size.width = zScreenWidth - 32;
//    [super setFrame:frame];
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(SendLinkageModel *)model
{
    _model = model;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btn.selected = model.isSelect;
        if (model.isSelect) {
            self.sendView.hidden = NO;
        }else{
            self.sendView.hidden = YES;
        }
        self.in_channel_lb.text = model.channel_in;
        self.out_channel_lb.text = model.channel_out;
        self.lj_unit_lb.text = [NSString stringWithFormat:@"%@ %@",model.relation,model.relationval];
        if ([model.relation isEqualToString:@"="]) {
            if ([model.relationval intValue] == 0) {
                self.lj_tl_lb.text = NSLocalizedString(@"同步", nil);
            }else{
                self.lj_tl_lb.text = NSLocalizedString(@"取反", nil);
            }
        }else{
            self.lj_tl_lb.text = NSLocalizedString(@"闭合", nil);
        }
    });
  
    self.sendView.model = self.model;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _backView.frame = CGRectMake(16, 10, self.width - 32, self.height - 10);
    _sendView.frame = CGRectMake(30, self.lj_lb.bottom + 16, self.backView.width - 60, 140);
    _line1_lb.frame = CGRectMake(30, self.in_lb.bottom + 15, self.backView.width - 60, 1);
    _line2_lb.frame = CGRectMake(30, self.out_lb.bottom + 15, self.backView.width - 60, 1);
}

- (void)setupUI
{
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.in_lb];
    [self.backView addSubview:self.in_channel_lb];
    [self.backView addSubview:self.line1_lb];
    [self.backView addSubview:self.out_lb];
    [self.backView addSubview:self.out_channel_lb];
    [self.backView addSubview:self.line2_lb];
    [self.backView addSubview:self.lj_lb];
    [self.backView addSubview:self.lj_unit_lb];
    [self.backView addSubview:self.lj_tl_lb];
    [self.backView addSubview:self.btn];
    [self.backView addSubview:self.sendView];

    
}
- (void)btnClick:(UIButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(sendLinkageIndexPath:btn:)]) {
        [self.delegate sendLinkageIndexPath:_indexPath btn:btn];
    }
    
}
#pragma mark - lazy

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(16, 10, self.width - 32, self.height - 10)];
        _backView.layer.cornerRadius = 8;
        _backView.backgroundColor=  [UIColor whiteColor];
    }
    
    return _backView;
}

- (UILabel *)in_lb
{
    if (!_in_lb) {
        _in_lb = [UILabel z_frame:CGRectMake(30, 30, 60, 28)
                             Text:@"IN"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#1D68F2"]
                           isbold:NO
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]
                  ];
        _in_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _in_lb;
}

- (UILabel *)in_channel_lb
{
    if (!_in_channel_lb) {
        _in_channel_lb = [UILabel z_frame:CGRectMake(self.in_lb.right + 10, 0, 200, 24)
                                     Text:@"module_0 channel_2"
                                 fontSize:17
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _in_channel_lb.centerY = self.in_lb.centerY;
    }
    return _in_channel_lb;
}

- (UILabel *)line1_lb
{
    if (!_line1_lb) {
        _line1_lb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.in_lb.bottom + 15, self.backView.width - 60, 1)];
        _line1_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _line1_lb;
}

- (UILabel *)out_lb
{
    if (!_out_lb) {
        _out_lb = [UILabel z_frame:CGRectMake(30, self.line1_lb.bottom + 20, 60, 28)
                             Text:@"OUT"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#AE63EE"]
                           isbold:NO
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#AE63EE" alpha:0.13]
                  ];
        _out_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _out_lb;
}

- (UILabel *)out_channel_lb
{
    if (!_out_channel_lb) {
        _out_channel_lb = [UILabel z_frame:CGRectMake(self.out_lb.right + 10, 0, 200, 24)
                                     Text:@"module_0 channel_2"
                                 fontSize:17
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _out_channel_lb.centerY = self.out_lb.centerY;
    }
    return _out_channel_lb;
}

- (UILabel *)line2_lb
{
    if (!_line2_lb) {
        _line2_lb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.out_lb.bottom + 15, self.backView.width - 60, 1)];
        _line2_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _line2_lb;
}

- (UILabel *)lj_lb
{
    if (!_lj_lb) {
        _lj_lb = [UILabel z_frame:CGRectMake(30, self.line2_lb.bottom + 20, 60, 28)
                             Text:@"逻辑"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#F26E1D"]
                           isbold:NO
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#F26E1D" alpha:0.13]
                  ];
        _lj_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _lj_lb;
}

- (UILabel *)lj_unit_lb
{
    if (!_lj_unit_lb) {
        _lj_unit_lb = [UILabel z_frame:CGRectMake(self.lj_lb.right + 10, 0, 54, 24)
                                     Text:@">= 100"
                                 fontSize:17
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _lj_unit_lb.centerY = self.lj_lb.centerY;
    }
    return _lj_unit_lb;
}

- (UILabel *)lj_tl_lb
{
    if (!_lj_tl_lb) {
        _lj_tl_lb = [UILabel z_frame:CGRectMake(self.lj_unit_lb.right + 10, 0, 40, 24)
                                     Text:@"同步"
                                 fontSize:17
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _lj_tl_lb.centerY = self.lj_lb.centerY;
    }
    return _lj_tl_lb;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(self.backView.width - 25 - 24, 0, 24, 24)];
        [_btn setImage:[UIImage imageNamed:@"icon_arrow_dropdown"] forState:UIControlStateNormal];
        [_btn setImage:[UIImage imageNamed:@"icon_arrow_packup"] forState:UIControlStateSelected];
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btn.centerY = self.lj_lb.centerY;
    }
    return _btn;
}

- (SendLinkageView *)sendView
{
    if (!_sendView) {
        _sendView = [[SendLinkageView alloc] initWithFrame:CGRectMake(30, self.lj_lb.bottom + 16, self.backView.width - 60, 140)];
    }
    return _sendView;
}

@end
