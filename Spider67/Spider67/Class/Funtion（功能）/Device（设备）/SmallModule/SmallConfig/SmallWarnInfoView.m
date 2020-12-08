//
//  SmallWarnInfoView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallWarnInfoView.h"

@interface SmallWarnInfoView ()

@property (nonatomic, strong) UIImageView* channnelName_imgv;
@property (nonatomic, strong) UIImageView* defineName_imgv;

@end
@implementation SmallWarnInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 12;
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.layer.shadowOpacity = 10;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    [self addSubview:self.pab_lb];
    [self addSubview:self.channelType_lb];
    [self addSubview:self.channnelName_imgv];
    [self addSubview:self.channnelName_lb];
    [self addSubview:self.defineName_imgv];
    [self addSubview:self.defineName_lb];
    
}

#pragma mark - lazy

- (UILabel *)pab_lb
{
    if (!_pab_lb) {
        _pab_lb = [UILabel z_frame:CGRectMake(20, 20, 30, 28)
                              Text:@"--"
                          fontSize:20
                             color:[UIColor colorWithHex:@"#121212"]
                            isbold:NO
                   ];
    }
    return _pab_lb;
}

- (UILabel *)channelType_lb
{
    if (!_channelType_lb) {
        
        _channelType_lb = [UILabel z_frame:CGRectMake(self.pab_lb.right + 12, 0, 120, 28)
                                      Text:@"CH8_DUP_M12"
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#1D68F2"]
                                    isbold:NO
                              cornerRadius:14
                           backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]
                           ];
        _channelType_lb.centerY = self.pab_lb.centerY;
        _channelType_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _channelType_lb;
}

- (UIImageView *)channnelName_imgv
{
    if (!_channnelName_imgv) {
        _channnelName_imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.pab_lb.bottom + 16, 18, 18)];
        _channnelName_imgv.image = [SVGKImage imageNamed:@"icon_set_alert"].UIImage;
    }
    return _channnelName_imgv;
}

- (UILabel *)channnelName_lb
{
    if (!_channnelName_lb) {
        _channnelName_lb = [UILabel z_frame:CGRectMake(self.channnelName_imgv.right + 5, 0, 150, 20)
                              Text:@"--"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
        _channnelName_lb.centerY = self.channnelName_imgv.centerY;
    }
    return _channnelName_lb;
}

- (UIImageView *)defineName_imgv
{
    if (!_defineName_imgv) {
        _defineName_imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.channnelName_imgv.bottom + 12, 18, 18)];
        _defineName_imgv.image = [SVGKImage imageNamed:@"icon_set_label"].UIImage;
    }
    return _defineName_imgv;
}

- (UILabel *)defineName_lb
{
    if (!_defineName_lb) {
        _defineName_lb = [UILabel z_frame:CGRectMake(self.defineName_imgv.right + 5, 0, 150, 20)
                              Text:@"--"
                          fontSize:14
                             color:[UIColor colorWithHex:@"#808080"]
                            isbold:NO
                   ];
        _defineName_lb.centerY = self.defineName_imgv.centerY;
    }
    return _defineName_lb;
}
    

@end
