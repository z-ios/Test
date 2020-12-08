//
//  SingSelChannelTableViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingSelChannelTableViewCell.h"
#import "ChannelListModel.h"

@interface SingSelChannelTableViewCell ()

@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UIImageView* addImgV;
@property (nonatomic, strong) UILabel* port_lb;
@property (nonatomic, strong) UILabel* channelName_lb;
@property (nonatomic, strong) UILabel* channelTitle_lb;

@end
@implementation SingSelChannelTableViewCell

- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 16;
//    frame.origin.y += 15;
    frame.size.height = 105;
//    frame.size.width = zScreenWidth - 32;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        
    }
    
    return self;
}

- (void)setupUI
{
    
    self.layer.cornerRadius = 9;
    
    [self addSubview:self.imgV];
    [self addSubview:self.addImgV];
    [self addSubview:self.port_lb];
    [self addSubview:self.channelName_lb];
    [self addSubview:self.channelTitle_lb];
    
    
}

- (void)setModel:(ChannelListModel *)model
{
    _model = model;
    
    _port_lb.text = model.port;
    _channelName_lb.text = model.channelname;
    _channelTitle_lb.text = model.channeltitle;
    if (model.isSel) {
        _addImgV.image = [SVGKImage imageNamed:@"icon_set_allert_check"].UIImage;
        _imgV.image = [SVGKImage imageNamed:@"icon_sel_set_label"].UIImage;
        self.backgroundColor = [UIColor colorWithHex:@"#26C464"];
        self.port_lb.textColor = [UIColor whiteColor];
        self.channelName_lb.textColor = [UIColor whiteColor];
        self.channelTitle_lb.textColor = [UIColor whiteColor];
    }else{
        _addImgV.image = [SVGKImage imageNamed:@"icon_add"].UIImage;
        _imgV.image = [SVGKImage imageNamed:@"icon_set_screen"].UIImage;
        self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        self.port_lb.textColor = [UIColor colorWithHex:@"#121212"];
        self.channelName_lb.textColor = [UIColor colorWithHex:@"#808080"];
        self.channelTitle_lb.textColor = [UIColor colorWithHex:@"#808080"];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addImgV.frame = CGRectMake(self.width - 24 - 15, 0, 24, 24);
    _addImgV.centerY = self.imgV.centerY;
}

#pragma mark - lazy

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 17, 20, 20)];
        _imgV.image = [SVGKImage imageNamed:@"icon_set_screen"].UIImage;
    }
    return _imgV;
}

- (UIImageView *)addImgV
{
    if (!_addImgV) {
        _addImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 24 - 15, 0, 24, 24)];
        _addImgV.image = [SVGKImage imageNamed:@"icon_add"].UIImage;
        _addImgV.centerY = self.imgV.centerY;
       
    }
    return _addImgV;
}

- (UILabel *)port_lb
{
    if (!_port_lb) {
        _port_lb = [UILabel z_frame:CGRectMake(self.imgV.right + 8, 0, 40, 24) Text:@"P0 A" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        _port_lb.centerY = self.imgV.centerY;
    }
    return _port_lb;
}

- (UILabel *)channelName_lb
{
    if (!_channelName_lb) {
        _channelName_lb = [UILabel z_frame:CGRectMake(self.port_lb.x, self.port_lb.bottom + 8, 140, 20) Text:@"module_2 channel_0" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _channelName_lb;
}

- (UILabel *)channelTitle_lb
{
    if (!_channelTitle_lb) {
        _channelTitle_lb = [UILabel z_frame:CGRectMake(self.port_lb.x, self.channelName_lb.bottom + 3, 140, 20) Text:@"一号水池液位检测" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _channelTitle_lb;
}

@end
