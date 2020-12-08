//
//  PageMaskView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "PageMaskView.h"
#import "QuickPageView.h"
#import "PageModel.h"

@interface PageMaskView ()<DevicePtc>

@property (nonatomic, strong) QuickPageView* quickPageView;
@property (nonatomic, assign) CGRect z_frame;
@property (nonatomic, copy) void(^BtnClick)(NSInteger pageNum) ;

@end
@implementation PageMaskView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, zScreenWidth, zScreenHeight);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (QuickPageView *)quickPageView
{
    if (!_quickPageView) {
        _quickPageView = [[QuickPageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    return _quickPageView;
}

+ (void)showPageViewWithFrame:(CGRect)frame vc:(UIViewController *)vc totalCount:(NSInteger)totalCount curIndex:(NSInteger)curIndex completion:(void (^ __nullable)(NSInteger pageNum))completion
{
    PageMaskView *maskV = [[PageMaskView alloc] init];
    [vc.view addSubview:maskV];
    [maskV showPageViewWithFrame:frame totalCount:totalCount curIndex:curIndex completion:completion];
}

- (void)showPageViewWithFrame:(CGRect)frame totalCount:(NSInteger)totalCount curIndex:(NSInteger)curIndex completion:(void (^ __nullable)(NSInteger pageNum))completion
{
    for (int i = 0; i<totalCount; i++) {
        PageModel* model = [PageModel new];
        if (i == 0) {
            model.pageNumStr = [NSString stringWithFormat:@"%@%d",NSLocalizedString(@"网关", nil),i];
        }else{
            model.pageNumStr = [NSString stringWithFormat:@"%d",i];
        }
        if (curIndex == i) {
            model.isSel = YES;
        }
        
        [self.quickPageView.arrData addObject:model];
    }
    
    NSInteger rowNum = ((totalCount+1)%4 == 0) ? ((totalCount + 1)/4) : (NSInteger)((totalCount + 1)/4 + 1);
    if (rowNum == 1) {
        rowNum = 2;
    }
    self.z_frame = frame;
    self.BtnClick = completion;
    self.quickPageView.delegate = self;
    [self addSubview:self.quickPageView];
    self.quickPageView.frame = CGRectMake(self.width - 16 , frame.origin.y - 12 , 0, 0);
    [UIView animateWithDuration:0.55f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.quickPageView.frame = CGRectMake(self.width - 242 - 16 , frame.origin.y - 12 - (74+ rowNum * 44), 242, 74+ rowNum * 44);
    } completion:nil];
 
}

- (void)pageBtnClick:(NSInteger)pageNum
{
    if (self.BtnClick) {
        self.BtnClick(pageNum);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取点击点的坐标
    CGPoint touchPoint = [[touches  anyObject] locationInView:self];
    //判断 点（CGPoint）是否在某个范围（CGRect）内
    if (!CGRectContainsPoint(self.quickPageView.frame, touchPoint)) {
        [self pageViewDismiss];
    }
    
    NSLog(@"ddfddf");
}


- (void)pageViewDismiss
{
    self.quickPageView.titleLb.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.quickPageView.frame = self.z_frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
