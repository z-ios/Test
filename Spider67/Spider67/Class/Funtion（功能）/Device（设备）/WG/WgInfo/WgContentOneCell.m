//
//  WgContentOneCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgContentOneCell.h"
#import "ModulesListModel.h"

@interface WgContentOneCell ()

@property (nonatomic, strong) UIView* mod0View;
@property (nonatomic, strong) UIView* mod1View;

@property (nonatomic, strong) UIImageView* mod0ImgV;
@property (nonatomic, strong) UIImageView* mod1ImgV;

@property (nonatomic, strong) UILabel* mod0NameLb;
@property (nonatomic, strong) UILabel* mod1NameLb;

@property (nonatomic, strong) UILabel* mod0TypeLb;
@property (nonatomic, strong) UILabel* mod1TypeLb;


@end
@implementation WgContentOneCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.origin.y += 10;
    frame.size.height = 129 - 10;
    frame.size.width = zScreenWidth - 40;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 129;
        self.width = zScreenWidth;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel0:(ModulesListModel *)model0
{
    _model0 = model0;
    self.mod0NameLb.text = _model0.modulename;
    self.mod0TypeLb.text = _model0.moduletype;
}

- (void)setModel1:(ModulesListModel *)model1
{
    _model1 = model1;
    self.mod1NameLb.text = _model0.modulename;
    self.mod1TypeLb.text = _model1.moduletype;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self addSubview:self.mod0View];
    [self addSubview:self.mod1View];
    [self.mod0View addSubview:self.mod0ImgV];
    [self.mod1View addSubview:self.mod1ImgV];
    [self.mod0View addSubview:self.mod0NameLb];
    [self.mod1View addSubview:self.mod1NameLb];
    [self.mod0View addSubview:self.mod0TypeLb];
    [self.mod1View addSubview:self.mod1TypeLb];
    
}


#pragma mark - lazy

- (UIView *)mod0View
{
    if (!_mod0View) {
        _mod0View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.width - 10)*0.5, self.height)];
        _mod0View.layer.cornerRadius = 12;
        _mod0View.backgroundColor = [UIColor whiteColor];
    }
    return _mod0View;
}

- (UIView *)mod1View
{
    if (!_mod1View) {
        _mod1View = [[UIView alloc] initWithFrame:CGRectMake(self.mod0View.right + 10, 0, self.mod0View.width, self.height)];
        _mod1View.layer.cornerRadius = 12;
        _mod1View.backgroundColor = [UIColor whiteColor];
    }
    return _mod1View;
}

- (UIImageView *)mod0ImgV
{
    if (!_mod0ImgV) {
        _mod0ImgV = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 24, 24)];
        _mod0ImgV.image = [SVGKImage imageNamed:@"icon_info_label"].UIImage;
    }
    return _mod0ImgV;
}

- (UIImageView *)mod1ImgV
{
    if (!_mod1ImgV) {
        _mod1ImgV = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 24, 24)];
        _mod1ImgV.image = [SVGKImage imageNamed:@"icon_info_label"].UIImage;
    }
    return _mod1ImgV;
}

- (UILabel *)mod0NameLb
{
    if (!_mod0NameLb) {
        _mod0NameLb = [UILabel z_frame:CGRectMake(self.mod0ImgV.x, self.mod0ImgV.bottom + 10, 100, 24)
                                  Text:@"--"
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    }
    return _mod0NameLb;
}

- (UILabel *)mod1NameLb
{
    if (!_mod1NameLb) {
        _mod1NameLb = [UILabel z_frame:CGRectMake(self.mod1ImgV.x, self.mod1ImgV.bottom + 10, 100, 24)
                                  Text:@"--"
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    }
    return _mod1NameLb;
}

- (UILabel *)mod0TypeLb
{
    if (!_mod0TypeLb) {
        _mod0TypeLb = [UILabel z_frame:CGRectMake(self.mod0ImgV.x, self.mod0NameLb.bottom + 5, self.mod0View.width, 20)
                                     Text:@"--"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#808080"]
                                   isbold:NO
                          ];
       }
       return _mod0TypeLb;
}

- (UILabel *)mod1TypeLb
{
    if (!_mod1TypeLb) {
        _mod1TypeLb = [UILabel z_frame:CGRectMake(self.mod1ImgV.x, self.mod1NameLb.bottom + 5, self.mod1View.width, 20)
                                     Text:@"--"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#808080"]
                                   isbold:NO
                          ];
       }
       return _mod1TypeLb;
}

@end
