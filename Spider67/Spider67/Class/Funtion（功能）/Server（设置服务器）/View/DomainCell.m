//
//  DomainCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DomainCell.h"

@interface DomainCell ()

@property (nonatomic, strong) UIButton* bBtn;
@property (nonatomic, strong) UILabel* bLine;


@end
@implementation DomainCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setupUI];

    }
    return self;
}

- (void)setIpW:(CGFloat)ipW
{
    _ipW = ipW;
    if (ipW == 48) {
        _bBtn.hidden = YES;
        _bLine.hidden = YES;
        _domainTf.width = self.width;
    }
    
}

- (void)setupUI
{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 4;
    
    UIButton* domainBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - SPH(48), 0, SPH(48), SPH(48))];
    [domainBtn setImage:[UIImage imageNamed:@"icon_server"] forState:UIControlStateNormal];
    [self addSubview:domainBtn];
    _bBtn = domainBtn;
    [domainBtn addTarget:self action:@selector(domainBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel* bLine = [[UILabel alloc] initWithFrame:CGRectMake(domainBtn.x - 0.5, 0, 0.5, self.height)];
    bLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [self addSubview:bLine];
    _bLine = bLine;

    UITextField* domainTf = [UITextField z_frame:CGRectMake(SPW(10), 0,bLine.x - SPW(20), self.height)
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
//    domainTf.textAlignment = NSTextAlignmentCenter; //水平左对齐
    [self addSubview:domainTf];
    _domainTf = domainTf;
}

- (void)domainBtnClick
{
    if ([self.delegate respondsToSelector:@selector(ipshowServerList)]) {
        [self.delegate ipshowServerList];
    }
}

@end
