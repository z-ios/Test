//
//  SingSendLogInfoView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/26.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingSendLogInfoView.h"

@interface SingSendLogInfoView ()

@property (nonatomic, strong) UIView* sendView;
@property (nonatomic, strong) UIView* configView;

@property (nonatomic, strong) UILabel* tl_label;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* cannelBtn;

@property (nonatomic, strong) UILabel* config_tl_label;
@property (nonatomic, strong) UITextView* config_textView;


@end
@implementation SingSendLogInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    [self addSubview:self.cannelBtn];
    [self addSubview:self.sendView];
    [self addSubview:self.configView];
    [self.sendView addSubview:self.tl_label];
    [self.sendView addSubview:self.textView];
    [self.configView addSubview:self.config_tl_label];
    [self.configView addSubview:self.config_textView];
    
}

- (void)setJsonStr:(NSString *)jsonStr
{
    _jsonStr = jsonStr;
    
    if (_jsonStr) {
        NSData *jsonData = [_jsonStr dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        NSData *jsonDat = [NSJSONSerialization dataWithJSONObject:dic
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];

        NSString * str = [[NSString alloc] initWithData:jsonDat encoding:NSUTF8StringEncoding];
        
        _textView.text = str;
    }
    
}

- (void)setConfigJsonStr:(NSString *)configJsonStr
{
    _configJsonStr = configJsonStr;
    
    if (_configJsonStr) {
        NSData *jsonData = [_configJsonStr dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        NSData *jsonDat = [NSJSONSerialization dataWithJSONObject:dic
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];

        NSString * str = [[NSString alloc] initWithData:jsonDat encoding:NSUTF8StringEncoding];
        
        _config_textView.text = str;
    }
    
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

- (UIView *)sendView
{
    if (!_sendView) {
        _sendView = [[UIView alloc] initWithFrame:CGRectMake(0, self.cannelBtn.bottom, self.width, (self.height - 20 - 36)*0.5)];
    }
    return _sendView;
}

- (UIView *)configView
{
    if (!_configView) {
        _configView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sendView.bottom, self.width,self.sendView.height)];
    }
    return _configView;
}

- (UILabel *)tl_label
{
    if (!_tl_label) {
        _tl_label = [UILabel z_frame:CGRectMake(20 ,0, self.width * 0.5, 33)
                                Text:@"下发JSON"
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
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.tl_label.bottom + 15, self.width - 40, self.sendView.height - (self.tl_label.bottom + 15+25))];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _textView.layer.cornerRadius = 6;
    }
    
    return _textView;
}

- (UILabel *)config_tl_label
{
    if (!_config_tl_label) {
        _config_tl_label = [UILabel z_frame:CGRectMake(20 ,0, self.width * 0.5, 33)
                                Text:@"配置JSON"
                            fontSize:24
                               color:[UIColor colorWithHex:@"#121212"]
                              isbold:NO
                     ];
    }
    return _config_tl_label;
}

- (UITextView *)config_textView
{
    if (!_config_textView) {
        _config_textView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.config_tl_label.bottom + 15, self.width - 40, self.sendView.height - (self.tl_label.bottom + 15+25))];
        _config_textView.editable = NO;
        _config_textView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _config_textView.layer.cornerRadius = 6;
    }
    
    return _config_textView;
}





@end
