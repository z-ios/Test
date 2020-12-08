//
//  DescriptionMaskView.m
//  Spider67
//
//  Created by 宾哥 on 2020/11/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DescriptionMaskView.h"

CGFloat Height = 545;
CGFloat anmotime = 0.45f;
@interface DescriptionMaskView ()

@property (nonatomic, strong) UIView* desView;
@property (nonatomic, strong) DescriptionView* subView;

@end
@implementation DescriptionMaskView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
//        [self setUI];
        
    }
    return self;
}

+ (void)showPageViewWithtype:(DescriptionType)infoType;
{
    DescriptionMaskView* view = [DescriptionMaskView new];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view showPageViewWithtype:infoType];
    
}

- (void)showPageViewWithtype:(DescriptionType)infoType;
{
//    Height = infoType == SmallLinkage ? SPH(670) : 545;
    [self setUI];
    DescriptionView* desv = [[DescriptionView alloc] initWithFrame:CGRectMake(0, 105, zScreenWidth, self.height - 105)];
    desv.type = infoType;
    [self.desView addSubview:desv];
}

- (void)setUI{
    
    _desView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - Height, self.bounds.size.width, Height)];
    _desView.backgroundColor = [UIColor whiteColor];
    _desView.y = self.bounds.size.height;
    [UIView animateWithDuration:anmotime delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.desView.y = [UIScreen mainScreen].bounds.size.height - Height;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    } completion:nil];
    
    [self addSubview:_desView];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_desView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(32, 32)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    maskLayer.frame = _desView.bounds;

    maskLayer.path = maskPath.CGPath;

    _desView.layer.mask = maskLayer;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangesture:)];
    [_desView addGestureRecognizer:pan];

    UIView* lineV = [[UIView alloc] initWithFrame:CGRectMake((self.desView.width - 60)*0.5, 10, 60, 8)];
    lineV.layer.cornerRadius = 4;
    lineV.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.08];
    [_desView addSubview:lineV];
    
    UILabel* shuomingLb = [UILabel z_frame:CGRectMake(25, 40, self.width - 50, 33) Text:@"说明项" fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    [_desView addSubview:shuomingLb];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //获取点击点的坐标
    CGPoint touchPoint = [[touches  anyObject] locationInView:_desView];
//    判断 点（CGPoint）是否在某个范围（CGRect）内
    if (!CGRectContainsPoint(self.bounds, touchPoint)) {
        [UIView animateWithDuration:anmotime delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.desView.y = self.height;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)pangesture:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [recognizer locationInView:recognizer.view];
        
        if (location.y < 0 || location.y > recognizer.view.size.height) {
            return;
        }
        CGPoint translation = [recognizer translationInView:recognizer.view];
        
        recognizer.view.y = recognizer.view.y + translation.y;
        
        if (recognizer.view.y < [UIScreen mainScreen].bounds.size.height - Height) {
            recognizer.view.y = [UIScreen mainScreen].bounds.size.height - Height;
        }
        
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        //        NSLog(@"FlyElephant---视图拖动结束");
        CGPoint speed = [recognizer velocityInView:recognizer.view];
        NSLog(@"********%f",speed.y);
        if (speed.y > 180) {
            [UIView animateWithDuration:anmotime delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                recognizer.view.y = [UIScreen mainScreen].bounds.size.height;
                self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }else{
            if (recognizer.view.y > [UIScreen mainScreen].bounds.size.height - Height*0.5) {
                [UIView animateWithDuration:anmotime delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    recognizer.view.y = [UIScreen mainScreen].bounds.size.height;
                    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
                } completion:^(BOOL finished) {
                    [self removeFromSuperview];
                }];
            }else{
                [UIView animateWithDuration:anmotime delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    recognizer.view.y = [UIScreen mainScreen].bounds.size.height - Height;
                } completion:nil];
            }
        }
    }
}


@end
