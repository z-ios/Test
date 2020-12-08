//
//  TuoJiCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TuoJiCell.h"

@interface TuoJiCell ()

@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* subTitleLb;

@end
@implementation TuoJiCell
{
    UIImageView* arrowImgV;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    _imgV.image = [UIImage imageNamed:dict[@"img"]];
    _titleLb.text = dict[@"title"];
    _subTitleLb.text = dict[@"subtitle"];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgV.frame = CGRectMake(SPW(19), (self.height - SPH(44))*0.5, SPH(44), SPH(44));
    _titleLb.frame = CGRectMake(_imgV.right + SPW(18), SPH(27), SPW(170), SPH(24));
    _subTitleLb.frame = CGRectMake(_imgV.right + SPW(18), _titleLb.bottom + SPH(3), SPW(170), SPH(20));
    arrowImgV.frame = CGRectMake(self.width - SPH(24) - SPW(26), (self.height - SPH(24))*0.5, SPH(24), SPH(24));
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.layer.cornerRadius = 16;
    
    UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SPW(19), (self.height - SPH(44))*0.5, SPH(44), SPH(44))];
    imgV.image = [UIImage imageNamed:@"app_demo"];
    [self addSubview:imgV];
    _imgV = imgV;
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(imgV.right + SPW(18), SPH(27), SPW(170), SPH(24))
                                   Text:NSLocalizedString(@"spider67演示箱", nil)
                               fontSize:SPFont(17)
                                  color:[UIColor colorWithHex:@"#121212"]
                                 isbold:NO
                        ];
    [self addSubview:titleLb];
    _titleLb = titleLb;
   
    
    UILabel* subTitleLb = [UILabel z_frame:CGRectMake(imgV.right + SPW(18), titleLb.bottom + SPH(3), SPW(170), SPH(20))
                                   Text:NSLocalizedString(@"互动样品箱", nil)
                               fontSize:SPFont(14)
                                  color:[UIColor colorWithHex:@"#808080"]
                                 isbold:NO
                        ];
    [self addSubview:subTitleLb];
    _subTitleLb = subTitleLb;
    
    arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - SPH(24) - SPW(26), (self.height - SPH(24))*0.5, SPH(24), SPH(24))];
    arrowImgV.image = [UIImage imageNamed:@"icon_arrow_more"];
    [self addSubview:arrowImgV];
    
    
   
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 16;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 32;
    [super setFrame:frame];
}

@end
