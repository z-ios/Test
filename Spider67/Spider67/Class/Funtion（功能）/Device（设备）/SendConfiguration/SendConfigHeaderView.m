//
//  SendConfigHeaderView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/8.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendConfigHeaderView.h"
#import "SendConfigModel.h"

@interface SendConfigHeaderView ()

@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* typeLb;


@end
@implementation SendConfigHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(SendConfigModel *)model
{
    _model = model;
    _titleLb.text = model.modulename;
    _typeLb.text = model.moduletype;
    if ([model.modulename isEqualToString:@"module_0"]) {
        _lineView.backgroundColor = [UIColor colorWithHex:@"#4D8CEB"];
        _typeLb.textColor = [UIColor colorWithHex:@"#4D8CEB"];
        _typeLb.backgroundColor = [UIColor colorWithHex:@"#4D8CEB" alpha:0.1];
    }else if ([model.modulename isEqualToString:@"module_1"]) {
        _lineView.backgroundColor = [UIColor colorWithHex:@"#AE63EE"];
        _typeLb.textColor = [UIColor colorWithHex:@"#AE63EE"];
        _typeLb.backgroundColor = [UIColor colorWithHex:@"#AE63EE" alpha:0.1];
    }else {
        _lineView.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        _typeLb.textColor = [UIColor colorWithHex:@"#26C464"];
        _typeLb.backgroundColor = [UIColor colorWithHex:@"#26C464" alpha:0.1];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lineView.frame = CGRectMake(0, (self.height - (self.height - 16))*0.5, 4, self.height - 16);
    self.titleLb.frame = CGRectMake(25, (self.height - 24)*0.5, 80, 24);
    self.typeLb.frame = CGRectMake(self.titleLb.right + 10, (self.height - 28)*0.5, 128, 28);
    self.line_lb.frame = CGRectMake(24, self.height - 1, self.width - 24*2, 1);
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.lineView];
    [self addSubview:self.titleLb];
    [self addSubview:self.typeLb];
    [self addSubview:self.line_lb];
    
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.height - 48)*0.5, 4, 48)];
        _lineView.backgroundColor = [UIColor colorWithHex:@"#4D8CEB"];
        _lineView.layer.cornerRadius = 2;
    }
    return _lineView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, (self.height - 24)*0.5, 80, 24)
                               Text:@"module_1"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _titleLb;
}

- (UILabel *)typeLb
{
    if (!_typeLb) {
        _typeLb = [UILabel z_frame:CGRectMake(self.titleLb.right + 10, (self.height - 28)*0.5, 128, 28)
                              Text:@"CH8_DUP_M12"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#AE63EE"]
                            isbold:NO
                      cornerRadius:14
                   backgroundColor:[UIColor colorWithHex:@"#AE63EE" alpha:0.1]
                   ];
        _typeLb.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLb;
}

- (UILabel *)line_lb
{
    if (!_line_lb) {
        _line_lb = [[UILabel alloc] initWithFrame:CGRectMake(24, self.height - 1, self.width - 24*2, 1)];
        _line_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _line_lb;
}


@end
