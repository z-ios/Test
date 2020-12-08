//
//  ModuleNumView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ModuleNumView.h"
#import "ModulesListModel.h"
#import "ChannelListModel.h"

@interface ModuleNumView ()

@property (nonatomic, strong) UIView* p0View;
@property (nonatomic, strong) UIView* p1View;
@property (nonatomic, strong) UIView* p2View;
@property (nonatomic, strong) UIView* p3View;

@property (nonatomic, strong) UILabel* p0_Lb;
@property (nonatomic, strong) UILabel* p1_Lb;
@property (nonatomic, strong) UILabel* p2_Lb;
@property (nonatomic, strong) UILabel* p3_Lb;

@property (nonatomic, strong) UILabel* p0_lineLb;
@property (nonatomic, strong) UILabel* p1_lineLb;
@property (nonatomic, strong) UILabel* p2_lineLb;
@property (nonatomic, strong) UILabel* p3_lineLb;

@property (nonatomic, strong) UILabel* p0_numLb;
@property (nonatomic, strong) UILabel* p1_numLb;
@property (nonatomic, strong) UILabel* p2_numLb;
@property (nonatomic, strong) UILabel* p3_numLb;

@property (nonatomic, strong) UILabel* p0_unitLb;
@property (nonatomic, strong) UILabel* p1_unitLb;
@property (nonatomic, strong) UILabel* p2_unitLb;
@property (nonatomic, strong) UILabel* p3_unitLb;


@end
@implementation ModuleNumView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(ModulesListModel *)model
{
    _model = model;
    
    [self setValue:_model];
    
}

- (void)setValue:(ModulesListModel *)model
{
    [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull channelModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (channelModel.alarm_type.length > 0) {
            if ([channelModel.alarm_type isEqualToString:@"H"]) {
                switch (idx) {
                    case 0:
                        self.p0_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 1:
                        self.p1_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 2:
                        self.p2_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                    case 3:
                        self.p3_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_H];
                        break;
                        
                    default:
                        break;
                }
            }else{
                switch (idx) {
                    case 0:
                        self.p0_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 1:
                        self.p1_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 2:
                        self.p2_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                    case 3:
                        self.p3_Lb.backgroundColor = [UIColor colorWithHex:channelModel.alarm_color_L];
                        break;
                        
                    default:
                        break;
                }
            }
        }
        
        switch (idx) {
            case 0:
                self.p0_numLb.text = channelModel.calculatedvalue;
                self.p0_unitLb.text = channelModel.unit;
                break;
            case 1:
                self.p1_numLb.text = channelModel.calculatedvalue;
                self.p1_unitLb.text = channelModel.unit;
                break;
            case 2:
                self.p2_numLb.text = channelModel.calculatedvalue;
                self.p2_unitLb.text = channelModel.unit;
                break;
            case 3:
                self.p3_numLb.text = channelModel.calculatedvalue;
                self.p3_unitLb.text = channelModel.unit;
                break;
                
            default:
                break;
        }
    }];
}



- (void)setupUI
{
    
    [self addSubview:self.p0View];
    [self addSubview:self.p1View];
    [self addSubview:self.p2View];
    [self addSubview:self.p3View];
    
    [self.p0View addSubview:self.p0_Lb];
    [self.p1View addSubview:self.p1_Lb];
    [self.p2View addSubview:self.p2_Lb];
    [self.p3View addSubview:self.p3_Lb];
    
    [self.p0View addSubview:self.p0_lineLb];
    [self.p1View addSubview:self.p1_lineLb];
    [self.p2View addSubview:self.p2_lineLb];
    [self.p3View addSubview:self.p3_lineLb];
    
    [self.p0View addSubview:self.p0_numLb];
    [self.p1View addSubview:self.p1_numLb];
    [self.p2View addSubview:self.p2_numLb];
    [self.p3View addSubview:self.p3_numLb];
    
    [self.p0View addSubview:self.p0_unitLb];
    [self.p1View addSubview:self.p1_unitLb];
    [self.p2View addSubview:self.p2_unitLb];
    [self.p3View addSubview:self.p3_unitLb];
    
}



#pragma mark - lazy

- (UIView *)p0View
{
    if (!_p0View) {
        _p0View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 58)];
        _p0View.layer.cornerRadius = 6;
        _p0View.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _p0View.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.15].CGColor;
        _p0View.layer.borderWidth = 0.5;
        _p0View.layer.masksToBounds = YES;
    }
    return _p0View;
}

- (UIView *)p1View
{
    if (!_p1View) {
        _p1View = [[UIView alloc] initWithFrame:CGRectMake(0, self.p0View.bottom + 15, self.width, 58)];
        _p1View.layer.cornerRadius = 6;
        _p1View.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _p1View.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.15].CGColor;
        _p1View.layer.borderWidth = 0.5;
        _p1View.layer.masksToBounds = YES;
    }
    return _p1View;
}

- (UIView *)p2View
{
    if (!_p2View) {
        _p2View = [[UIView alloc] initWithFrame:CGRectMake(0, self.p1View.bottom + 15, self.width, 58)];
        _p2View.layer.cornerRadius = 6;
        _p2View.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _p2View.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.15].CGColor;
        _p2View.layer.borderWidth = 0.5;
        _p2View.layer.masksToBounds = YES;
    }
    return _p2View;
}

- (UIView *)p3View
{
    if (!_p3View) {
        _p3View = [[UIView alloc] initWithFrame:CGRectMake(0, self.p2View.bottom + 15, self.width, 58)];
        _p3View.layer.cornerRadius = 6;
        _p3View.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _p3View.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.15].CGColor;
        _p3View.layer.borderWidth = 0.5;
        _p3View.layer.masksToBounds = YES;
    }
    return _p3View;
}

- (UILabel *)p0_Lb
{
    if (!_p0_Lb) {
        _p0_Lb =[UILabel z_frame:CGRectMake(0, 0, 60, self.p0View.height)
                            Text:@"P0"
                        fontSize:17
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:YES];
        _p0_Lb.textAlignment = NSTextAlignmentCenter;
    }
    return _p0_Lb;
    
}

- (UILabel *)p1_Lb
{
    if (!_p1_Lb) {
        _p1_Lb =[UILabel z_frame:CGRectMake(0, 0, 60, self.p1View.height)
                            Text:@"P1"
                        fontSize:17
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:YES];
        _p1_Lb.textAlignment = NSTextAlignmentCenter;
    }
    return _p1_Lb;
    
}

- (UILabel *)p2_Lb
{
    if (!_p2_Lb) {
        _p2_Lb =[UILabel z_frame:CGRectMake(0, 0, 60, self.p2View.height)
                            Text:@"P2"
                        fontSize:17
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:YES];
        _p2_Lb.textAlignment = NSTextAlignmentCenter;
    }
    return _p2_Lb;
    
}

- (UILabel *)p3_Lb
{
    if (!_p3_Lb) {
        _p3_Lb =[UILabel z_frame:CGRectMake(0, 0, 60, self.p3View.height)
                            Text:@"P3"
                        fontSize:17
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:YES];
        _p3_Lb.textAlignment = NSTextAlignmentCenter;
    }
    return _p3_Lb;
    
}

- (UILabel *)p0_lineLb
{
    if (!_p0_lineLb) {
        _p0_lineLb = [[UILabel alloc] initWithFrame:CGRectMake(self.p0_Lb.right, 0, 0.5, self.p3View.height)];
        _p0_lineLb.backgroundColor =[UIColor colorWithHex:@"#000000" alpha:0.15];
    }
    return _p0_lineLb;
}

- (UILabel *)p1_lineLb
{
    if (!_p1_lineLb) {
        _p1_lineLb = [[UILabel alloc] initWithFrame:CGRectMake(self.p1_Lb.right, 0, 0.5, self.p3View.height)];
        _p1_lineLb.backgroundColor =[UIColor colorWithHex:@"#000000" alpha:0.15];
    }
    return _p1_lineLb;
}

- (UILabel *)p2_lineLb
{
    if (!_p2_lineLb) {
        _p2_lineLb = [[UILabel alloc] initWithFrame:CGRectMake(self.p2_Lb.right, 0, 0.5, self.p3View.height)];
        _p2_lineLb.backgroundColor =[UIColor colorWithHex:@"#000000" alpha:0.15];
    }
    return _p2_lineLb;
}

- (UILabel *)p3_lineLb
{
    if (!_p3_lineLb) {
        _p3_lineLb = [[UILabel alloc] initWithFrame:CGRectMake(self.p3_Lb.right, 0, 0.5, self.p3View.height)];
        _p3_lineLb.backgroundColor =[UIColor colorWithHex:@"#000000" alpha:0.15];
    }
    return _p3_lineLb;
}

- (UILabel *)p0_numLb
{
    if (!_p0_numLb) {
        _p0_numLb =[UILabel z_frame:CGRectMake(self.p0_Lb.right + 10, (self.p0_Lb.height - 24)*0.5, self.p0View.width - (self.p0_Lb.right + 10), 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#616365"]
                             isbold:NO];
        
    }
    return _p0_numLb;
}

- (UILabel *)p1_numLb
{
    if (!_p1_numLb) {
        _p1_numLb =[UILabel z_frame:CGRectMake(self.p1_Lb.right + 10, (self.p1_Lb.height - 24)*0.5, self.p1View.width - (self.p1_Lb.right + 10), 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#616365"]
                             isbold:NO];
        
    }
    return _p1_numLb;
}

- (UILabel *)p2_numLb
{
    if (!_p2_numLb) {
        _p2_numLb =[UILabel z_frame:CGRectMake(self.p2_Lb.right + 10, (self.p2_Lb.height - 24)*0.5, self.p2View.width - (self.p2_Lb.right + 10), 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#616365"]
                             isbold:NO];
        
    }
    return _p2_numLb;
}

- (UILabel *)p3_numLb
{
    if (!_p3_numLb) {
        _p3_numLb =[UILabel z_frame:CGRectMake(self.p3_Lb.right + 10, (self.p3_Lb.height - 24)*0.5, self.p3View.width - (self.p3_Lb.right + 10), 24)
                               Text:@"--"
                           fontSize:17
                              color:[UIColor colorWithHex:@"#616365"]
                             isbold:NO];
        
    }
    return _p3_numLb;
}

- (UILabel *)p0_unitLb
{
    if (!_p0_unitLb) {
        _p0_unitLb =[UILabel z_frame:CGRectMake(self.p0View.width - 100 - 3, _p0_numLb.bottom, 100, 17)
                               Text:@"--"
                           fontSize:12
                              color:[UIColor colorWithHex:@"#C2C3C4"]
                             isbold:NO];
        _p0_unitLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _p0_unitLb;
}

- (UILabel *)p1_unitLb
{
    if (!_p1_unitLb) {
        _p1_unitLb =[UILabel z_frame:CGRectMake(self.p1View.width - 100 - 3, _p1_numLb.bottom, 100, 17)
                               Text:@"--"
                           fontSize:12
                              color:[UIColor colorWithHex:@"#C2C3C4"]
                             isbold:NO];
        _p1_unitLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _p1_unitLb;
}

- (UILabel *)p2_unitLb
{
    if (!_p2_unitLb) {
        _p2_unitLb =[UILabel z_frame:CGRectMake(self.p2View.width - 100 - 3, _p2_numLb.bottom, 100, 17)
                               Text:@"--"
                           fontSize:12
                              color:[UIColor colorWithHex:@"#C2C3C4"]
                             isbold:NO];
        _p2_unitLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _p2_unitLb;
}

- (UILabel *)p3_unitLb
{
    if (!_p3_unitLb) {
        _p3_unitLb =[UILabel z_frame:CGRectMake(self.p3View.width - 100 - 3, _p3_numLb.bottom, 100, 17)
                               Text:@"--"
                           fontSize:12
                              color:[UIColor colorWithHex:@"#C2C3C4"]
                             isbold:NO];
        _p3_unitLb.textAlignment = NSTextAlignmentRight;
        
    }
    return _p3_unitLb;
}



@end
