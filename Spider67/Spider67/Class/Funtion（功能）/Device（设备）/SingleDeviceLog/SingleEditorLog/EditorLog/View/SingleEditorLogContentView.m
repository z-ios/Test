//
//  SingleEditorLogContentView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleEditorLogContentView.h"

@interface SingleEditorLogContentView ()

@property (nonatomic, strong) UILabel* tl_label;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* cannelBtn;

@end
@implementation SingleEditorLogContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    
    self.textView.text = _contentStr;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    
    [self addSubview:self.tl_label];
    [self addSubview:self.cannelBtn];
    [self addSubview:self.textView];
}

- (void)cannelBtnClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
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

- (UILabel *)tl_label
{
    if (!_tl_label) {
        _tl_label = [UILabel z_frame:CGRectMake(20 ,30, self.width * 0.5, 33)
                                Text:@"编辑内容"
                            fontSize:24
                               color:[UIColor colorWithHex:@"#121212"]
                              isbold:NO
                     ];
    }
    return _tl_label;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.tl_label.bottom + 15, self.width - 40, self.height - (self.tl_label.bottom + 15+25))];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor colorWithHex:@"#FEF8EF"];
        _textView.layer.cornerRadius = 6;
    }
    
    return _textView;
}

@end
