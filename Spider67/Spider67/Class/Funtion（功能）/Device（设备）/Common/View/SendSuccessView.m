//
//  SendSuccessView.m
//  Spider67
//
//  Created by 宾哥 on 2020/11/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendSuccessView.h"

@interface SendSuccessView ()

@property (nonatomic, copy) void(^resultBlock)(void);

@end
@implementation SendSuccessView


+ (void)showSuccess:(BOOL)isSuccess vc:(UIViewController *)vc note:(NSString *)note completion:(void (^ __nullable)(void))completion;
{
    SendSuccessView* view = [[SendSuccessView alloc] initWithFrame:vc.view.bounds];
    view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [vc.view addSubview:view];
    [view showSuccess:isSuccess vc:vc note:note completion:completion];
}

- (void)showSuccess:(BOOL)isSuccess vc:(UIViewController *)vc note:(NSString *)note completion:(void (^ __nullable)(void))completion;
{
    [self setupUI:isSuccess note:note];
    self.resultBlock = completion;
}

- (void)sucbtnClick
{
    if (self.resultBlock) {
        self.resultBlock();
    }
}

- (void)setupUI:(BOOL)isSuccess note:(NSString *)note
{
    if (isSuccess) {
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 280)*0.5, SPH(220), 280, 219)];
        imgV.image = [UIImage imageNamed:@"pic_suceessful"];
        [self addSubview:imgV];
        
        UILabel* lb = [UILabel z_frame:CGRectMake(0, imgV.bottom + 25, 200, 28) Text:@"下发成功！" fontSize:20 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.centerX = imgV.centerX;
        [self addSubview:lb];
        
        UIButton* sucbtn = [UIButton z_frame:CGRectMake(0, lb.bottom + 10, 90, 42) fontSize:18 cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#26C464"] titleColor:[UIColor whiteColor] title:@"返回" isbold:YES Target:self action:@selector(sucbtnClick)];
        sucbtn.centerX = imgV.centerX;
        [self addSubview:sucbtn];
        
        UILabel* timelb = [UILabel z_frame:CGRectMake(0, sucbtn.bottom + 5, 200, 28) Text:@"5s后自动返回" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        timelb.textAlignment = NSTextAlignmentCenter;
        timelb.centerX = imgV.centerX;
        [self addSubview:timelb];
        [self daojishi:timelb];
    }else{
        
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 280)*0.5, SPH(220), 280, 219)];
        imgV.image = [UIImage imageNamed:@"pic_failure"];
        [self addSubview:imgV];
        
        UILabel* lb = [UILabel z_frame:CGRectMake(0, imgV.bottom + 25, 200, 28) Text:@"下发失败！" fontSize:20 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.centerX = imgV.centerX;
        [self addSubview:lb];
        
        UILabel* notelb = [UILabel z_frame:CGRectMake(0, lb.bottom + 5, 200, 40) Text:note fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        notelb.textAlignment = NSTextAlignmentCenter;
        notelb.centerX = imgV.centerX;
        [self addSubview:notelb];

        
        UIButton* sucbtn = [UIButton z_frame:CGRectMake(0, notelb.bottom + 20, 90, 42) fontSize:18 cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#26C464"] titleColor:[UIColor whiteColor] title:@"返回" isbold:YES Target:self action:@selector(sucbtnClick)];
        sucbtn.centerX = imgV.centerX;
        [self addSubview:sucbtn];
    }

}

//------------***第三种方法***------------
/**
 *  1、获取或者创建一个队列，一般情况下获取一个全局的队列
 *  2、创建一个定时器模式的事件源
 *  3、设置定时器的响应间隔
 *  4、设置定时器事件源的响应回调，当定时事件发生时，执行此回调
 *  5、启动定时器事件
 *  6、取消定时器dispatch源，【必须】
 *
 */
#pragma mark GCD实现
- (void)daojishi:(UILabel *)lb{
    __block NSInteger second = 5;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                lb.text = [NSString stringWithFormat:@"%zds后自动返回",second];
                if (self.resultBlock) {
                    self.resultBlock();
                }
                second = 5;
                //(6)
                dispatch_cancel(timer);
            } else {
                lb.text = [NSString stringWithFormat:@"%zds后自动返回",second];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
}


@end
