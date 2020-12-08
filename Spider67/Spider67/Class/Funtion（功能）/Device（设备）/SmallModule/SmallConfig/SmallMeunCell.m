//
//  SmallMeunCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallMeunCell.h"

@interface SmallMeunCell ()

@property (nonatomic, strong) UIButton* btn_imgV;
@property (nonatomic, strong) UILabel* titleLb;

@end
@implementation SmallMeunCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 73;
        self.width = zScreenWidth;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];

    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    [_btn_imgV setImage:[SVGKImage imageNamed:dict[@"imgname"]].UIImage forState:UIControlStateNormal];
    _titleLb.text = dict[@"name"];
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.btn_imgV];
    [self addSubview:self.titleLb];

    
}

#pragma mark - lazy

- (UIButton *)btn_imgV
{
    if (!_btn_imgV) {
        _btn_imgV = [[UIButton alloc] initWithFrame:CGRectMake(25, (self.height - 42)*0.5, 42, 42)];
        _btn_imgV.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        _btn_imgV.layer.cornerRadius = 16;
        _btn_imgV.layer.masksToBounds = YES;
    }
    return _btn_imgV;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(self.btn_imgV.right + 15, (self.height - 24)*0.5, self.width*0.5, 24) Text:@"--" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _titleLb;
}

@end
