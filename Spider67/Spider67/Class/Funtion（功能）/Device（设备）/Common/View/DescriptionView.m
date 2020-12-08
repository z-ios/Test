//
//  DescriptionView.m
//  Spider67
//
//  Created by 宾哥 on 2020/11/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DescriptionView.h"

@implementation DescriptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setType:(DescriptionType)type
{
    _type = type;
    switch (_type) {
        case Small:
            [self xiaomokuaishuoming];
            break;
        case SmallChannel:
            [self xiaomokuaichannel];
            break;
        case SmallGs:
            [self xiaomokuaigongshi];
            break;
        case SmallAlarm:
            [self xiaomokuaialarm];
            break;
        case SmallLinkage:
            [self xiaomokuailinkage];
            break;
        case WgChannel:
            [self wgchannel];
            break;
            
        default:
            break;
    }
}

- (void)xiaomokuaishuoming
{
    UILabel* iot_tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"IoTHub数值" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:iot_tl_lb];
    
    UILabel* iot_lb = [UILabel z_frame:CGRectMake(25, iot_tl_lb.bottom + 2, self.width - 50, 48) Text:@"应用订阅的IoTHub原始数值，非终端电流、电压值" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:iot_lb];
    
    UILabel* zd_tl_lb = [UILabel z_frame:CGRectMake(25, iot_lb.bottom + 34, self.width - 50, 20) Text:@"终端数值" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:zd_tl_lb];
    
    UILabel* zd_lb = [UILabel z_frame:CGRectMake(25, zd_tl_lb.bottom + 2, self.width - 50, 48) Text:@"由IoTHub与Spider67 Mobile 固有协议换算后的电流值或电压值" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:zd_lb];
    
    UILabel* hs_tl_lb = [UILabel z_frame:CGRectMake(25, zd_lb.bottom + 34, self.width - 50, 20) Text:@"换算值" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:hs_tl_lb];
    
    UILabel* hs_lb = [UILabel z_frame:CGRectMake(25, hs_tl_lb.bottom + 2, self.width - 50, 72) Text:@"由电流值或电压值经自定义公式换算后的可读应用数值，公式通常由Spider67 Mobile连接的终端电气供应商所提供" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:hs_lb];
}

- (void)xiaomokuaichannel
{
    UILabel* tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"模拟量channel type 限定规则" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:tl_lb];
    
    UILabel* lb = [UILabel z_frame:CGRectMake(25, tl_lb.bottom + 2, self.width - 50, 330) Text:@"CH3_AI_INPUT, CH4_AI_INPUT, CH3_AI_OUTPUT, CH4_AI_OUTPUT:\nAN_0_20mA\nAN_4_20mA\nAN_0_24mA\nAN_24_24mA\nANCHOFF (by default)\n\nCH3_AV_INPUT, CH4_AV_INPUT, CH3_AV_OUTPUT, CH4_AV_OUTPUT:\nAN_0_10V\nAN_10_10V\nAN_0_5V\nAN_5_5V\nANCHOFF (by default)" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:lb];

}

- (void)xiaomokuaigongshi
{
    UILabel* tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"仅支持一元四则运算公式，如：" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:tl_lb];
    
    UILabel* lb = [UILabel z_frame:CGRectMake(25, tl_lb.bottom + 2, self.width - 50, 180) Text:@"y=(x-12)*12/3+2  x为电流、电压值\n\n公式通常由Spider67 Mobile连接的终端电气供应商所提供\n\n若未配置公式，则 换算值 = 电流、电压值" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:lb];
}

- (void)xiaomokuaialarm
{
    UILabel* tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"模拟量channel 高低阈值告警识别" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:tl_lb];
    
    UILabel* lb = [UILabel z_frame:CGRectMake(25, tl_lb.bottom + 2, self.width - 50, 100) Text:@"设置高阈值， 则进行 逻辑 “>” 判断\n\n设置低阈值， 则进行 逻辑 “<” 判断" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:lb];

}


- (void)xiaomokuailinkage
{
    
    UIScrollView* scrlV = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrlV.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrlV];
    
    UILabel* tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"最多支持8条联动逻辑" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [scrlV addSubview:tl_lb];
    
    UILabel* tl_lb1 = [UILabel z_frame:CGRectMake(25, tl_lb.bottom + 5, self.width - 50, 20) Text:@"支持的执行channel   (OUTPUT) ：" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [scrlV addSubview:tl_lb1];
    
    UILabel* lb1 = [UILabel z_frame:CGRectMake(25, tl_lb1.bottom + 2, self.width - 50, 230) Text:@"P4 A   |   module_1.channel_0\nP4 B   |   module_1.channel_1\nP5 A   |   module_1.channel_2\nP5 B   |   module_1.channel_3\nP6 A   |   module_1.channel_4\nP6 B   |   module_1.channel_5\nP7 A   |   module_1.channel_6\nP8 B   |   module_1.channel_7\n\n执行channel （OUTPUT）：触发channel (INPUT)" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [scrlV addSubview:lb1];

    
    UILabel* tl_lb2 = [UILabel z_frame:CGRectMake(25, lb1.bottom + 5, self.width - 50, 20) Text:@"数字量联动规则：" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [scrlV addSubview:tl_lb2];
    
    UILabel* lb2 = [UILabel z_frame:CGRectMake(25, tl_lb2.bottom + 2, self.width - 50, 100) Text:@"同步 ( = )  —>    INPUT = true OUTPUT = true\n取反 ( != )  —>   INPUT = true OUTPUT = false" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [scrlV addSubview:lb2];

    
    UILabel* tl_lb3 = [UILabel z_frame:CGRectMake(25, lb2.bottom + 5, self.width - 50, 20) Text:@"模拟量联动规则：" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [scrlV addSubview:tl_lb3];
    
    UILabel* lb3 = [UILabel z_frame:CGRectMake(25, tl_lb3.bottom + 2, self.width - 50, 70) Text:@"识别逻辑真值  —>    OUTPUT = true\n识别逻辑假值  —>    OUTPUT = false" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [scrlV addSubview:lb3];
    
    scrlV.contentSize = CGSizeMake(0, self.height + 125);

}

- (void)wgchannel
{
    UILabel* tl_lb = [UILabel z_frame:CGRectMake(25, 0, self.width - 50, 20) Text:@"数字量channel type 限定规则" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    [self addSubview:tl_lb];
    
    UILabel* lb = [UILabel z_frame:CGRectMake(25, tl_lb.bottom + 2, self.width - 50, 230) Text:@"CH8_DUP_M12, CH8_DUP_M8:\nINPUT\nOUTPUT\nUNIVERSAL (by default)\n\nCH8_DI_M12, CH8_DI_M8:\nINPUT\n\nCH8_DO_M12, CH8_DO_M8:\nOUTPUT\n" fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [self addSubview:lb];

}

@end
