//
//  WgContentTwoCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgContentTwoCell.h"

@interface WgContentTwoCell ()

@property (nonatomic, strong) UILabel* cycleTitleLb;
@property (nonatomic, strong) UILabel* cycleLb;
@property (nonatomic, strong) UILabel* lineLb;

@end
@implementation WgContentTwoCell

- (void)setFrame:(CGRect)frame{
    frame.origin.x += 20;
    frame.origin.y += 10;
    frame.size.height = 114 - 10;
    frame.size.width = zScreenWidth - 40;
    [super setFrame:frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.height = 114;
        self.width = zScreenWidth;
        [self setupUI];

    }
    
    return self;
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    
    self.cycleLb.text = [NSString stringWithFormat:@"%@",deviceDict[@"interval"]];
    
}

- (void)setupUI
{
    self.layer.cornerRadius = 12;
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.cycleTitleLb];
    [self addSubview:self.cycleLb];
    [self addSubview:self.lineLb];
}

- (UILabel *)cycleTitleLb
{
    if (!_cycleTitleLb) {
        _cycleTitleLb = [UILabel z_frame:CGRectMake(16, 20, self.width - 40, 20)
                                    Text:NSLocalizedString(@"上报周期", nil)
                                fontSize:14
                                   color:[UIColor colorWithHex:@"#808080"]
                                  isbold:NO
                         ];
    }
    return _cycleTitleLb;
}

- (UILabel *)cycleLb
{
    if (!_cycleLb) {
        _cycleLb = [UILabel z_frame:CGRectMake(self.cycleTitleLb.x, self.cycleTitleLb.bottom + 10, self.width - 40, 24)
                                    Text:@"6000ms"
                                fontSize:17
                                   color:[UIColor colorWithHex:@"#121212"]
                                  isbold:NO
                         ];
    }
    return _cycleLb;
}

- (UILabel *)lineLb
{
    if (!_lineLb) {
        _lineLb = [[UILabel alloc] initWithFrame:CGRectMake(self.cycleLb.x, self.cycleLb.bottom + 10, self.width - 32, 1)];
        _lineLb.backgroundColor= [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    
    return _lineLb;
}

@end
