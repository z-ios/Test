//
//  WgContentFourCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgContentFourCell.h"

@interface WgContentFourCell ()

@property (nonatomic, strong) UILabel* name_t_lb;
@property (nonatomic, strong) UILabel* name_lb;
@property (nonatomic, strong) UILabel* name_l_lb;

@property (nonatomic, strong) UILabel* ip_t_lb;
@property (nonatomic, strong) UILabel* ip_lb;
@property (nonatomic, strong) UILabel* ip_l_lb;

@property (nonatomic, strong) UILabel* id_t_lb;
@property (nonatomic, strong) UILabel* id_lb;
@property (nonatomic, strong) UILabel* id_l_lb;

@property (nonatomic, strong) UILabel* type_t_lb;
@property (nonatomic, strong) UILabel* type_lb;
@property (nonatomic, strong) UILabel* type_l_lb;

@end
@implementation WgContentFourCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.origin.y += 10;
    frame.size.height = 351 - 10;
    frame.size.width = zScreenWidth - 40;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 351;
        self.width = zScreenWidth;
        [self setupUI];

    }
    
    return self;
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    
    _name_lb.text = _deviceDict[@"hub_instancename"];
    _ip_lb.text = _deviceDict[@"hub_domain"];
    _id_lb.text =  _deviceDict[@"hubid"];
    _type_lb.text = _deviceDict[@"devicetype"];
    
}

- (void)setupUI
{
    self.layer.cornerRadius = 12;
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.name_t_lb];
    [self addSubview:self.name_lb];
    [self addSubview:self.name_l_lb];
    
    [self addSubview:self.ip_t_lb];
    [self addSubview:self.ip_lb];
    [self addSubview:self.ip_l_lb];
    
    [self addSubview:self.id_t_lb];
    [self addSubview:self.id_lb];
    [self addSubview:self.id_l_lb];
    
    [self addSubview:self.type_t_lb];
    [self addSubview:self.type_lb];
    [self addSubview:self.type_l_lb];
    
}


#pragma mark - lazy

- (UILabel *)name_t_lb
{
    if (!_name_t_lb) {
        _name_t_lb = [UILabel z_frame:CGRectMake(16, 20, self.width - 32, 20)
                                 Text:NSLocalizedString(@"实例", nil)
                             fontSize:14
                                color:[UIColor colorWithHex:@"#808080"]
                               isbold:NO
                      ];
    }
    
    return _name_t_lb;
}

- (UILabel *)name_lb
{
    if (!_name_lb) {
        _name_lb = [UILabel z_frame:CGRectMake(16, self.name_t_lb.bottom + 10, self.width - 32, 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    
    return _name_lb;
}

- (UILabel *)name_l_lb
{
    if (!_name_l_lb) {
        _name_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.name_lb.bottom + 10, self.width - 32, 1)];
        _name_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _name_l_lb;
}

- (UILabel *)ip_t_lb
{
    if (!_ip_t_lb) {
        _ip_t_lb = [UILabel z_frame:CGRectMake(16, self.name_l_lb.bottom + 15, self.width - 32, 20)
                               Text:@"ROOT IP"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
    }
    
    return _ip_t_lb;
}

- (UILabel *)ip_lb
{
    if (!_ip_lb) {
        _ip_lb = [UILabel z_frame:CGRectMake(16, self.ip_t_lb.bottom + 10, self.width - 32, 24)
                             Text:@"--"
                         fontSize:17
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
    }
    
    return _ip_lb;
}

- (UILabel *)ip_l_lb
{
    if (!_ip_l_lb) {
        _ip_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.ip_lb.bottom + 10, self.width - 32, 1)];
        _ip_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _ip_l_lb;
}

- (UILabel *)id_t_lb
{
    if (!_id_t_lb) {
        _id_t_lb = [UILabel z_frame:CGRectMake(16, self.ip_l_lb.bottom + 15, self.width - 32, 20)
                               Text:@"thing id"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
    }
    
    return _id_t_lb;
}

- (UILabel *)id_lb
{
    if (!_id_lb) {
        _id_lb = [UILabel z_frame:CGRectMake(16, self.id_t_lb.bottom + 10, self.width - 32, 24)
                             Text:@"--"
                         fontSize:17
                            color:[UIColor colorWithHex:@"#121212"]
                           isbold:NO
                  ];
    }
    
    return _id_lb;
}

- (UILabel *)id_l_lb
{
    if (!_id_l_lb) {
        _id_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.id_lb.bottom + 10, self.width - 32, 1)];
        _id_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _id_l_lb;
}


- (UILabel *)type_t_lb
{
    if (!_type_t_lb) {
        _type_t_lb = [UILabel z_frame:CGRectMake(16, self.id_l_lb.bottom + 15, self.width - 32, 20)
                                 Text:NSLocalizedString(@"型号", nil)
                             fontSize:14
                                color:[UIColor colorWithHex:@"#808080"]
                               isbold:NO
                      ];
    }
    
    return _type_t_lb;
}

- (UILabel *)type_lb
{
    if (!_type_lb) {
        _type_lb = [UILabel z_frame:CGRectMake(16, self.type_t_lb.bottom + 10, self.width - 32, 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    
    return _type_lb;
}

- (UILabel *)type_l_lb
{
    if (!_type_l_lb) {
        _type_l_lb = [[UILabel alloc] initWithFrame:CGRectMake(16, self.type_lb.bottom + 10, self.width - 32, 1)];
        _type_l_lb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _type_l_lb;
}


@end
