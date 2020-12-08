//
//  LogController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LogController.h"
#import "XLSlideSwitch.h"
#import "LogAlarmController.h"
#import "LogSendController.h"
#import "LogChannelController.h"
#import "LogEditorController.h"

@interface LogController ()<XLSlideSwitchDelegate>

@property (nonatomic, strong) XLSlideSwitch *slideSwitch;

@end

@implementation LogController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self.view addSubview:self.slideSwitch];
 

}

#pragma mark SlideSwitchDelegate

-(void)slideSwitchDidselectTab:(NSUInteger)index
{
    //可以通过viewWillAppear方法加载数据
//    UIViewController * vc = _slideSwitch.viewControllers[index];
//    [vc viewWillAppear:YES];
}

-(void)slideSwitchPanLeftEdge:(UIPanGestureRecognizer *)panParam
{
    NSLog(@"滑动到左边缘，可以处理滑动返回等一些问题");
}

#pragma mark lazy

- (XLSlideSwitch *)slideSwitch
{
    if (!_slideSwitch) {
        _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 88, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _slideSwitch.delegate = self;
        _slideSwitch.btnSelectedColor = [UIColor colorWithHex:@"#121212"];
        _slideSwitch.btnNormalColor = [UIColor colorWithHex:@"#92969D"];
        NSArray *titles = @[@"告警日志",
                            @"下发动作日志",
                            @"channel上报日志",
                            @"编辑日志"];
        
        NSArray* viewControllers = @[[LogAlarmController new],[LogSendController new],[LogChannelController new],[LogEditorController new]];
        [viewControllers enumerateObjectsUsingBlock:^(UIViewController*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = titles[idx];
        }];
        _slideSwitch.viewControllers = viewControllers.mutableCopy;
    }
    return _slideSwitch;
}

@end
