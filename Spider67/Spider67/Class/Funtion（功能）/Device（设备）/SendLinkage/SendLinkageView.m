//
//  SendLinkageView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendLinkageView.h"
#import "SendLinkageModel.h"

@interface SendLinkageView ()

@property (nonatomic, strong) UILabel* in_lb;
@property (nonatomic, strong) UILabel* out_lb;
@property (nonatomic, strong) UILabel* in_channel_lb;
@property (nonatomic, strong) UILabel* out_channel_lb;
@property (nonatomic, strong) UILabel* in_p_lb;
@property (nonatomic, strong) UILabel* out_p_lb;
@property (nonatomic, strong) UILabel* in_ty_lb;
@property (nonatomic, strong) UILabel* out_ty_lb;
@property (nonatomic, strong) UILabel* in_tl_lb;
@property (nonatomic, strong) UILabel* out_tl_lb;

@end
@implementation SendLinkageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(SendLinkageModel *)model
{
    _model = model;
    _in_channel_lb.text = model.channel_in;
    _out_channel_lb.text = model.channel_out;
    _in_p_lb.text = model.port_in;
    _out_p_lb.text = model.port_out;
    _in_ty_lb.text = model.moduletype_in;
    _out_ty_lb.text = model.moduletype_out;
    _in_tl_lb.text = model.title_in;
    _out_tl_lb.text = model.title_out;
    
    CGSize sizeNew = [_in_tl_lb.text sizeWithAttributes:@{NSFontAttributeName:_in_tl_lb.font}];
    _in_tl_lb.width = sizeNew.width + 20;
    
}

- (void)setupUI{
    
    self.layer.cornerRadius = 8;
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self addSubview:self.in_lb];
    [self addSubview:self.in_channel_lb];
    [self addSubview:self.in_p_lb];
    [self addSubview:self.in_ty_lb];
    [self addSubview:self.in_tl_lb];
    
    [self addSubview:self.out_lb];
    [self addSubview:self.out_channel_lb];
    [self addSubview:self.out_p_lb];
    [self addSubview:self.out_ty_lb];
    [self addSubview:self.out_tl_lb];
    
    
}

#pragma mark - lazy

- (UILabel *)in_lb
{
    if (!_in_lb) {
        _in_lb = [UILabel z_frame:CGRectMake(20, 14, 30, 21)
                             Text:@"IN"
                         fontSize:11
                            color:[UIColor colorWithHex:@"#646F69"]
                           isbold:NO
                     cornerRadius:4
                  backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                  ];
        _in_lb.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
        _in_lb.layer.borderWidth = 1;
        _in_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _in_lb;
}

- (UILabel *)in_channel_lb
{
    if (!_in_channel_lb) {
        _in_channel_lb = [UILabel z_frame:CGRectMake(self.in_lb.right + 5, 0, 150, 20)
                                     Text:@"module_0 channel_2"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _in_channel_lb.centerY = self.in_lb.centerY;
    }
    return _in_channel_lb;
}

- (UILabel *)in_p_lb
{
    if (!_in_p_lb) {
        _in_p_lb = [UILabel z_frame:CGRectMake(20, self.in_lb.bottom + 6, 35, 21)
                               Text:@"P0_A"
                           fontSize:11
                              color:[UIColor colorWithHex:@"#26C464"]
                             isbold:NO
                       cornerRadius:4
                    backgroundColor:[UIColor colorWithHex:@"#26C464" alpha:0.11]
                    ];
        _in_p_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _in_p_lb;
}

- (UILabel *)in_ty_lb
{
    if (!_in_ty_lb) {
        _in_ty_lb = [UILabel z_frame:CGRectMake(self.in_p_lb.right + 6, 0, 92, 21)
                                Text:@"CH8_DUP_M12"
                            fontSize:11
                               color:[UIColor colorWithHex:@"#4D8CEB"]
                              isbold:NO
                        cornerRadius:4
                     backgroundColor:[UIColor colorWithHex:@"#4D8CEB" alpha:0.19]
                     ];
        _in_ty_lb.centerY = self.in_p_lb.centerY;
        _in_ty_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _in_ty_lb;
}

- (UILabel *)in_tl_lb
{
    if (!_in_tl_lb) {
        _in_tl_lb = [UILabel z_frame:CGRectMake(self.in_ty_lb.right + 6, 0, 92, 21)
                                Text:@"高温保护电闸"
                            fontSize:11
                               color:[UIColor colorWithHex:@"#AE63EE"]
                              isbold:NO
                        cornerRadius:4
                     backgroundColor:[UIColor colorWithHex:@"#AE63EE" alpha:0.17]
                     ];
        _in_tl_lb.centerY = self.in_ty_lb.centerY;
        _in_tl_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _in_tl_lb;
}




- (UILabel *)out_lb
{
    if (!_out_lb) {
        _out_lb = [UILabel z_frame:CGRectMake(20, self.in_p_lb.bottom + 15, 30, 21)
                             Text:@"OUT"
                         fontSize:11
                            color:[UIColor colorWithHex:@"#646F69"]
                           isbold:NO
                     cornerRadius:4
                  backgroundColor:[UIColor colorWithHex:@"#F6F8FA"]
                  ];
        _out_lb.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
        _out_lb.layer.borderWidth = 1;
        _out_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _out_lb;
}

- (UILabel *)out_channel_lb
{
    if (!_out_channel_lb) {
        _out_channel_lb = [UILabel z_frame:CGRectMake(self.out_lb.right + 5, 0, 150, 20)
                                     Text:@"module_0 channel_2"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
        _out_channel_lb.centerY = self.out_lb.centerY;
    }
    return _out_channel_lb;
}

- (UILabel *)out_p_lb
{
    if (!_out_p_lb) {
        _out_p_lb = [UILabel z_frame:CGRectMake(20, self.out_lb.bottom + 6, 35, 21)
                               Text:@"P0_A"
                           fontSize:11
                              color:[UIColor colorWithHex:@"#26C464"]
                             isbold:NO
                       cornerRadius:4
                    backgroundColor:[UIColor colorWithHex:@"#26C464" alpha:0.11]
                    ];
        _out_p_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _out_p_lb;
}

- (UILabel *)out_ty_lb
{
    if (!_out_ty_lb) {
        _out_ty_lb = [UILabel z_frame:CGRectMake(self.in_p_lb.right + 6, 0, 92, 21)
                                Text:@"CH8_DUP_M12"
                            fontSize:11
                               color:[UIColor colorWithHex:@"#4D8CEB"]
                              isbold:NO
                        cornerRadius:4
                     backgroundColor:[UIColor colorWithHex:@"#4D8CEB" alpha:0.19]
                     ];
        _out_ty_lb.centerY = self.out_p_lb.centerY;
        _out_ty_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _out_ty_lb;
}

- (UILabel *)out_tl_lb
{
    if (!_out_tl_lb) {
        _out_tl_lb = [UILabel z_frame:CGRectMake(self.in_ty_lb.right + 6, 0, 92, 21)
                                Text:@"高温保护电闸"
                            fontSize:11
                               color:[UIColor colorWithHex:@"#AE63EE"]
                              isbold:NO
                        cornerRadius:4
                     backgroundColor:[UIColor colorWithHex:@"#AE63EE" alpha:0.17]
                     ];
        _out_tl_lb.centerY = self.out_ty_lb.centerY;
        _out_tl_lb.textAlignment = NSTextAlignmentCenter;
    }
    return _out_tl_lb;
}


@end
