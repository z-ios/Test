//
//  SingleLogInfoView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleLogInfoView.h"
#import "SingleAlarmLogModel.h"

@interface SingleLogInfoView ()

@property (nonatomic, strong) UILabel* tl_lb;
@property (nonatomic, strong) UIButton* cannelBtn;
@property (nonatomic, strong) UILabel* hs_tl_lb;
@property (nonatomic, strong) UILabel* hs_lb;
@property (nonatomic, strong) UILabel* lj_tl_lb;
@property (nonatomic, strong) UILabel* lj_lb;
@property (nonatomic, strong) UILabel* db_tl_lb;
@property (nonatomic, strong) UILabel* db_lb;
@property (nonatomic, strong) UILabel* line_lb;
@property (nonatomic, strong) UIView* valueView;
@property (nonatomic, strong) UILabel* value_tl_lb;
@property (nonatomic, strong) UILabel* value_lb;
@property (nonatomic, strong) UIView* originalView;
@property (nonatomic, strong) UILabel* original_tl_lb;
@property (nonatomic, strong) UILabel* original_lb;

@end
@implementation SingleLogInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(SingleAlarmLogModel *)model
{
    _model = model;
    
    _hs_lb.text = model.calculatedVal;
    _lj_lb.text = model.logicRelation;
    _db_lb.text = model.logicThreshold;
    _value_lb.text = model.readVal;
    _original_lb.text = model.originalVal;
    
    
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    [self addSubview:self.tl_lb];
    [self addSubview:self.cannelBtn];
    [self addSubview:self.hs_tl_lb];
    [self addSubview:self.lj_tl_lb];
    [self addSubview:self.db_tl_lb];
    [self addSubview:self.hs_lb];
    [self addSubview:self.lj_lb];
    [self addSubview:self.db_lb];
    [self addSubview:self.line_lb];
    [self addSubview:self.valueView];
    [self addSubview:self.originalView];
    [self.valueView addSubview:self.value_tl_lb];
    [self.valueView addSubview:self.value_lb];
    [self.originalView addSubview:self.original_tl_lb];
    [self.originalView addSubview:self.original_lb];
    
    
}

- (void)cannelBtnClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

#pragma mark - lazy

- (UILabel *)tl_lb
{
    if (!_tl_lb) {
        _tl_lb = [UILabel z_frame:CGRectMake(20, 30, 120, 33)
                             Text:@"触发条件"
                         fontSize:24
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
    }
    return _tl_lb;
}

- (UIButton *)cannelBtn
{
    if (!_cannelBtn) {
        _cannelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 36 - 20, 20, 36, 36)];
        [_cannelBtn setImage:[SVGKImage imageNamed:@"icon_registor_close"].UIImage forState:UIControlStateNormal];
        [_cannelBtn addTarget:self action:@selector(cannelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cannelBtn;
}

- (UILabel *)hs_tl_lb
{
    if (!_hs_tl_lb) {
        _hs_tl_lb = [UILabel z_frame:CGRectMake(40, self.tl_lb.bottom + 30, 75, 28)
                             Text:@"换算值"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#646664"]
                           isbold:YES
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                  ];
        _hs_tl_lb.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _hs_tl_lb;
}

- (UILabel *)lj_tl_lb
{
    if (!_lj_tl_lb) {
        _lj_tl_lb = [UILabel z_frame:CGRectMake((self.width - 60)*0.5, self.tl_lb.bottom + 30, 60, 28)
                             Text:@"逻辑"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#646664"]
                           isbold:YES
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                  ];
        _lj_tl_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lj_tl_lb;
}

- (UILabel *)db_tl_lb
{
    if (!_db_tl_lb) {
        _db_tl_lb = [UILabel z_frame:CGRectMake(self.width - 75 - 40, self.tl_lb.bottom + 30, 75, 28)
                             Text:@"比对值"
                         fontSize:14
                            color:[UIColor colorWithHex:@"#646664"]
                           isbold:YES
                     cornerRadius:14
                  backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                  ];
        _db_tl_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _db_tl_lb;
}

- (UILabel *)hs_lb
{
    if (!_hs_lb) {
        _hs_lb = [UILabel z_frame:CGRectMake(0, self.hs_tl_lb.bottom + 10, self.hs_tl_lb.width + 60, 33)
                             Text:@"23.5"
                         fontSize:24
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
        _hs_lb.textAlignment = NSTextAlignmentCenter;
        _hs_lb.centerX = self.hs_tl_lb.centerX;
    }
    return _hs_lb;
}

- (UILabel *)lj_lb
{
    if (!_lj_lb) {
        _lj_lb = [UILabel z_frame:CGRectMake(0, self.lj_tl_lb.bottom + 10, self.lj_tl_lb.width, 33)
                             Text:@"<"
                         fontSize:24
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
        _lj_lb.textAlignment = NSTextAlignmentCenter;
        _lj_lb.centerX = self.lj_tl_lb.centerX;
    }
    return _lj_lb;
}

- (UILabel *)db_lb
{
    if (!_db_lb) {
        _db_lb = [UILabel z_frame:CGRectMake(0, self.db_tl_lb.bottom + 10, self.db_tl_lb.width + 60, 33)
                             Text:@"23.5"
                         fontSize:24
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
        _db_lb.textAlignment = NSTextAlignmentCenter;
        _db_lb.centerX = self.db_tl_lb.centerX;
    }
    return _db_lb;
}

- (UILabel *)line_lb
{
    if (!_line_lb) {
        _line_lb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.hs_lb.bottom + 30, self.width - 60, 1)];
        _line_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _line_lb;
}

- (UIView *)valueView
{
    if (!_valueView) {
        _valueView = [[UIView alloc] initWithFrame:CGRectMake(20, self.line_lb.bottom + 25, (self.width - 50)*0.5, 81)];
        _valueView.backgroundColor = [UIColor colorWithHex:@"#E8EFF9"];
        _valueView.layer.cornerRadius = 8;
    }
    
    return _valueView;
}

- (UIView *)originalView
{
    if (!_originalView) {
        _originalView = [[UIView alloc] initWithFrame:CGRectMake(self.valueView.right + 10, self.line_lb.bottom + 25, (self.width - 50)*0.5, 81)];
        _originalView.backgroundColor = [UIColor colorWithHex:@"#F9EFE9"];
        _originalView.layer.cornerRadius = 8;
    }
    
    return _originalView;
}

- (UILabel *)value_tl_lb
{
    if (!_value_tl_lb) {
        _value_tl_lb = [UILabel z_frame:CGRectMake(15, 15, self.valueView.width - 15, 20)
                                   Text:@"电流（压）值"
                               fontSize:14
                                  color:[UIColor colorWithHex:@"#4D8CEB"]
                                 isbold:NO
                        ];
        
    }
    return _value_tl_lb;
}

- (UILabel *)value_lb
{
    if (!_value_lb) {
        _value_lb = [UILabel z_frame:CGRectMake(15, self.value_tl_lb.bottom + 3, self.valueView.width - 15, 20)
                                Text:@"230"
                            fontSize:24
                               color:[UIColor colorWithHex:@"#4D8CEB"]
                              isbold:YES
                     ];
        
    }
    return _value_lb;
}

- (UILabel *)original_tl_lb
{
    if (!_original_tl_lb) {
        _original_tl_lb = [UILabel z_frame:CGRectMake(15, 15, self.originalView.width - 15, 20)
                                      Text:@"原始值"
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#ED8549"]
                                    isbold:NO
                           ];
        
    }
    return _original_tl_lb;
}

- (UILabel *)original_lb
{
    if (!_original_lb) {
        _original_lb = [UILabel z_frame:CGRectMake(15, self.original_tl_lb.bottom + 3, self.originalView.width - 15, 20)
                                   Text:@"3243535"
                               fontSize:24
                                  color:[UIColor colorWithHex:@"#ED8549"]
                                 isbold:YES
                        ];
        
    }
    return _original_lb;
}

@end
