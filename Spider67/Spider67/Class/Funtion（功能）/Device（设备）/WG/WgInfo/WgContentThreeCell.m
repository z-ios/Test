//
//  WgContentThreeCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgContentThreeCell.h"

@interface WgContentThreeCell ()

@property (nonatomic, strong) UILabel* biaoshima_t_lb;
@property (nonatomic, strong) UILabel* biaoshima_lb;
@property (nonatomic, strong) UILabel* biaoshima_l_lb;

@property (nonatomic, strong) UILabel* qunzu_t_lb;
@property (nonatomic, strong) UILabel* qunzu_lb;
@property (nonatomic, strong) UILabel* qunzu_l_lb;

@property (nonatomic, strong) UILabel* regid_t_lb;
@property (nonatomic, strong) UILabel* regid_lb;
@property (nonatomic, strong) UILabel* regid_l_lb;

@end
@implementation WgContentThreeCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.origin.y += 10;
    frame.size.height = 290 - 10;
    frame.size.width = zScreenWidth - 40;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 290;
        self.width = zScreenWidth;
        [self setupUI];

    }
    
    return self;
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    
    if ([_deviceDict[@"devicetype"] isEqualToString:@"SPMB-16DIO-002.EU"] ) {// 单wifi
        self.biaoshima_lb.text = _deviceDict[@"wifimac"];
    }else{
        self.biaoshima_lb.text = _deviceDict[@"imei"];
    }
    
    self.qunzu_lb.text = _deviceDict[@"groupname"];
    
    self.regid_lb.text = _deviceDict[@"id"];
    
}

- (void)setupUI
{
    self.layer.cornerRadius = 12;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.biaoshima_t_lb];
    [self addSubview:self.biaoshima_lb];
    [self addSubview:self.biaoshima_l_lb];
    
    [self addSubview:self.qunzu_t_lb];
    [self addSubview:self.qunzu_lb];
    [self addSubview:self.qunzu_l_lb];
    
    [self addSubview:self.regid_t_lb];
    [self addSubview:self.regid_lb];
    [self addSubview:self.regid_l_lb];
    
    
}


#pragma mark - lazy

- (UILabel *)biaoshima_t_lb
{
    if (!_biaoshima_t_lb) {
        _biaoshima_t_lb = [UILabel z_frame:CGRectMake(16, 20, self.width - 32, 20)
                                      Text:NSLocalizedString(@"设备标识码", nil)
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    
    return _biaoshima_t_lb;
}

- (UILabel *)biaoshima_lb
{
    if (!_biaoshima_lb) {
        _biaoshima_lb = [UILabel z_frame:CGRectMake(16, self.biaoshima_t_lb.bottom + 10, self.width - 32, 24)
                                      Text:@"--"
                                  fontSize:17
                                     color:[UIColor colorWithHex:@"#121212"]
                                    isbold:NO
                           ];
    }
    
    return _biaoshima_lb;
}

- (UILabel *)biaoshima_l_lb
{
       if (!_biaoshima_l_lb) {
         _biaoshima_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.biaoshima_lb.bottom + 10, self.width - 32, 1)];
         _biaoshima_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
     }
     
     return _biaoshima_l_lb;
}

- (UILabel *)qunzu_t_lb
{
    if (!_qunzu_t_lb) {
        _qunzu_t_lb = [UILabel z_frame:CGRectMake(16, self.biaoshima_l_lb.bottom + 15, self.width - 32, 20)
                                  Text:NSLocalizedString(@"所属群组", nil)
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    
    return _qunzu_t_lb;
}

- (UILabel *)qunzu_lb
{
    if (!_qunzu_lb) {
        _qunzu_lb = [UILabel z_frame:CGRectMake(16, self.qunzu_t_lb.bottom + 10, self.width - 32, 24)
                                Text:@"--"
                            fontSize:17
                               color:[UIColor colorWithHex:@"#121212"]
                              isbold:NO
                     ];
    }
    
    return _qunzu_lb;
}

- (UILabel *)qunzu_l_lb
{
    if (!_qunzu_l_lb) {
        _qunzu_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.qunzu_lb.bottom + 10, self.width - 32, 1)];
        _qunzu_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _qunzu_l_lb;
}

- (UILabel *)regid_t_lb
{
    if (!_regid_t_lb) {
        _regid_t_lb = [UILabel z_frame:CGRectMake(16, self.qunzu_l_lb.bottom + 15, self.width - 32, 20)
                                  Text:NSLocalizedString(@"后端注册ID", nil)
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    
    return _regid_t_lb;
}

- (UILabel *)regid_lb
{
    if (!_regid_lb) {
        _regid_lb = [UILabel z_frame:CGRectMake(16, self.regid_t_lb.bottom + 10, self.width - 32, 42)
                                Text:@"--"
                            fontSize:17
                               color:[UIColor colorWithHex:@"#121212"]
                              isbold:NO
                     ];
        _regid_lb.numberOfLines = 0;
    }
    
    return _regid_lb;
}

- (UILabel *)regid_l_lb
{
    if (!_regid_l_lb) {
        _regid_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.regid_lb.bottom + 10, self.width - 32, 1)];
        _regid_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _regid_l_lb;
}


@end
