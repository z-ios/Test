//
//  SeaverListCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SeaverListCell.h"

@interface SeaverListCell ()

@property (nonatomic, strong) UILabel *beizhuNoteLb;
@property (nonatomic, strong) UILabel *ipNoteLb;
@property (nonatomic, strong) UILabel *xyNoteLb;
@property (nonatomic, strong) UILabel *portNoteLb;

@end
@implementation SeaverListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    _beizhuNoteLb.text = dict[@"devTitle"];
    _ipNoteLb.text = dict[@"devIp"];
    _portNoteLb.text = dict[@"devPort"];
    _xyNoteLb.text = dict[@"devpro"];
}

- (void)setupUI{
    
    self.swipeBackgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = true;
    self.backgroundColor = [UIColor whiteColor];
    // 备注
    UILabel* beizhuLb = [UILabel z_frame:CGRectMake(SPW(20), SPH(20), SPW(62), SPH(24))
                                    Text:NSLocalizedString(@"备注", nil)
                                fontSize:SPFont(14)
                                   color:[UIColor colorWithHex:@"#EFC024"]
                                  isbold:NO
                            cornerRadius:SPH(12)
                         backgroundColor:[UIColor colorWithHex:@"#EFC024" alpha:0.1]
                         ];
    beizhuLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:beizhuLb];
    
    UILabel* beizhuNoteLb = [UILabel z_labelWithText:@"中国服务器" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    beizhuNoteLb.width = self.width - SPW(90);
    beizhuNoteLb.height = SPH(24);
    beizhuNoteLb.x = beizhuLb.right + SPW(5);
    beizhuNoteLb.centerY = beizhuLb.centerY;
    [self.contentView addSubview:beizhuNoteLb];
    _beizhuNoteLb = beizhuNoteLb;
    
    // ip
    
    UILabel* ipLb = [UILabel z_frame:CGRectMake(SPW(20), beizhuLb.bottom + SPH(10), SPW(62), SPH(24))
                                       Text:@"IP"
                                   fontSize:SPFont(14)
                                      color:[UIColor colorWithHex:@"#26C464"]
                                     isbold:NO
                               cornerRadius:SPH(12)
                            backgroundColor:[UIColor colorWithHex:@"#26C464" alpha:0.1]
                            ];
       ipLb.textAlignment = NSTextAlignmentCenter;
       [self addSubview:ipLb];
       
       UILabel* ipNoteLb = [UILabel z_labelWithText:@"192.169.32.32" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
       ipNoteLb.width = self.width - 90;
       ipNoteLb.height = 24;
       ipNoteLb.x = ipLb.right + 5;
       ipNoteLb.centerY = ipLb.centerY;
    [self.contentView addSubview:ipNoteLb];
    _ipNoteLb = ipNoteLb;
    
     // port
    
    UILabel* portLb = [UILabel z_frame:CGRectMake(SPW(20), ipLb.bottom + SPH(10), SPW(62), SPH(24))
                                    Text:@"Port"
                                fontSize:SPFont(14)
                                   color:[UIColor colorWithHex:@"#1D68F2"]
                                  isbold:NO
                            cornerRadius:SPH(12)
                         backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.1]
                         ];
    portLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:portLb];
    
    UILabel* portNoteLb = [UILabel z_labelWithText:@"8000" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    portNoteLb.width = (self.width - SPW(90))*0.5;
    portNoteLb.height = SPH(24);
    portNoteLb.x = portLb.right + SPW(5);
    portNoteLb.centerY = portLb.centerY;
    [self.contentView addSubview:portNoteLb];
    _portNoteLb = portNoteLb;

    
    // 协议
    
    UILabel* xyLb = [UILabel z_frame:CGRectMake(portNoteLb.right, ipLb.bottom + SPH(10), SPW(62), SPH(24))
                                   Text:NSLocalizedString(@"协议", nil)
                               fontSize:SPFont(14)
                                  color:[UIColor colorWithHex:@"#F26E1D"]
                                 isbold:NO
                           cornerRadius:SPH(12)
                        backgroundColor:[UIColor colorWithHex:@"#F26E1D" alpha:0.1]
                        ];
    xyLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:xyLb];

    UILabel* xyNoteLb = [UILabel z_labelWithText:@"https" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    xyNoteLb.width = (self.width - SPW(90))*0.5;
    xyNoteLb.height = SPH(24);
    xyNoteLb.x = xyLb.right + SPW(5);
    xyNoteLb.centerY = xyLb.centerY;
    [self.contentView addSubview:xyNoteLb];
    _xyNoteLb = xyNoteLb;
  

    
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 16;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 32;
    [super setFrame:frame];
}

@end
