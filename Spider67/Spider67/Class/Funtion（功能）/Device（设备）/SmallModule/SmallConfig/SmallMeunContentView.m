//
//  SmallMeunContentView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallMeunContentView.h"
#import "SmallMeunCell.h"
#import "SmallChannelConfigView.h"
#import "SmallFormulaConfigView.h"
#import "SmallWarnConfigView.h"
#import "SmallLinkageConfigView.h"
#import "ChannelListModel.h"
#import "SmallMeunHeaderView.h"

@interface SmallMeunContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataList;

@end
@implementation SmallMeunContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    

    
}

- (void)setChannelModel:(ChannelListModel *)channelModel
{
    _channelModel = channelModel;
    
    self.backgroundColor = [UIColor whiteColor];
    
    _dataList = @[
        @{@"imgname":@"icon_channelconfi",@"name":NSLocalizedString(@"channel配置", nil)},
        @{@"imgname":@"icon_formula",@"name":NSLocalizedString(@"公式配置", nil)},
        @{@"imgname":@"icon_alertconfi",@"name":NSLocalizedString(@"告警设置", nil)},
        @{@"imgname":@"icon_linkageconfi",@"name":NSLocalizedString(@"联动配置", nil)}
    ];
    
    SmallMeunHeaderView* heaerV = [[SmallMeunHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 370)];
    heaerV.channelModel = _channelModel;
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, self.width, self.height - 25) style:(UITableViewStylePlain)];
    tableView.backgroundColor =  [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 73;
    
    tableView.tableHeaderView = heaerV;
    
    [self addSubview:tableView];
    
    [tableView registerClass:[SmallMeunCell class] forCellReuseIdentifier:@"SmallMeunCell"];
    
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmallMeunCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SmallMeunCell" forIndexPath:indexPath];
    cell.dict = _dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [CenterNet.shared ChannelConfigParm:_channelModel.device_id channelName:_channelModel.channelname completion:^(NSDictionary *nu_dict) {
        switch (indexPath.row) {
            case 0:
            {
                SmallChannelConfigView* vv = [[SmallChannelConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
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
            case 1:
            {
                SmallFormulaConfigView* vv = [[SmallFormulaConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.group_id = self.group_id;
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
                SmallWarnConfigView* vv = [[SmallWarnConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.group_id = self.group_id;
                vv.moduletype = self.moduletype;
                vv.pabStr = self.channelModel.port;
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
                SmallLinkageConfigView* vv = [[SmallLinkageConfigView alloc] initWithFrame:CGRectMake(zScreenWidth, 0, zScreenWidth, zScreenHeight)];
                vv.alpha = 0;
                vv.group_id = self.group_id;
                vv.moduletype = self.moduletype;
                vv.pabStr = self.channelModel.port;
                vv.dict = nu_dict;
                
                [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    vv.alpha = 1;
                    vv.x = 0;
                } completion:nil];
                [zAppWindow.rootViewController.view addSubview:vv];
            }
                break;
                
            default:
                break;
        }
    }];
}

@end
