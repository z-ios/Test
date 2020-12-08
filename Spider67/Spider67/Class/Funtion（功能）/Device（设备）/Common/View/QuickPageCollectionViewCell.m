//
//  QuickPageCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import "QuickPageCollectionViewCell.h"
#import "PageModel.h"

@interface QuickPageCollectionViewCell ()

@property (nonatomic, strong) UILabel* text_lb;

@end
@implementation QuickPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.06];
    self.layer.cornerRadius = 14;
    [self addSubview:self.text_lb];
    
}
- (void)setModel:(PageModel *)model
{
    _model = model;
    
    self.text_lb.text = _model.pageNumStr;
    
    if (_model.isSel) {
        self.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        self.text_lb.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.06];
        self.text_lb.textColor = [UIColor colorWithHex:@"#646664"];
    }
    
    self.text_lb.frame = self.bounds;
}


- (UILabel *)text_lb
{
    if (!_text_lb) {
        _text_lb = [UILabel z_frame:self.bounds Text:@"" fontSize:14 color:[UIColor colorWithHex:@"#646664"] isbold:YES];
        _text_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _text_lb;
}

@end
