//
//  LinkageTableViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LinkageTableViewCell.h"

@interface LinkageTableViewCell ()

@property (nonatomic, strong) UILabel* pab_lb;
@property (nonatomic, strong) UILabel* chufa_lb;
@property (nonatomic, strong) UILabel* guize_lb;
@property (nonatomic, strong) UILabel* modname_lb;
@property (nonatomic, strong) UILabel* channelname_lb;


@end
@implementation LinkageTableViewCell

- (void)setFrame:(CGRect)frame{
//    frame.origin.x += 25;
//    frame.origin.y += 10;
    frame.size.height = 125 - 10;
//    frame.size.width = zScreenWidth - 50;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.height = 115;
//        self.width = zScreenWidth - 50;
        [self setupUI];

    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    
    self.pab_lb.text = dict[@"port"];
    if ([dict[@"relation"] isEqualToString:@"="]) {
        self.guize_lb.text = @"同步";
    }else{
        self.guize_lb.text = @"取反";
    }
    self.channelname_lb.text = dict[@"channel_in"];
    self.modname_lb.text = dict[@"channeltitle"];
}

- (void)setupUI
{
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.pab_lb];
    [self addSubview:self.chufa_lb];
    [self addSubview:self.guize_lb];
    [self addSubview:self.modname_lb];
    [self addSubview:self.channelname_lb];
    
}

#pragma mark - lazy

- (UILabel *)pab_lb
{
    if (!_pab_lb) {
        _pab_lb = [UILabel z_frame:CGRectMake(20, 20, 45, 24)
                              Text:@"P2 A"
                          fontSize:20
                             color:[UIColor colorWithHex:@"#121212"]
                            isbold:NO
                   ];
    }
    return _pab_lb;
}

- (UILabel *)chufa_lb
{
    if (!_chufa_lb) {
        _chufa_lb = [UILabel z_frame:CGRectMake(self.pab_lb.right + 10, 0, 50, 24)
                                Text:@"触发"
                            fontSize:14
                               color:[UIColor colorWithHex:@"#ED8549"]
                              isbold:NO
                        cornerRadius:4
                     backgroundColor:[UIColor colorWithHex:@"#ED8549" alpha:0.22]
                     ];
        _chufa_lb.centerY = self.pab_lb.centerY;
        _chufa_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _chufa_lb;
}

- (UILabel *)guize_lb
{
    if (!_guize_lb) {
        _guize_lb = [UILabel z_frame:CGRectMake(self.width - 45 - 20, 0, 45, 25)
                                 Text:@"取反"
                             fontSize:18
                                color:[UIColor colorWithHex:@"#26C464"]
                               isbold:YES
                      ];
        _guize_lb.centerY = self.pab_lb.centerY;

       }
       return _guize_lb;
}

- (UILabel *)modname_lb
{
    if (!_modname_lb) {
        _modname_lb = [UILabel z_frame:CGRectMake(self.pab_lb.x, self.pab_lb.bottom + 6, self.width - 2*self.pab_lb.x, 20)
                              Text:@"一号水池液位检测"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _modname_lb;
}

- (UILabel *)channelname_lb
{
    if (!_channelname_lb) {
        _channelname_lb = [UILabel z_frame:CGRectMake(self.modname_lb.x, self.modname_lb.bottom + 5, self.width - 2*self.pab_lb.x, 20)
                              Text:@"module_0 channel_5"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
    }
    return _channelname_lb;
}

@end
