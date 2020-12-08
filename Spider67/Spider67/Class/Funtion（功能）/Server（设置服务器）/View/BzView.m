//
//  BzView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BzView.h"

@interface BzView ()

@property (nonatomic, strong) UIView* bzV;
@property (nonatomic, strong) UIButton* beizhuBtn;
@property (nonatomic, strong) UILabel* beizhuLine;

@end
@implementation BzView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}

- (void)setBzW:(CGFloat)bzW
{
    _bzW = bzW;
    _bzV.width = bzW;
    _beizhuLine.hidden = YES;
    _beizhuBtn.hidden = YES;
    _beizhuTf.width = bzW;

}

- (void)setupUI{
    
    UILabel* beiZhuLb = [UILabel z_frame:CGRectMake(0,0, SPW(100), SPH(20))
                                   Text:NSLocalizedString(@"备注", nil)
                               fontSize:SPFont(14)
                                  color:[UIColor colorWithHex:@"#808080"]
                                 isbold:NO
                        ];
    [self addSubview:beiZhuLb];

    UIView* beizhuView = [[UIView alloc] initWithFrame:CGRectMake(0, beiZhuLb.bottom + 3, self.width, SPH(48))];
    beizhuView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    beizhuView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    beizhuView.layer.borderWidth = 0.5;
    beizhuView.layer.cornerRadius = 4;
    [self addSubview:beizhuView];
    _bzV = beizhuView;


    UIButton* beizhuBtn = [[UIButton alloc] initWithFrame:CGRectMake(beizhuView.width - SPH(48), 0, SPH(48), SPH(48))];
    [beizhuBtn setImage:[UIImage imageNamed:@"icon_server"] forState:UIControlStateNormal];
    [beizhuView addSubview:beizhuBtn];
    _beizhuBtn = beizhuBtn;
    [beizhuBtn addTarget:self action:@selector(beizhuBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel* beizhuLine = [[UILabel alloc] initWithFrame:CGRectMake(beizhuBtn.x - 0.5, 0, 0.5, beizhuView.height)];
    beizhuLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [beizhuView addSubview:beizhuLine];
    _beizhuLine = beizhuLine;

    UITextField* beizhuTf = [UITextField z_frame:CGRectMake(SPW(10), 0,beizhuLine.x - SPW(20), beizhuView.height)
                                         bgColor:nil
                                    cornerRadius:0
                                     borderWidth:0
                                     borderColor:0
                                            text:nil
                                        textFont:[UIFont systemFontOfSize:SPH(17)]
                                       textColor:[UIColor colorWithHex:@"#121212"]
                                     placeholder:NSLocalizedString(@"备注", nil)
                                 placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                     leftImgName:nil
                                     leftImgSize:CGSizeZero
                                    rightImgName:nil
                                    rightImgSize:CGSizeZero
                             ];

    [beizhuView addSubview:beizhuTf];
    _beizhuTf = beizhuTf;
    
}

- (void)beizhuBtnClick
{
    if ([self.delegate respondsToSelector:@selector(showServerList)]) {
        [self.delegate showServerList];
    }
}

@end
