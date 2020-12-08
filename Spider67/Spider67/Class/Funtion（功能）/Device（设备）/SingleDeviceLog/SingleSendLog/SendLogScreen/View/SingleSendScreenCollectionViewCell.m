//
//  SingleSendScreenCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleSendScreenCollectionViewCell.h"
#import "SingleSendItemModel.h"

@interface SingleSendScreenCollectionViewCell ()

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UIButton* cancelBtn;

@end
@implementation SingleSendScreenCollectionViewCell

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
    self.layer.cornerRadius = 4;
    [self addSubview:self.title_lb];
    [self addSubview:self.cancelBtn];
    
}

- (void)cancelBtnClick
{
    if ([self.delegate respondsToSelector:@selector(delAlarmItemIndexPath:)]) {
        [self.delegate delAlarmItemIndexPath:_cellPath];
    }
}

- (void)setModel:(SingleSendItemModel *)model
{
    _model = model;

    _title_lb.text = _model.sendName;
    _title_lb.width = model.itemW - 65;
    _cancelBtn.x = self.width - 24 - 15;
    
}

#pragma mark - lazy

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(15, (self.height - 20)*0.5, 0, 20) Text:@"" fontSize:14 color:[UIColor colorWithHex:@"#3F4248"] isbold:NO];
    }
    return _title_lb;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 24 - 15,(self.height - 24)*0.5 , 24, 24)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_empty"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}


@end
