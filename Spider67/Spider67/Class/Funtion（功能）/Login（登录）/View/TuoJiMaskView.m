//
//  TuoJiMaskView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TuoJiMaskView.h"
#import "TuoJiView.h"

@interface TuoJiMaskView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) TuoJiView* tjView;

@end
@implementation TuoJiMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.65];
    
    //1.创建手势对象
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    
    [self addSubview:self.tjView];
    
    [UIView animateWithDuration:0.55f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alpha = 1;
        self.tjView.y = self.height - SPH(340);
    } completion:nil];
    
    zWEAKSELF
    weakSelf.tjView.cancelBlock = ^{
        [UIView animateWithDuration:0.55f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
            self.tjView.y = self.height;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.tjView removeFromSuperview];
        }];
        
    };
    
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:tap.view];
    if (!CGRectContainsPoint(self.tjView.frame, point)) {
      [UIView animateWithDuration:0.55f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
            self.tjView.y = self.height;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.tjView removeFromSuperview];
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    // 点击了tableViewCell，view的类名为UITableViewCellContentView，则不接收Touch点击事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

- (TuoJiView *)tjView
{
    if (!_tjView) {
        _tjView = [[TuoJiView alloc] initWithFrame:CGRectMake(0, self.height, self.width, SPH(340))];
    }
    
    return _tjView;
}


@end
