//
//  MBhud.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MBhud.h"
#import "CustomView.h"

@implementation MBhud

+ (instancetype)shared{
    
    static MBhud *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    instance = [MBhud new];

    });
    return  instance;
}

+ (void)showText:(NSString *)text addView:(UIView *)addView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];

    // Set the label text.
    hud.label.text = text;

    //    hud.square = YES;
    //    hud.minSize = CGSizeMake(10, 10);
    hud.margin = 10;
    //    hud.label.textColor = [UIColor redColor];
    hud.label.font = [UIFont systemFontOfSize:15];

    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor colorWithHex:@"#000000" alpha:0.85];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;

    hud.mode = MBProgressHUDModeText;
    //    hud.label.text = NSLocalizedString(@"Message here!", @"HUD message title");
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, zScreenHeight*0.35);
    [hud hideAnimated:YES afterDelay:1];
}

- (void)showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location 
{
    CustomView* cusV = [[CustomView alloc] init];
    _hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.customView = cusV;
    _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _hud.offset = CGPointMake(0.f, location);
    _hud.completionBlock = ^{
        [cusV.timer invalidate];
    };

}

- (void)showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location completion:(void (^ __nullable)(MBProgressHUD * _Nonnull hud))completion
{
    CustomView* cusV = [[CustomView alloc] init];
    _hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.customView = cusV;
    _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    _hud.offset = CGPointMake(0.f, location);
    _hud.completionBlock = ^{
        [cusV.timer invalidate];
    };
    cusV.timeOutBlock = ^{
        [self.hud hideAnimated:YES];
        completion(self.hud);
    };
}



- (void)once_showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location
{
    _hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    
    _hud.label.text = text;
    _hud.margin = 10;
    
    _hud.label.font = [UIFont systemFontOfSize:15];
    _hud.contentColor = [UIColor whiteColor];
    _hud.bezelView.color = [UIColor colorWithHex:@"#000000" alpha:0.85];
    _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    _hud.mode = MBProgressHUDModeText;
    
    _hud.offset = CGPointMake(0.f, location);

}

- (void)showHudText:(NSString *)text addView:(UIView *)addView
{

    _hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    _hud.label.text = text;
    _hud.margin = 10;
    _hud.label.font = [UIFont systemFontOfSize:15];
    _hud.contentColor = [UIColor colorWithHex:@"#EAEBEC"];
    _hud.bezelView.color = [UIColor colorWithHex:@"#7E7F80"];
    _hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;

}

@end
