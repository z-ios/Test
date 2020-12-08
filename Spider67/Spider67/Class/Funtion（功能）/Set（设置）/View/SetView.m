//
//  SetView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SetView.h"
#import "StepSlider.h"

@interface SetView ()

@property (nonatomic, strong) UILabel* numLb;

@end
@implementation SetView

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
    self.layer.masksToBounds = YES;

    [self addSubview:self.setTitleLb];
    
    [self addSubview:self.numLb];
    
    
    
   
    
}

- (void)setSliderType:(SetSliderType)sliderType
{
    _sliderType = sliderType;
    
    switch (_sliderType) {
           case HTTP:
               [self setHttpSlider];
               break;
               case WEBSOCKET:
               [self setWebSockerSlider];
               break;
               case BLE:
               [self setBleSlider];
               break;

           default:
               break;
       }
}

- (void)setHttpSlider
{
    StepSlider* sld = [[StepSlider alloc] initWithFrame:CGRectMake(SPW(12),self.setTitleLb.bottom , self.bounds.size.width - SPW(12)*2, 150)];
    [self addSubview:sld];
    
    sld.backgroundColor = [UIColor whiteColor];
    sld.tintColor = [UIColor colorWithHex:@"#26C464"];
    sld.trackColor = [UIColor colorWithHex:@"#DADDE2"];
    sld.trackHeight = 3;
    sld.trackCircleRadius = 1.5;
    sld.sliderCircleRadius = 12;
    sld.sliderCircleImage = [UIImage imageNamed:@"slider_control_circle"];
    sld.mintrackCircleLabel.string = @"3s";
    sld.maxtrackCircleLabel.string = @"10s";
    sld.maxCount = 8;
    [sld setIndex:0];
    sld.sliderCircleLabel.string = @"3";
    self.numLb.text = @"3s";
    
    [sld addTarget:self action:@selector(httpSliderChangeAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)setWebSockerSlider
{
    StepSlider* sld = [[StepSlider alloc] initWithFrame:CGRectMake(SPW(12),self.setTitleLb.bottom , self.bounds.size.width - SPW(12)*2, 150)];
    [self addSubview:sld];
    
    sld.backgroundColor = [UIColor whiteColor];
    sld.tintColor = [UIColor colorWithHex:@"#26C464"];
    sld.trackColor = [UIColor colorWithHex:@"#DADDE2"];
    sld.trackHeight = 3;
    sld.trackCircleRadius = 1.5;
    sld.sliderCircleRadius = 12;
    sld.sliderCircleImage = [UIImage imageNamed:@"slider_control_circle"];
    sld.mintrackCircleLabel.string = @"3";
    sld.maxtrackCircleLabel.string = @"5";
    sld.maxCount = 3;
    [sld setIndex:0];
    sld.sliderCircleLabel.string = @"3";
    self.numLb.text = [NSString stringWithFormat:@"3%@",NSLocalizedString(@"次", nil)];
    
    [sld addTarget:self action:@selector(webSocketSliderChangeAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)setBleSlider
{
    StepSlider* sld = [[StepSlider alloc] initWithFrame:CGRectMake(SPW(12),self.setTitleLb.bottom , self.bounds.size.width - SPW(12)*2, 150)];
    [self addSubview:sld];
    
    sld.backgroundColor = [UIColor whiteColor];
    sld.tintColor = [UIColor colorWithHex:@"#26C464"];
    sld.trackColor = [UIColor colorWithHex:@"#DADDE2"];
    sld.trackHeight = 3;
    sld.trackCircleRadius = 1.5;
    sld.sliderCircleRadius = 12;
    sld.sliderCircleImage = [UIImage imageNamed:@"slider_control_circle"];
    sld.mintrackCircleLabel.string = @"3";
    sld.maxtrackCircleLabel.string = @"5";
    sld.maxCount = 3;
    [sld setIndex:0];
    sld.sliderCircleLabel.string = @"3";
    self.numLb.text = [NSString stringWithFormat:@"3%@",NSLocalizedString(@"次", nil)];
    
    [sld addTarget:self action:@selector(bleSliderChangeAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)httpSliderChangeAction:(StepSlider *)sender {
    
    sender.sliderCircleLabel.string = [NSString stringWithFormat:@"%zd",sender.index+3];
    self.numLb.text = [NSString stringWithFormat:@"%zds",sender.index+3];
    [[NSUserDefaults standardUserDefaults] setFloat:sender.index+3 forKey:@"httptimeout"];

}

- (void)webSocketSliderChangeAction:(StepSlider *)sender {
    
    sender.sliderCircleLabel.string = [NSString stringWithFormat:@"%zd",sender.index+3];
    self.numLb.text = [NSString stringWithFormat:@"%zd%@",sender.index+3,NSLocalizedString(@"次", nil)];
    [[NSUserDefaults standardUserDefaults] setInteger:sender.index+3 forKey:@"websocketreset"];
}

- (void)bleSliderChangeAction:(StepSlider *)sender {
    
    sender.sliderCircleLabel.string = [NSString stringWithFormat:@"%zd",sender.index+3];
    self.numLb.text = [NSString stringWithFormat:@"%zd%@",sender.index+3,NSLocalizedString(@"次", nil)];
    [[NSUserDefaults standardUserDefaults] setInteger:sender.index+3 forKey:@"blereset"];
}

- (UILabel *)setTitleLb
{
    if (!_setTitleLb) {
        _setTitleLb  = [UILabel z_frame:CGRectMake(SPW(20), SPH(20), self.width - SPW(20+16) - SPW(60), SPH(24)) Text:@"HTTP请求超时时限" fontSize:16 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
       
    }
    return _setTitleLb;
}

- (UILabel *)numLb
{
    if (!_numLb) {
        _numLb  = [UILabel z_frame:CGRectMake(self.width - SPW(16) - SPW(60), SPH(20), SPW(60), SPH(24)) Text:@"5s" fontSize:17 color:[UIColor colorWithHex:@"#26C464"] isbold:NO];
        _numLb.textAlignment = NSTextAlignmentRight;
  
    }
    return _numLb;
}

@end
