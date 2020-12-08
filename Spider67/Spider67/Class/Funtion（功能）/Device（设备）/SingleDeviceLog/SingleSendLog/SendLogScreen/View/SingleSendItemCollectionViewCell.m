//
//  SingleSendItemCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleSendItemCollectionViewCell.h"
#import "SingleSendItemModel.h"

@interface SingleSendItemCollectionViewCell ()

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UIImageView* imgV;

@end
@implementation SingleSendItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.layer.cornerRadius = 22;
    [self addSubview:self.title_lb];
    [self addSubview:self.imgV];
    
}


- (void)setModel:(SingleSendItemModel *)model
{
    _model = model;
    
    _title_lb.text = _model.sendName;
    _title_lb.width = model.itemW - 65;
    if (model.isSel) {
        _imgV.image = [SVGKImage imageNamed:@"icon_set_allert_check"].UIImage;
        self.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        _title_lb.textColor = [UIColor whiteColor];
    }else{
        _imgV.image = [SVGKImage imageNamed:@"icon_add"].UIImage;
        self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _title_lb.textColor = [UIColor colorWithHex:@"#3F4248"];
    }
    _imgV.x = self.width - 24 - 15;
    
}

#pragma mark - lazy

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(15, (self.height - 20)*0.5, 0, 20) Text:@"" fontSize:14 color:[UIColor colorWithHex:@"#3F4248"] isbold:NO];
    }
    return _title_lb;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 24 - 15,(self.height - 24)*0.5 , 24, 24)];
    }
    return _imgV;
}



@end
