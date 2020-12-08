//
//  DeviceController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceController.h"
#import "DeviceCell.h"
#import "DeviceModel.h"
#import "DataSort.h"
#import "CustomGifHeader.h"
#import "DeviceConfigurationController.h"
#import "SingleLogController.h"

@interface DeviceController ()<UITableViewDelegate,UITableViewDataSource,DevicePtc,UISearchResultsUpdating,UISearchControllerDelegate,WebSocketManagerDelegate>

@property (nonatomic, strong) BaseTableView* tableView;
@property(nonatomic,strong) NSMutableArray<DeviceModel *> *resultArray;
@property(nonatomic,strong) NSMutableArray<DeviceModel *> *sort_resultArray;
@property(nonatomic,strong) UIRefreshControl* refreshControl;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) UIButton* paiXuBtn;

@end

@implementation DeviceController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor =  [UIColor whiteColor];
    
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

    [self setNavUI];
    [self setupUI];

}
-(NSMutableArray *)resultArray{
    
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}
- (NSMutableArray *)sort_resultArray
{
    if (!_sort_resultArray) {
        _sort_resultArray = [NSMutableArray array];
    }
    return _sort_resultArray;
}

- (UIRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = [UIColor grayColor];
//        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
        [_refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
    }
    
    return _refreshControl;
}

- (void)setNavUI
{
    
    self.navigationItem.title = NSLocalizedString(@"设备", nil);
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
        self.navigationItem.hidesSearchBarWhenScrolling = YES;
        self.navigationItem.searchController = self.searchController;
        
    } else {
        // Fallback on earlier versions
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.paiXuBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    [self getNavBtn];
    
}

- (void)setupUI
{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[DeviceCell class] forCellReuseIdentifier:@"DeviceCell"];
    self.tableView.refreshControl = self.refreshControl;
    NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"正在获取数据..." : @"Fetching data...";
    [MBhud.shared showHudText:textStr addView:zAppWindow];
    [self getDatas];
    
    
}

#pragma mark - websocket
-(void)websocketManagerDidReceiveMessageWithString:(NSString *)string{
    NSLog(@"string %@",string);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if ([dict[@"eventType"] isEqualToString:@"设备上线"]) {
        if (self.searchController.active ) {
            [_sort_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.onlinestatus = @"1";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        } else {
            [_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.onlinestatus = @"1";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }else if ([dict[@"eventType"] isEqualToString:@"设备离线"]) {
        if (self.searchController.active ) {
            [_sort_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.onlinestatus = @"0";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        } else {
            [_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.onlinestatus = @"0";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }else if ([dict[@"eventType"] isEqualToString:@"设备消警"]) {
        if (self.searchController.active ) {
            [_sort_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.havealarm = @"0";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        } else {
            [_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.havealarm = @"0";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }else if ([dict[@"eventType"] isEqualToString:@"设备上报"]) {
        if (self.searchController.active ) {
            [_sort_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.csq = [NSString stringWithFormat:@"%@",dict[@"msgContent"][@"value"]];
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        } else {
            [_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.csq = [NSString stringWithFormat:@"%@",dict[@"msgContent"][@"value"]];;
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }else if ([dict[@"eventType"] isEqualToString:@"设备告警"]) {
        if (self.searchController.active ) {
            [_sort_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.havealarm = @"1";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        } else {
            [_resultArray enumerateObjectsUsingBlock:^(DeviceModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([dict[@"msgContent"][@"device_id"] isEqualToString:obj.id]) {
                    obj.havealarm = @"1";
                    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }];
        }
    }
}

- (void)paiXuBtnClick:(UIButton *)btn
{
    
    NSArray *imageArr = @[@"icon_rank_name", @"icon_rank_number"];
    NSArray *titleArr = @[NSLocalizedString(@"按设备名称排序", nil),NSLocalizedString(@"按设备标识码排序", nil)];
    [XYMenu showMenuWithImages:imageArr titles:titleArr inView:self.paiXuBtn menuType:XYMenuRightNormal clickHide:NO withItemClickIndex:^(NSInteger index, BOOL isSort) {
        switch (index) {
            case 0:
                [self paiXuName:isSort];
                break;
            case 1:
                [self paiXuBiaoShiMa:isSort];
                break;

            default:
                break;
        }
    }];
    
}


- (void)handleRefresh {
    [self getDatas];
}

- (void)getDatas{
    
    // 清空数据
    //    if (self.resultArray.count > 0) {
    //        [self.resultArray removeAllObjects];
    //    }
    
    [CenterNet.shared deviceCheckDataCompletion:^(BOOL success, NSArray *dataList) {
        if (success) {
            
            if (self.resultArray.count > 0) {
                [self.resultArray removeAllObjects];
            }
            
            if (dataList.count>0) {
                NSArray* arr = [NSArray yy_modelArrayWithClass:[DeviceModel class] json:dataList];
                [self.resultArray addObjectsFromArray:arr];
                [self.tableView reloadData];
            }
            
        }
        [self.refreshControl endRefreshing];
        [MBhud.shared.hud hideAnimated:YES];
    }];
    
    
}

#pragma mark - 排序
- (void)paiXuBiaoShiMa:(BOOL)isDaoXu
{
    
    if (isDaoXu) {
        NSMutableArray* arrM = [DataSort daoxu_SortShuZi:self.resultArray];
        [self.resultArray removeAllObjects];
        [self.resultArray addObjectsFromArray:arrM.copy];
        [self.tableView reloadData];
    }else{
        NSMutableArray* arrM = [DataSort SortShuZi:self.resultArray];
        [self.resultArray removeAllObjects];
        [self.resultArray addObjectsFromArray:arrM.copy];
        [self.tableView reloadData];
    }
    
}

- (void)paiXuName:(BOOL)isDaoXu
{
    if (isDaoXu) {
        NSMutableArray* arrM = [DataSort za_SortPinYing:self.resultArray];
        [self.resultArray removeAllObjects];
        [self.resultArray addObjectsFromArray:arrM.copy];
        [self.tableView reloadData];
    }else{
        NSMutableArray* arrM = [DataSort az_SortPinYing:self.resultArray];
        [self.resultArray removeAllObjects];
        [self.resultArray addObjectsFromArray:arrM.copy];
        [self.tableView reloadData];
    }
    
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text;
    
    if (self.sort_resultArray.count > 0) {
        [self.sort_resultArray removeAllObjects];
    }
    
    //加个多线程，否则数量量大的时候，有明显的卡顿现象
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (inputStr!=nil && inputStr.length>0) {
            
            for (DeviceModel *model in self.resultArray) {
                
                // 按名称查找
                NSString *tempStr = model.devicename;
                NSString *pinyin = [NSObject transformToPinyin:tempStr];
                // 按标识码查找
                NSString* tempString;
                if ([model.imei isEqualToString:@""]) {
                    tempString = model.wifimac;
                }else{
                    tempString = model.imei;
                }
                NSString *pinyinStr = [NSObject transformToPinyin:tempString];
                
                BOOL isContentName = YES;
                BOOL isContentimei = YES;
                for (int i = 0; i<inputStr.length; i++) {
                    NSRange r = {i,1};
                    NSString* rangeStr = [inputStr substringWithRange:r];
                    if (![pinyin containsString:rangeStr]) {
                        isContentName = NO;
                    }
                    if (![pinyinStr containsString:rangeStr]) {
                        isContentimei = NO;
                    }
                    NSLog(@"%@",rangeStr);
                }
                
                if (isContentName) {
                    [self.sort_resultArray addObject:model];
                }
                if (isContentimei) {
                    if (![self.sort_resultArray containsObject:model]) {
                        [self.sort_resultArray addObject:model];
                    }
                }
            }
        }
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController {}

- (void)willDismissSearchController:(UISearchController *)searchController {}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.searchController.active) {
        
        return _sort_resultArray.count ;
    }
    
    return _resultArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.searchController.active ) {
        
        cell.model = _sort_resultArray[indexPath.row];
    } else {
        
        cell.model = _resultArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceConfigurationController* vc = [DeviceConfigurationController new];
    if (self.searchController.active ) {
        vc.deviceId = _sort_resultArray[indexPath.row].id;
        vc.devicename = _sort_resultArray[indexPath.row].devicename;
    } else {
        vc.deviceId = _resultArray[indexPath.row].id;
        vc.devicename = _resultArray[indexPath.row].devicename;
    }

    [self.navigationController pushViewController:vc animated:YES];
 
}

#pragma mark - tableview侧滑删除
//开启tableview的编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//iOS11之后侧滑删除-支持设置图片【设置后iOS11优先走这里，与上面不冲突】
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        [self didSelectItemIndexPath:indexPath];
        completionHandler (YES);
    }];
    UIContextualAction *logRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        SingleLogController* vc = [SingleLogController new];
        if (self.searchController.active ) {
            vc.group_id = self.sort_resultArray[indexPath.row].group_id;
            vc.device_id = self.sort_resultArray[indexPath.row].id;
        } else {
            vc.group_id = self.resultArray[indexPath.row].group_id;
            vc.device_id = self.resultArray[indexPath.row].id;
        }
        [self.navigationController pushViewController:vc animated:YES];
        completionHandler (YES);
    }];
    deleteRowAction.image = [SVGKImage imageNamed:@"slide_del"].UIImage;
    deleteRowAction.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    logRowAction.image = [SVGKImage imageNamed:@"slide_log"].UIImage;
    logRowAction.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction,logRowAction]];
    return config;
}

#pragma mark - devicePtc
- (void)didSelectItemIndexPath:(NSIndexPath *)indexPath
{
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"确定要删除设备吗?", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (self.searchController.active ) {
                [CenterNet.shared deleteDeviceParm:self.sort_resultArray[indexPath.row].id completion:^(BOOL success) {
                    if (success) {
                        [self.sort_resultArray removeObjectAtIndex:indexPath.row];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    }
                }];
            } else {
                [CenterNet.shared deleteDeviceParm:self.resultArray[indexPath.row].id completion:^(BOOL success) {
                    if (success) {
                        [self.resultArray removeObjectAtIndex:indexPath.row];
                        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    }
                }];
            }
        }];
        UIAlertAction *alertF = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了取消");
            
        }];
        [alertT setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
        [alertF setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
        [actionSheet addAction:alertT];
        [actionSheet addAction:alertF];
        [self presentViewController:actionSheet animated:YES completion:nil];
 
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor colorWithHex:@"#F6F8FA"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = SPH(211);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_empty_list" titleStr:NSLocalizedString(@"空列表", nil) detailStr:@""];
        _tableView.ly_emptyView.contentViewOffset = -150;
        _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
        _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];
        
    }
    return _tableView;
}

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        // 设置结果更新代理
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder = @"请输入搜索内容";
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
    }
    
    return _searchController;
}

- (UIButton *)paiXuBtn
{
    if (!_paiXuBtn) {
        _paiXuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [_paiXuBtn setImage:[SVGKImage imageNamed:@"icon_rank"].UIImage forState:UIControlStateNormal];
        [_paiXuBtn addTarget:self action:@selector(paiXuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _paiXuBtn;
}


@end

