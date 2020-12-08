//
//  SmallFormulaConfigView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallFormulaConfigView.h"
#import "SmallFormulaSelectView.h"
#import "SmallFormulaModel.h"

@interface SmallFormulaConfigView ()<UITextFieldDelegate,DevicePtc>

@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* moreInfo_btn;
@property (nonatomic, strong) UIButton* sure_btn;
@property (nonatomic, strong) UILabel* name_t_lb;
@property (nonatomic, strong) UITextField* name_tf;
@property (nonatomic, strong) UILabel* formula_t_lb;
@property (nonatomic, strong) UILabel* formula_lb;
@property (nonatomic, strong) UILabel* formula_l_lb;
@property (nonatomic, copy) NSString* unit;

@end
@implementation SmallFormulaConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  whiteColor];
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.titleLb];
    [self addSubview:self.moreInfo_btn];
    [self addSubview:self.name_t_lb];
    [self addSubview:self.name_tf];
    [self addSubview:self.formula_t_lb];
    [self addSubview:self.formula_lb];
    [self addSubview:self.formula_l_lb];
    [self addSubview:self.sure_btn];

}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    _name_tf.text = _dict[@"formulaname"];
    _formula_t_lb.text = [NSString stringWithFormat:@"%@（%@：%@）",NSLocalizedString(@"公式", nil),NSLocalizedString(@"单位", nil),dict[@"unit"]];
    _formula_lb.text = _dict[@"formula"];
    _unit = dict[@"unit"];
    
}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _name_tf) {
        
        [CenterNet.shared checkFormulaCompletionParm:_group_id completion:^(NSArray * _Nullable dataList) {
            NSArray* modelList = [NSArray yy_modelArrayWithClass:[SmallFormulaModel class] json:dataList];
            SmallFormulaSelectView* eview = [[SmallFormulaSelectView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 495)];
            eview.delegate = self;
            eview.formulaDatas = modelList;
            NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
            nkView.contentView = eview;
            [nkView show];
        }];
        
        return NO;
    }
    return YES;
}

#pragma mark - Delegate
- (void)selectFormulaName:(NSString *)formulaName unitStr:(NSString *)unitStr formulaStr:(NSString *)formulaStr createtime:(nonnull NSString *)createtime
{
    _name_tf.text = formulaName;
    _formula_t_lb.text = [NSString stringWithFormat:@"%@（%@：%@）",NSLocalizedString(@"公式", nil),NSLocalizedString(@"单位", nil),unitStr];
    _formula_lb.text = formulaStr;
    _unit = unitStr;
}

- (void)cancelBtnClick
{
   [self dismissView];
}

- (void)moreInfo_btnClick
{
    [DescriptionMaskView showPageViewWithtype:SmallGs];
}

- (void)sure_btnClick
{
    NSDictionary* dict = @{
      @"group_id": _group_id,
      @"formulaname": _name_tf.text,
      @"formula": _formula_lb.text,
      @"unit": _unit,
    };
    [CenterNet.shared saveFormulaCompletionParm:dict deviceId:_dict[@"device_id"] channelName:_dict[@"channelname"] completion:^(BOOL success) {
        [self dismissView];
    }];

}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    }];
    [UIView animateWithDuration:0.8 animations:^{
        self.x = zScreenWidth;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, self.cancelBtn.bottom + 25, 0, 48) Text:NSLocalizedString(@"公式配置", nil) fontSize:SPFont(30) color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_titleLb sizeToFit];
    }
    return _titleLb;
}

- (UIButton *)moreInfo_btn
{
    if (!_moreInfo_btn) {
        _moreInfo_btn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleLb.right + 15, 0, 24, 24)];
        [_moreInfo_btn setImage:[SVGKImage imageNamed:@"icon_confi_information"].UIImage forState:UIControlStateNormal];
        _moreInfo_btn.centerY = self.titleLb.centerY;
        [_moreInfo_btn addTarget:self action:@selector(moreInfo_btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _moreInfo_btn;
}


- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 52, 36, 36)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_back_big"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)name_t_lb
{
    if (!_name_t_lb) {
        _name_t_lb = [UILabel z_frame:CGRectMake(25, self.titleLb.bottom +25, 100, 20) Text:NSLocalizedString(@"公式名", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
       }
       return _name_t_lb;
}

- (UITextField *)name_tf
{
    if (!_name_tf) {
        _name_tf = [UITextField  z_frame:CGRectMake(25, self.name_t_lb.bottom + 5, self.width - 40, 52)
                                 bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                            cornerRadius:6
                             borderWidth:0
                             borderColor:nil
                                    text:nil
                                textFont:[UIFont systemFontOfSize:17]
                               textColor:[UIColor colorWithHex:@"#121212"]
                             placeholder:NSLocalizedString(@"选择公式名称", nil)
                         placeholderFont:nil
                        placeholderColor:nil
                             leftImgName:nil
                             leftImgSize:CGSizeZero
                            rightImgName:@"icon_arrow_dropdown"
                            rightImgSize:CGSizeMake(40, 24)
                    ];
        
        _name_tf.delegate = self;
    }
    return _name_tf;
}

- (UILabel *)formula_t_lb
{
    if (!_formula_t_lb) {
        _formula_t_lb = [UILabel z_frame:CGRectMake(25, self.name_tf.bottom + 15, 200, 20) Text:@"公式（单位：ppm）" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _formula_t_lb;
}

- (UILabel *)formula_lb
{
    if (!_formula_lb) {
        _formula_lb = [UILabel z_frame:CGRectMake(45, self.formula_t_lb.bottom + 20, self.width - 90, 40) Text:@"X*3.2-78" fontSize:28 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        _formula_lb.textAlignment = NSTextAlignmentCenter;
        
       }
       return _formula_lb;
}

- (UILabel *)formula_l_lb
{
    if (!_formula_l_lb) {
        _formula_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(45, self.formula_lb.bottom + 15, self.width - 90, 1)];
        _formula_l_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _formula_l_lb;
}



- (UIButton *)sure_btn
{
    if (!_sure_btn) {
        _sure_btn = [UIButton z_frame:CGRectMake(25, self.formula_l_lb.bottom + 50,self.width - 50 , 52)
                             fontSize:18
                         cornerRadius:6
                      backgroundColor:[UIColor colorWithHex:@"#26C464"]
                           titleColor:[UIColor colorWithHex:@"#FFFFFF"]
                                title:NSLocalizedString(@"确定", nil)
                               isbold:YES
                               Target:self
                               action:@selector(sure_btnClick)
                     ];
    }
    
    return _sure_btn;
}



@end
