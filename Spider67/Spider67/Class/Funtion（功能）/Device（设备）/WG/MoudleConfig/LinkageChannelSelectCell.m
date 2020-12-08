//
//  LinkageChannelSelectCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LinkageChannelSelectCell.h"
#import "LinkageChannelSelectModel.h"

@interface LinkageChannelSelectCell ()

@property (nonatomic, strong) UILabel* port_lb;
@property (nonatomic, strong) UILabel* channel_lb;
@property (nonatomic, strong) UIImageView* selectImgV;

@end
@implementation LinkageChannelSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.height = 64;
//        self.width = zScreenWidth - 50;
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(LinkageChannelSelectModel *)model
{
    _model = model;
    _port_lb.text = model.port;
    _channel_lb.text = model.channelname;
    if (model.isSelected) {
        _selectImgV.hidden = NO;
        _port_lb.textColor = [UIColor colorWithHex:@"#26C464"];
        _channel_lb.textColor = [UIColor colorWithHex:@"#26C464"];
    }else{
        _selectImgV.hidden = YES;
        _port_lb.textColor = [UIColor colorWithHex:@"#121212"];
        _channel_lb.textColor = [UIColor colorWithHex:@"#121212"];
    }
}

- (void)setupUI
{
    [self addSubview:self.port_lb];
    [self addSubview:self.channel_lb];
    [self addSubview:self.selectImgV];
    
}

- (UILabel *)port_lb
{
    if (!_port_lb) {
        _port_lb = [UILabel z_frame:CGRectMake(20, (self.height - 24)*0.5, 40, 24)
                               Text:@"P0_B"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _port_lb;
}

- (UILabel *)channel_lb
{
    if (!_channel_lb) {
        _channel_lb = [UILabel z_frame:CGRectMake(self.port_lb.right + 10, (self.height - 24)*0.5, 170, 24)
                               Text:@"module_1 channel_5"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _channel_lb;
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
