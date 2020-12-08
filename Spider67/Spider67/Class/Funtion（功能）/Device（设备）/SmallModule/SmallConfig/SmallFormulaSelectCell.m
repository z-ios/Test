//
//  SmallFormulaSelectCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallFormulaSelectCell.h"
#import "SmallFormulaModel.h"

@interface SmallFormulaSelectCell ()

@property (nonatomic, strong) UILabel* name_lb;
@property (nonatomic, strong) UILabel* unit_lb;
@property (nonatomic, strong) UILabel* formula_lb;
@property (nonatomic, strong) UIImageView* selectImgV;

@end
@implementation SmallFormulaSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.height = 101;
//        self.width = zScreenWidth - 50;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(SmallFormulaModel *)model
{
    _model = model;
    _name_lb.text = model.formulaname;
    _formula_lb.text = model.formula;
    if ([model.unit isEqualToString:@""]) {
        _unit_lb.width = 0;
    }else{
        _unit_lb.text = [NSString stringWithFormat:@"单位：%@",model.unit];
        CGSize sizeNew = [_unit_lb.text sizeWithAttributes:@{NSFontAttributeName:_unit_lb.font}];
           _unit_lb.width = sizeNew.width + 20;
    }
   
    if (model.isSelected) {
        _selectImgV.hidden = NO;
        _name_lb.textColor = [UIColor colorWithHex:@"#26C464"];
        _unit_lb.textColor = [UIColor colorWithHex:@"#26C464"];
        _unit_lb.backgroundColor = [UIColor colorWithHex:@"#26C464" alpha:0.13];
        _formula_lb.textColor = [UIColor colorWithHex:@"#26C464"];
        
    }else{
        _selectImgV.hidden = YES;
        _name_lb.textColor = [UIColor colorWithHex:@"#808080"];
        _unit_lb.textColor = [UIColor colorWithHex:@"#646664"];
        _unit_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.06];
        _formula_lb.textColor = [UIColor colorWithHex:@"#121212"];
    }
}

- (void)setupUI
{
    [self addSubview:self.name_lb];
    [self addSubview:self.unit_lb];
    [self addSubview:self.formula_lb];
    [self addSubview:self.selectImgV];
    
}

- (UILabel *)name_lb
{
    if (!_name_lb) {
        _name_lb = [UILabel z_frame:CGRectMake(20, 20, 100, 20)
                               Text:@"牛顿第三定律"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
    }
    return _name_lb;
}

- (UILabel *)unit_lb
{
    if (!_unit_lb) {
        _unit_lb = [UILabel z_frame:CGRectMake(self.name_lb.right + 10, 0, 110, 26)
                               Text:[NSString stringWithFormat:@"%@：ppm",NSLocalizedString(@"单位", nil)]
                           fontSize:14
                              color:[UIColor colorWithHex:@"#646664"]
                             isbold:NO
                       cornerRadius:13
                    backgroundColor:[UIColor colorWithHex:@"#000000" alpha:0.06]
                    ];
        _unit_lb.textAlignment = NSTextAlignmentCenter;
        _unit_lb.centerY = self.name_lb.centerY;
    }
    return _unit_lb;
}



- (UILabel *)formula_lb
{
    if (!_formula_lb) {
        _formula_lb = [UILabel z_frame:CGRectMake(20, self.name_lb.bottom + 12, self.width - 20, 33)
                                Text:@"牛顿第三定律"
                            fontSize:24
                               color:[UIColor colorWithHex:@"#121212"]
                              isbold:NO
                     ];
     }
     return _formula_lb;
}

- (UIImageView *)selectImgV
{
    if (!_selectImgV) {
        _selectImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 24-25, (self.height - 24)*0.5, 24, 24)];
        _selectImgV.image = [SVGKImage imageNamed:@"icon_check"].UIImage;
        _selectImgV.hidden = YES;
    }
    return _selectImgV;
}


@end
