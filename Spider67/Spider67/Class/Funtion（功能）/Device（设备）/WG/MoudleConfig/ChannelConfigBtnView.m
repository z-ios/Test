//
//  ChannelConfigBtnView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//


#define NeedNumCount 12   // 九宫格总个数
#define NeedNumberOfColumns 2   // 列数
#define NeedNumberOfRows 4  // 行数
#define NeedMargin 15   // 行_列间距
#define NeedStartMargin 0   // 首列起始间距
#define NeediPhoneXMargin    0 //首行起始距离

#import "ChannelConfigBtnView.h"

@interface ChannelConfigBtnView ()

@property (nonatomic, strong) UIButton* stepBtn;
@property (nonatomic, strong) NSMutableArray* btns;
@property (nonatomic, assign) NSInteger rows;

@end
@implementation ChannelConfigBtnView

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=  [UIColor whiteColor];
    }
    return self;
}

- (void)setBtnNames:(NSArray *)btnNames
{
    _btnNames = btnNames;
    
    if (btnNames.count > 2) {
        _rows = 2;
    }else{
        _rows = 1;
    }
    
    [self setupBtns];
}


- (void)setupBtns
{
    //初始控件X、Y
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    //计算控件W、H
    /*
     每个控件的宽度 = 需求总宽度 / (列数 + 1)*间距，再除以列数
     */
    CGFloat btnW = (self.width - NeedMargin) / NeedNumberOfColumns;
    /*
     每个控件的高度 = 需求总高度 / (行数 + 1)*间距，再除以行数
     */
    CGFloat btnH = 64;
    
    for (int i=0; i<_btnNames.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //间隙 + 当前列数的值（总数取余得到） * （间隙 + 宽度）
        btnX = ((i) % NeedNumberOfColumns) * (15 + btnW);
        //间隙 + 当前行数的值（总数整除得到） * （间隙 + 高度)+首行起始距离
        btnY = ((i) / NeedNumberOfColumns) * (15 + btnH);
        
        //设置位置
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:self.btnNames[i] forState:UIControlStateNormal];
        //文字
        btn.titleLabel.textAlignment = 1 ;
        btn.tag = i ;
        //背景
        btn.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        [btn setTitleColor:[UIColor colorWithHex:@"#121212"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        
        //事件
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(btn.width - 18, 0, 18, 18)];
        imgV.hidden = YES;
        imgV.image = [SVGKImage imageNamed:@"icon_checkbox"].UIImage;
        [btn addSubview:imgV];
        
        if ([btn.titleLabel.text isEqualToString:self.typeStr]) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
            imgV.hidden = NO;
        }else{
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
            imgV.hidden = YES;
        }
        
        NSMutableDictionary* dictM  =  [NSMutableDictionary dictionary];
        dictM[@"btn"] = btn;
        dictM[@"img"] = imgV;
        
        [self.btns addObject:dictM.copy];
    }
}

#pragma mark--点击事件
-(void)clickBtn:(UIButton *)sender{
    [self.btns enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton* btn = dict[@"btn"];
        UIImageView* imgV = dict[@"img"];
        if (sender == btn) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
            imgV.hidden = NO;
            self.typeStr = btn.titleLabel.text;
//            if ([self.delegate respondsToSelector:@selector(selectChannelType:)]) {
//                [self.delegate selectChannelType:btn.titleLabel.text];
//            }
        }else{
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
            imgV.hidden = YES;
        }
    }];
}


@end
