//
//  PointView.m
//  Spider67
//
//  Created by 宾哥 on 2020/11/4.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PointView.h"

@implementation PointView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];;
        
    }
    return self;
}

+ (void)showPointView:(UIView *)view
{
    PointView* pview = [PointView new];
    [[UIApplication sharedApplication].keyWindow addSubview:pview];
    [pview showPointView:view];
}

- (void)showPointView:(UIView *)view
{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[view convertRect: view.bounds toView:window];
    UIView* clyView = [[UIView alloc] initWithFrame:CGRectMake((rect.size.width - SPH(58))*0.5 + rect.origin.x, rect.origin.y - 2, SPH(58), SPH(58))];
    clyView.backgroundColor = [UIColor clearColor];
    clyView.layer.borderWidth = 3;
    clyView.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    
    clyView.layer.shadowColor = [UIColor colorWithHex:@"#1FF774"].CGColor;
    // 阴影偏移，默认(0, -3)
    clyView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    clyView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
//    clyView.layer.shadowRadius = 5;
    clyView.layer.cornerRadius = SPH(29);

    [self addSubview:clyView];
    
    UILabel* aowlb = [UILabel z_frame:CGRectMake(0, clyView.bottom + SPH(12), 160, 42) Text:@"⬆️\n点击port即可配置" fontSize:17 color:[UIColor whiteColor] isbold:YES];
    aowlb.textAlignment = NSTextAlignmentCenter;
    aowlb.centerX = clyView.centerX;
    [self addSubview:aowlb];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0;
    } completion:^(BOOL finished) {
        [[NSUserDefaults standardUserDefaults] setObject:@"y" forKey:@"wgpoint"];
        [self removeFromSuperview];
    }];
}

@end
