//
//  PortView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PortView.h"

@interface PortView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView* pView;
@property (nonatomic, strong) UIButton* pBtn;
@property (nonatomic, strong) UILabel* pLine;

@end
@implementation PortView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}

- (void)setPortW:(CGFloat)portW
{
    _portW = portW;
    _pView.width = portW;
    _pBtn.hidden = YES;
    _pLine.hidden = YES;
    _ptf.width = _pView.width - 20;
}


- (void)setupUI{
    
    UILabel* portLb = [UILabel z_frame:CGRectMake(0,0, SPW(100), SPH(20))
                                   Text:@"Port"
                               fontSize:14
                                  color:[UIColor colorWithHex:@"#808080"]
                                 isbold:NO
                        ];
    [self addSubview:portLb];

    UIView* pView = [[UIView alloc] initWithFrame:CGRectMake(0, portLb.bottom + 3, SPW(180), SPH(48))];
    pView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    pView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    pView.layer.borderWidth = 0.5;
    pView.layer.cornerRadius = 4;
    [self addSubview:pView];
    _pView = pView;

    UIButton* pBtn = [[UIButton alloc] initWithFrame:CGRectMake(pView.width - SPH(48), 0, SPH(48), SPH(48))];
    [pBtn setImage:[UIImage imageNamed:@"icon_server"] forState:UIControlStateNormal];
    [pView addSubview:pBtn];
    _pBtn = pBtn;
    [pBtn addTarget:self action:@selector(pBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel* pLine = [[UILabel alloc] initWithFrame:CGRectMake(pBtn.x - 0.5, 0, 0.5, pView.height)];
    pLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [pView addSubview:pLine];
    _pLine = pLine;

    UITextField* pTf = [UITextField z_frame:CGRectMake(SPW(10), 0,pLine.x - SPW(20), pView.height)
                bgColor:nil
           cornerRadius:0
       borderWidth:0
            borderColor:nil
                   text:nil
               textFont:[UIFont systemFontOfSize:SPH(17)]
              textColor:[UIColor colorWithHex:@"#121212"]
            placeholder:nil
        placeholderFont:[UIFont systemFontOfSize:SPH(17)]
       placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
            leftImgName:nil
            leftImgSize:CGSizeZero
           rightImgName:nil
           rightImgSize:CGSizeZero
    ];
   
    [pView addSubview:pTf];
    _ptf = pTf;
    pTf.delegate = self;
    pTf.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_ptf.text.length >= 3) {
         self.ptf.text = [textField.text substringToIndex:3];
    }
    return YES;
}

- (void)pBtnClick
{
    if ([self.delegate respondsToSelector:@selector(showServerList)]) {
          [self.delegate showServerList];
      }
}

@end
