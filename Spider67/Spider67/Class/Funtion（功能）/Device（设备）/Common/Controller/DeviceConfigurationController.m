//
//  DeviceConfigurationController.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceConfigurationController.h"
#import "DeviceConfigurationCell.h"
#import "LandScapePicker.h"
#import "PageMaskView.h"
#import "DeviceModelConfigurationCell.h"
#import "ReportPeriodController.h"
#import "FotaController.h"
#import "SendConfigController.h"
#import "SendLinkageController.h"
#import "ModulesListModel.h"
#import "ChannelListModel.h"

@interface DeviceConfigurationController ()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,WebSocketManagerDelegate>

@property (nonatomic ,strong) LandScapePicker *pickerView;
@property (nonatomic ,strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) UIButton* pageBtn;
@property (nonatomic, strong) NSDictionary* deviceInfoDict;
@property (nonatomic, strong) NSArray<ModulesListModel *>* models;

@end

@implementation DeviceConfigurationController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithHex:@"#F6F8FA"];
    
    // 开启websocket
    [[WebSocketManager shared] connectServer];
    [WebSocketManager shared].delegate = self;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 关闭websocket
    [[WebSocketManager shared] webSocketClose];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.title = _devicename;
    self.navigationController.navigationBar.barTintColor =  [UIColor colorWithHex:@"#F6F8FA"];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
    } else {
        // Fallback on earlier versions
    }
    
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTitle:nil backgroundImage:[SVGKImage imageNamed:@"icon_more_config"].UIImage target:self action:@selector(moreConfig)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.pagerView];
    
    // 注册cell
    [self.pagerView registerClass:[DeviceConfigurationCell class] forCellWithReuseIdentifier:@"DeviceConfigurationCell"];
    [self.pagerView registerClass:[DeviceModelConfigurationCell class] forCellWithReuseIdentifier:@"DeviceModelConfigurationCell"];
    
    [CenterNet.shared DeviceEditorParm:_deviceId completion:^(NSDictionary *dict, BOOL success) {
        if (success) {
            NSArray * arr = dict[@"modules"];
            self.models = [NSArray yy_modelArrayWithClass:[ModulesListModel class] json:arr];
            [self addAlarmData:dict[@"alarms"]];
            self.deviceInfoDict = dict[@"device"];
            [self.pagerView reloadData];
            [self.view addSubview:self.pickerView];
            [self.view addSubview:self.pageBtn];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

- (void)addAlarmData:(NSArray *)alarmList
{
    if (alarmList.count > 0) {
        [alarmList enumerateObjectsUsingBlock:^(NSString*  _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array = [str componentsSeparatedByString:@"|"];
            [self.models enumerateObjectsUsingBlock:^(ModulesListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull channelModel, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([channelModel.channelname isEqualToString:array[0]]) {
                        if ([array[1] isEqualToString:@"H"]) {
                            channelModel.alarm_type = @"H";
                        }else{
                            channelModel.alarm_type = @"L";
                        }
                    }
                }];
            }];
        }];
    }
}

#pragma mark - websocket
-(void)websocketManagerDidReceiveMessageWithString:(NSString *)string{
    NSLog(@"string %@",string);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if ([dict[@"eventType"] isEqualToString:@"设备上报"]) {
        [_models enumerateObjectsUsingBlock:^(ModulesListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"channelname"] isEqualToString:obj.channelname]) {
                    obj.originalvalue = dict[@"msgContent"][@"value"];
                }
            }];
        }];
    }else if ([dict[@"eventType"] isEqualToString:@"频道告警"]) {
        [_models enumerateObjectsUsingBlock:^(ModulesListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"channelname"] isEqualToString:obj.channelname]) {
                    if ([dict[@"msgContent"][@"alarm_tag"] isEqualToString:@"高"]) {
                        obj.alarm_type = @"H";
                        obj.alarm_color_H = dict[@"msgContent"][@"alarm_color"];
                    }else{
                        obj.alarm_type = @"L";
                        obj.alarm_color_L = dict[@"msgContent"][@"alarm_color"];
                    }
                }
            }];
        }];
    }else if ([dict[@"eventType"] isEqualToString:@"频道消警"]) {
        [_models enumerateObjectsUsingBlock:^(ModulesListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.channels enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"channelname"] isEqualToString:obj.channelname]) {
                    obj.alarm_type = @"";
                }
            }];
        }];
    }
    
    [self.pagerView reloadData];
}

- (void)moreConfig
{
    NSArray *imageArr = @[@"icon_more_linkage", @"icon_more_sentconfi",@"icon_more_period",@"icon_more_fota"];
    NSArray *titleArr = @[NSLocalizedString(@"下发联动", nil),NSLocalizedString(@"下发配置", nil),NSLocalizedString(@"上报周期设置", nil),NSLocalizedString(@"FOTA管理", nil)];
    [XYMenu showMenuWithImages:imageArr titles:titleArr menuType:XYMenuRightNavBar currentNavVC:self.navigationController clickHide:YES withItemClickIndex:^(NSInteger index, BOOL isSort) {
        switch (index) {
            case 0:
            {
                SendLinkageController* vc = [SendLinkageController new];
                vc.deviceId = self.deviceId;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                SendConfigController* vc = [SendConfigController new];
                vc.deviceId = self.deviceId;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                ReportPeriodController* vc = [ReportPeriodController new];
                vc.deviceId = self.deviceId;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                FotaController* vc = [FotaController new];
                vc.deviceId = self.deviceId;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    
}

#pragma mark - 快速跳转页面
- (void)pageBtnClick
{
    
    [PageMaskView showPageViewWithFrame:self.pageBtn.frame vc:self totalCount:self.models.count - 1 curIndex:self.pagerView.curIndex completion:^(NSInteger pageNum) {
        [self.pagerView scrollToItemAtIndex:pageNum animate:YES];
        [self.pickerView selectRow:pageNum];
    }];
    
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.models.count - 1;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    if (index == 0) {
        DeviceConfigurationCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"DeviceConfigurationCell" forIndex:index];
        cell.deviceDict = self.deviceInfoDict;
        cell.model0 = _models[index];
        cell.model1 = _models[index + 1];
        return cell;
    }else
    {
        DeviceModelConfigurationCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"DeviceModelConfigurationCell" forIndex:index];
        cell.deviceDict = self.deviceInfoDict;
        cell.model = _models[index + 1];
        return cell;
    }
    
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(pageView.width - 32, pageView.height - 10);
    layout.itemSpacing = 24;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    [self.pickerView selectRow:toIndex];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
    
}

#pragma mark - lazy

- (TYCyclePagerView *)pagerView
{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]initWithFrame:CGRectMake(0, 20 + Height_NavBar, self.view.width, self.view.height - 10 - 84 - Height_NavBar)];
        _pagerView.isInfiniteLoop = NO;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        _pagerView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
       
    }
    return _pagerView;
}

- (LandScapePicker *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[LandScapePicker alloc] initWithFrame:CGRectMake((self.view.width - 200)*0.5, self.pagerView.bottom , 200, 45)];
        _pickerView.titleColor = [UIColor colorWithHex:@"#9FA3A8"];
        NSMutableArray* arrM = [NSMutableArray array];
        for (int i = 0; i < _models.count - 1; i++) {
            [arrM addObject:@(i).description];
        }
        _pickerView.pTitles = arrM.copy;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pickerView selectRow:0];
        });
    }
    return _pickerView;
}

- (UIButton *)pageBtn
{
    if (!_pageBtn) {
        _pageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 24 - 16, 0, 24, 24)];
        _pageBtn.centerY = self.pickerView.centerY;
        [_pageBtn setImage:[SVGKImage imageNamed:@"icon_quick_page"].UIImage forState:UIControlStateNormal];
        [_pageBtn addTarget:self action:@selector(pageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pageBtn;
}


@end
