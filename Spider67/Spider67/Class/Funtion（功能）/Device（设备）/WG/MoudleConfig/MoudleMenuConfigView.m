//
//  MoudleMenuConfigView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/21.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MoudleMenuConfigView.h"
#import "MoudleMenuCell.h"
#import "SendOrderView.h"
#import "ChannelConfigView.h"
#import "ChannelWarnView.h"
#import "LinkageConfigView.h"

@interface MoudleMenuConfigView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataList;

@end
@implementation MoudleMenuConfigView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _dataList = @[
        @{@"imgname":@"icon_device_update_m",@"name":NSLocalizedString(@"下发写值命令", nil)},
        @{@"imgname":@"icon_channelconfi",@"name":NSLocalizedString(@"channel配置", nil)},
        @{@"imgname":@"icon_alertconfi",@"name":NSLocalizedString(@"告警设置", nil)},
        @{@"imgname":@"icon_linkageconfi",@"name":NSLocalizedString(@"联动配置", nil)}
        
    ];
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tableView];
    [self.tableView registerClass:[MoudleMenuCell class] forCellReuseIdentifier:@"MoudleMenuCell"];
    
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoudleMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MoudleMenuCell" forIndexPath:indexPath];
    cell.dict = _dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [CenterNet.shared ChannelConfigParm:_dev_id channelName:_channel_name completion:^(NSDictionary *nu_dict) {
        
        switch (indexPath.row) {
            case 0:
            {
                SendOrderView* vv = [[SendOrderView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.dict = nu_dict;
                [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    vv.alpha = 1;
                    vv.x = 0;
                } completion:nil];
                [zAppWindow.rootViewController.view addSubview:vv];
            }
                break;
            case 1:
            {
                ChannelConfigView* vv = [[ChannelConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.moduletype = self.moduletype;
                vv.dict = nu_dict;
                [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    vv.alpha = 1;
                    vv.x = 0;
                } completion:nil];
                [zAppWindow.rootViewController.view addSubview:vv];
                
            }
                
                break;
            case 2:
            {
                ChannelWarnView* vv = [[ChannelWarnView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.pabStr = self.pabStr;
                vv.moduletype = self.moduletype;
                vv.group_id = self.group_id;
                vv.dict = nu_dict;
                [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    vv.alpha = 1;
                    vv.x = 0;
                } completion:nil];
                [zAppWindow.rootViewController.view addSubview:vv];
            }
                
                break;
            case 3:
            {
                
                if ([nu_dict[@"channelname"] hasPrefix:@"module_0"]) {
                    if ([nu_dict[@"channelname"] isEqualToString:@"OUTPUT"]) {
                        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? [NSString stringWithFormat:@"无法联动配置，若想继续，请将[%@] type 设置为： input、universal",self.pabStr] : [NSString stringWithFormat:@"Unable to link configuration, if you want to continue, please set [%@] type to: input, universal",self.pabStr];
                        [MBhud showText:textStr addView:zAppWindow];
                        return;
                    }
                }
                if ([nu_dict[@"channelname"] hasPrefix:@"module_1"]) {
                    if ([nu_dict[@"channelname"] isEqualToString:@"INPUT"]) {
                        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? [NSString stringWithFormat:@"无法联动配置，若想继续，请将[%@] type 设置为： output、universal",self.pabStr] : [NSString stringWithFormat:@"Unable to link configuration, if you want to continue, please set [%@] type to: output, universal",self.pabStr];
                        [MBhud showText:textStr addView:zAppWindow];
                        return;
                    }
                }
                
                [CenterNet.shared checkLinkageChannelCompletionParm:nu_dict[@"device_id"] completion:^(NSArray * _Nullable dataList) {
                    
                    LinkageConfigView* vv = [[LinkageConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                    vv.alpha = 0;
                    vv.pabStr = self.pabStr;
                    vv.moduletype = self.moduletype;
                    vv.group_id = self.group_id;
                    vv.dict = nu_dict;
                    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                        vv.alpha = 1;
                        vv.x = 0;
                    } completion:nil];
                    [zAppWindow.rootViewController.view addSubview:vv];
                    
                }];
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.width, self.height - 25) style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.rowHeight = 73;
    }
    return _tableView;
}


@end
