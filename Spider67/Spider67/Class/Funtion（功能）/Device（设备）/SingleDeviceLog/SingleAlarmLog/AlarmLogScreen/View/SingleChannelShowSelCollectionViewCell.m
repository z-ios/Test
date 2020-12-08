//
//  SingleChannelShowSelCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleChannelShowSelCollectionViewCell.h"
#import "ChannelListModel.h"

@interface SingleChannelShowSelCollectionViewCell ()

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UIButton* cancelBtn;

@end
@implementation SingleChannelShowSelCollectionViewCell

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

- (void)setModel:(ChannelListModel *)model
{
    _model = model;

    _title_lb.text = _model.port;
    _cancelBtn.x = self.width - 24 - 10;
    
}

#pragma mark - lazy


- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(15, (self.height - 24)*0.5, 40, 24) Text:@"" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _title_lb;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 24 - 10,(self.height - 24)*0.5 , 24, 24)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_empty"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}



@end
