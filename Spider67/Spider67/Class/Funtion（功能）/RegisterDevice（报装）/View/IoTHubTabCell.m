//
//  IoTHubTabCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IoTHubTabCell.h"
#import "IoTHubModel.h"
#import "IoTHubView.h"

@interface IoTHubTabCell ()

@property (nonatomic, strong) UIImageView* selectImagV;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UIButton* cellBtn;
@property (nonatomic, strong) UILabel* lineLb;

@end
@implementation IoTHubTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = SPH(64);
        self.width = zScreenWidth - SPW(50);
        [self setupUI];

    }
    
    return self;
}

- (void)setModel:(IoTHubModel *)model
{
    _model = model;
    
    if (model.iothubCellLineFlag) {
        [self showLining:model];
    }else{
        [self showLineSuccess:model];
    }
    
}

- (void)showLineSuccess:(IoTHubModel *)model
{
    self.titleLb.text = model.instancename;
       if (model.isSelected) {
           self.selectImagV.image = [SVGKImage imageNamed:@"icon_check"].UIImage;
           self.titleLb.textColor = [UIColor colorWithHex:@"#26C464"];
           self.titleLb.font = [UIFont boldSystemFontOfSize:17];
       }else{
           self.selectImagV.image = [SVGKImage imageNamed:@"icon_defaultcheck"].UIImage;
           self.titleLb.textColor = [UIColor colorWithHex:@"#121212"];
           self.titleLb.font = [UIFont systemFontOfSize:17];
       }
    [_cellBtn setImage:[SVGKImage imageNamed:@"icon_information"].UIImage forState:UIControlStateNormal];
}

- (void)showLining:(IoTHubModel *)model
{
    self.titleLb.text = model.instancename;
       if (model.isSelected) {
           self.selectImagV.image = [SVGKImage imageNamed:@"icon_check_line"].UIImage;
           self.titleLb.textColor = [UIColor colorWithHex:@"#B5B5B5"];
           self.titleLb.font = [UIFont boldSystemFontOfSize:17];
       }else{
           self.selectImagV.image = [SVGKImage imageNamed:@"icon_defaultcheck"].UIImage;
           self.titleLb.textColor = [UIColor colorWithHex:@"#B5B5B5"];
           self.titleLb.font = [UIFont systemFontOfSize:17];
       }
    [_cellBtn setImage:[SVGKImage imageNamed:@"icon_information_line"].UIImage forState:UIControlStateNormal];
}

- (void)cellBtnClick
{
    IoTHubView* iotV = [[IoTHubView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - SPW(32), SPH(327))];
    iotV.ipLb.text = self.model.domain;
    iotV.mqttLb.text = self.model.mqttport;
    iotV.nameLb.text = self.model.instancename;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
    nkView.contentView = iotV;
    [nkView show];
}

- (void)setupUI{
    
    [self.contentView addSubview:self.selectImagV];
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.cellBtn];

}

- (UIImageView *)selectImagV
{
    if (!_selectImagV) {
        _selectImagV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.height - 24)*0.5, 24, 24)];
        _selectImagV.image = [SVGKImage imageNamed:@"icon_defaultcheck"].UIImage;
    }
    return _selectImagV;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(self.selectImagV.right + 15, (self.height - 24)*0.5, self.width - 80, 24) Text:@"阿里云-1" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _titleLb;
}

- (UIButton *)cellBtn
{
    if (!_cellBtn) {
        _cellBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width - 10 - 24, (self.height - 24)*0.5, 24, 24)];
        [_cellBtn setImage:[SVGKImage imageNamed:@"icon_information"].UIImage forState:UIControlStateNormal];
        [_cellBtn addTarget:self action:@selector(cellBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cellBtn;
}

- (UILabel *)lineLb
{
    if (!_lineLb) {
        _lineLb = [[UILabel alloc] initWithFrame:CGRectMake(20, self.height - 1, self.width - 40, 0.5)];
        _lineLb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _lineLb;
}


@end
