//
//  SingleLogController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleLogController.h"
#import "SingleAlarmLogController.h"
#import "SingleSendLogController.h"
#import "SingleChannelLogController.h"
#import "SingleEditorLogController.h"
#import "BaseLogController.h"

@interface SingleLogController ()<XLSlideSwitchDelegate>

@property (nonatomic, strong) XLSlideSwitch *slideSwitch;
@property (nonatomic, strong) UIBarButtonItem *rightItem;
@property (nonatomic, strong) UIBarButtonItem *leftItem;

@end

@implementation SingleLogController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithHex:@"#F6F8FA"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
    
    [self setNavNor];
    
    [self.view addSubview:self.slideSwitch];

}

#pragma mark - nav
- (void)setNavNor{

    self.rightItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(moreConfig)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.leftItem =  [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = self.leftItem;
}
- (void)setNavSel{

    self.rightItem = [UIBarButtonItem itemWithTitle:@"全选" target:self action:@selector(allSelectedLog)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    self.leftItem = [UIBarButtonItem itemWithTitle:@"取消" target:self action:@selector(cancelAllSelectedLog)];
    self.navigationItem.leftBarButtonItem = self.leftItem;
}


- (void)moreConfig
{
    NSArray *imageArr = @[@"icon_screen",@"icon_delete"];
    NSArray *titleArr = @[NSLocalizedString(@"筛选", nil),NSLocalizedString(@"批量删除", nil)];
    [XYMenu showMenuWithImages:imageArr titles:titleArr menuType:XYMenuRightNavBar currentNavVC:self.navigationController clickHide:YES withItemClickIndex:^(NSInteger index, BOOL isSort) {
        switch (index) {
            case 0:
            {
                if ([self.delegate respondsToSelector:@selector(screenLog:)]) {
                    [self.delegate screenLog:self];
                }
                
            }
                break;
            case 1:
            {
                [self setNavSel];
                if ([self.delegate respondsToSelector:@selector(batchDeletionLog)]) {
                    [self.delegate batchDeletionLog];
                }
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}


- (void)allSelectedLog
{
    if ([self.delegate respondsToSelector:@selector(logAllSelect)]) {
           [self.delegate logAllSelect];
       }
}
- (void)cancelAllSelectedLog
{
    if ([self.delegate respondsToSelector:@selector(logCancelSelect)]) {
           [self.delegate logCancelSelect];
       }
    [self setNavNor];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    self.slideSwitch.hidden = YES;
}

#pragma mark lazy

- (XLSlideSwitch *)slideSwitch
{
    if (!_slideSwitch) {
        _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, Height_NavBar, self.view.bounds.size.width, self.view.bounds.size.height - Height_NavBar)];
        _slideSwitch.delegate = self;
        _slideSwitch.btnSelectedColor = [UIColor colorWithHex:@"#121212"];
        _slideSwitch.btnNormalColor = [UIColor colorWithHex:@"#92969D"];
        NSArray *titles = @[
            
            NSLocalizedString(@"告警日志", nil),
            NSLocalizedString(@"下发动作日志", nil),
            NSLocalizedString(@"channel上报日志", nil),
            NSLocalizedString(@"编辑日志", nil)
            
        ];
        
        NSArray* vcNames = @[@"SingleAlarmLogController",@"SingleSendLogController",@"SingleChannelLogController",@"SingleEditorLogController"];
        NSMutableArray* viewControllers = [NSMutableArray array];
        [vcNames enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Class creatVc = NSClassFromString(obj);
            BaseLogController *baseVc = [[creatVc alloc]init];
            baseVc.vc = self;
            baseVc.group_id = _group_id;
            baseVc.device_id = _device_id;
            _slideSwitch.delegate = baseVc;
            baseVc.cancelSelectItem = ^{
                [self cancelAllSelectedLog];
            };
            baseVc.title = titles[idx];
            [viewControllers addObject:baseVc];
        }];
        
        _slideSwitch.viewControllers = viewControllers;
        _slideSwitch.selectedIndex = 0;
    }
    return _slideSwitch;
}


@end
