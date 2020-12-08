//
//  SetScrollView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SetScrollView.h"
#import "SetView.h"
#import "SetVersonView.h"

@interface SetScrollView ()

@end
@implementation SetScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}



- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.contentSize = CGSizeMake(self.width, SPH(900));
    
    UILabel* setTitleLb = [UILabel z_frame:CGRectMake(SPW(16), SPH(25), self.width - SPW(16)*2, SPH(33)) Text:NSLocalizedString(@"应用设置", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    [self addSubview:setTitleLb];
    
    SetView* httpView = [[SetView alloc] initWithFrame:CGRectMake(setTitleLb.x, setTitleLb.bottom + SPH(15), self.width - setTitleLb.x*2, SPH(141))];
    httpView.sliderType = HTTP;
    httpView.setTitleLb.text = NSLocalizedString(@"HTTP请求超时时限", nil);
    [self addSubview:httpView];
    
    SetView* webSocketView = [[SetView alloc] initWithFrame:CGRectMake(setTitleLb.x, httpView.bottom + SPH(10), self.width - setTitleLb.x*2, SPH(141))];
    webSocketView.sliderType = WEBSOCKET;
    webSocketView.setTitleLb.text = NSLocalizedString(@"websocket重连次数", nil);
    [self addSubview:webSocketView];
    
    SetView* bleView = [[SetView alloc] initWithFrame:CGRectMake(setTitleLb.x, webSocketView.bottom + SPH(10), self.width - setTitleLb.x*2, SPH(141))];
    bleView.sliderType = BLE;
    bleView.setTitleLb.text = NSLocalizedString(@"BLE重连次数", nil);
    [self addSubview:bleView];
    
    UILabel* setversonLb = [UILabel z_frame:CGRectMake(setTitleLb.x, bleView.bottom + SPH(30), self.width - SPW(16)*2, SPH(33)) Text:NSLocalizedString(@"版本信息", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
       [self addSubview:setversonLb];
    
    SetVersonView* versonView = [[SetVersonView alloc] initWithFrame:CGRectMake(setTitleLb.x, setversonLb.bottom + SPH(15), self.width - setTitleLb.x*2, SPH(260))];
    [self addSubview:versonView];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
