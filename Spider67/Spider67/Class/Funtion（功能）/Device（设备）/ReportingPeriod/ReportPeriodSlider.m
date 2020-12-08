//
//  ReportPeriodSlider.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ReportPeriodSlider.h"

@interface ReportPeriodSlider ()

@property (nonatomic, strong) UILabel* mincycle_lb;
@property (nonatomic, strong) UILabel* maxcycle_lb;
@property (nonatomic, strong) UILabel* minvlue_lb;
@property (nonatomic, strong) UILabel* maxvlue_lb;

@end
@implementation ReportPeriodSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSlider];
    }
    return self;
}

- (void)setSlider{
    
    [self setThumbImage:[UIImage imageNamed:@"slider_control_circle"] forState:UIControlStateNormal];
    self.minimumTrackTintColor =  [UIColor colorWithHex:@"#26C464"];
    self.maximumTrackTintColor = [UIColor colorWithHex:@"#DADDE2"];
    self.minimumValue = 1.0;
    self.maximumValue = 3600.0;
//    [self addSubview:self.mincycle_lb];
//    [self addSubview:self.maxcycle_lb];
    [self addSubview:self.minvlue_lb];
    [self addSubview:self.maxvlue_lb];
    
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    rect.origin.x = rect.origin.x - 20 ;
    rect.size.width = rect.size.width +40;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 5 , 5);
}

- (UILabel *)mincycle_lb
{
    if (!_mincycle_lb) {
        _mincycle_lb = [[UILabel alloc] initWithFrame:CGRectMake(-7, (self.height - 10)*0.5, 10, 10)];
        _mincycle_lb.layer.borderColor = [UIColor colorWithHex:@"#DADDE2"].CGColor;
        _mincycle_lb.layer.borderWidth = 1;
        _mincycle_lb.layer.cornerRadius = 5;
        _mincycle_lb.layer.masksToBounds = YES;
    }
    
    return _mincycle_lb;
}

- (UILabel *)maxcycle_lb
{
    if (!_maxcycle_lb) {
        _maxcycle_lb = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 3, (self.height - 10)*0.5, 10, 10)];
        _maxcycle_lb.layer.borderColor = [UIColor colorWithHex:@"#DADDE2"].CGColor;
        _maxcycle_lb.layer.borderWidth = 1;
        _maxcycle_lb.layer.cornerRadius = 5;
        _maxcycle_lb.layer.masksToBounds = YES;
    }
    
    return _maxcycle_lb;
}

- (UILabel *)minvlue_lb
{
    if (!_minvlue_lb) {
        _minvlue_lb = [UILabel z_frame:CGRectMake(-7, self.height - 10, self.width*0.5, 20)
                                  Text:@"min 1s"
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    return _minvlue_lb;
}

- (UILabel *)maxvlue_lb
{
    if (!_maxvlue_lb) {
        _maxvlue_lb = [UILabel z_frame:CGRectMake(self.width - self.width*0.5 + 7, self.height - 10,  self.width*0.5, 20)
                                  Text:@"max 3600s"
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
        _maxvlue_lb.textAlignment = NSTextAlignmentRight;
    }
    return _maxvlue_lb;
}

@end
