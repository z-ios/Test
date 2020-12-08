//
//  SmallMeunHeaderView.m
//  Spider67
//
//  Created by 宾哥 on 2020/11/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallMeunHeaderView.h"
#import "ChannelListModel.h"

@implementation SmallMeunHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    
}

- (void)setChannelModel:(ChannelListModel *)channelModel
{
    _channelModel = channelModel;
    UIView* iotV = [self showiothubNumViewframe:CGRectMake(25, 0, self.width - 50, 112) numStr:_channelModel.originalvalue];
    [self addSubview:iotV];
    NSString* unitStr = [_channelModel.channeltype hasSuffix:@"A"] ? @"Am" : @"V";

    UIView* zdV = [self showterminalNumViewframe:CGRectMake(25, iotV.bottom + 10, self.width - 50, 112) numStr:_channelModel.readvalue unitStr:[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"单位", nil),unitStr]];
    [self addSubview:zdV];
    UIView* hsV = [self showconversionNumViewframe:CGRectMake(25, zdV.bottom + 10, self.width - 50, 112) numStr:_channelModel.calculatedvalue unitStr:[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"单位", nil),_channelModel.unit]];
    [self addSubview:hsV];
}

- (UIView *)showiothubNumViewframe:(CGRect)frame numStr:(NSString *)numStr
{
    UIView* vv = [[UIView alloc] initWithFrame:frame];
    vv.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    vv.layer.cornerRadius = 8;
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 24, 24)];
    imgv.image = [SVGKImage imageNamed:@"icon_iot"].UIImage;
    [vv addSubview:imgv];
    UILabel* lb = [UILabel z_frame:CGRectMake(imgv.right + 7, 0, vv.width - (imgv.right + 7), 24) Text:NSLocalizedString(@"IoTHub数值", nil) fontSize:17 color:[UIColor whiteColor] isbold:NO];
    lb.centerY = imgv.centerY;
    [vv addSubview:lb];
    UILabel* num_lb = [UILabel z_frame:CGRectMake(0, vv.height - 60, vv.width - 23, 40) Text:numStr fontSize:34 color:[UIColor whiteColor] isbold:YES];
    num_lb.textAlignment = NSTextAlignmentRight;
    [vv addSubview:num_lb];
    
    return vv;
}

- (UIView *)showterminalNumViewframe:(CGRect)frame numStr:(NSString *)numStr unitStr:(NSString *)unitStr
{
    UIView* vv = [[UIView alloc] initWithFrame:frame];
    vv.backgroundColor = [UIColor colorWithHex:@"#4D8CEB"];
    vv.layer.cornerRadius = 8;
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 24, 24)];
    imgv.image = [SVGKImage imageNamed:@"icon_iot"].UIImage;
    [vv addSubview:imgv];
    UILabel* lb = [UILabel z_frame:CGRectMake(imgv.right + 7, 0, vv.width - (imgv.right + 7), 24) Text:NSLocalizedString(@"终端数值", nil) fontSize:17 color:[UIColor whiteColor] isbold:NO];
    lb.centerY = imgv.centerY;
    [vv addSubview:lb];
    UILabel* unit_lb = [UILabel z_frame:CGRectMake(vv.width - 23 - 100, 0, 100, 20) Text:unitStr fontSize:14 color:[UIColor whiteColor] isbold:NO];
    unit_lb.textAlignment = NSTextAlignmentRight;
    unit_lb.centerY = imgv.centerY;
    [vv addSubview:unit_lb];
    UILabel* num_lb = [UILabel z_frame:CGRectMake(0, vv.height - 60, vv.width - 23, 40) Text:numStr fontSize:34 color:[UIColor whiteColor] isbold:YES];
    num_lb.textAlignment = NSTextAlignmentRight;
    [vv addSubview:num_lb];
    
    return vv;
    
}

- (UIView *)showconversionNumViewframe:(CGRect)frame numStr:(NSString *)numStr unitStr:(NSString *)unitStr
{
    UIView* vv = [[UIView alloc] initWithFrame:frame];
    vv.backgroundColor = [UIColor colorWithHex:@"#AE63EE"];
    vv.layer.cornerRadius = 8;
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 24, 24)];
    imgv.image = [SVGKImage imageNamed:@"icon_iot"].UIImage;
    [vv addSubview:imgv];
    UILabel* lb = [UILabel z_frame:CGRectMake(imgv.right + 7, 0, vv.width - (imgv.right + 7), 24) Text:NSLocalizedString(@"换算值", nil) fontSize:17 color:[UIColor whiteColor] isbold:NO];
    lb.centerY = imgv.centerY;
    [vv addSubview:lb];
    UILabel* unit_lb = [UILabel z_frame:CGRectMake(vv.width - 23 - 100, 0, 100, 20) Text:unitStr fontSize:14 color:[UIColor whiteColor] isbold:NO];
    unit_lb.textAlignment = NSTextAlignmentRight;
    unit_lb.centerY = imgv.centerY;
    [vv addSubview:unit_lb];
    UILabel* num_lb = [UILabel z_frame:CGRectMake(0, vv.height - 60, vv.width - 23, 40) Text:numStr fontSize:34 color:[UIColor whiteColor] isbold:YES];
    num_lb.textAlignment = NSTextAlignmentRight;
    [vv addSubview:num_lb];
    
    return vv;
}




@end
