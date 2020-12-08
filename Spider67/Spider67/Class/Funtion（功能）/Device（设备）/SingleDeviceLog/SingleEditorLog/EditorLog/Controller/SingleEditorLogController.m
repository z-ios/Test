//
//  SingleEditorLogController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleEditorLogController.h"
#import "SingleEditorLogModel.h"
#import "SingleEditorLogCell.h"
#import "SingleEditorLogScreenController.h"
#import "SingleEditorShowUserView.h"

@interface SingleEditorLogController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView* tableView;
@property (nonatomic, strong) NSMutableArray<SingleEditorLogModel *>* editorLogList;
@property (nonatomic, strong) UIButton* delBtn;
@property (nonatomic, strong) NSMutableDictionary* screenDict;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) SingleEditorShowUserView* userView;

@end

@implementation SingleEditorLogController
{
    MJRefreshNormalHeader* header;
    MJRefreshAutoNormalFooter *footer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)slideMenuViewDidLoad:(NSInteger)index
{
    [self setupUI];
}


- (void)slideMenuViewWillDisappear:(NSInteger)index
{
    // 清空筛选数据(筛选)
    _screenDict = [NSMutableDictionary dictionary];
    // 多选恢复
    if (self.cancelSelectItem) {
        self.cancelSelectItem();
    }

}

- (void)slideMenuViewWillAppear:(NSInteger)index
{
    [super slideMenuViewWillAppear:index];
    // 刷新数据
    [self.tableView.mj_header beginRefreshing];

}


- (NSMutableDictionary *)screenDict
{
    if (!_screenDict) {
        _screenDict = [NSMutableDictionary dictionary];
    }
    return _screenDict;
}

- (NSMutableArray<SingleEditorLogModel *> *)editorLogList
{
    if (!_editorLogList) {
        _editorLogList = [NSMutableArray array];
    }
    return _editorLogList;
}


- (void)setupUI
{
    _pageNum = 1;
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.view addSubview:self.userView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[SingleEditorLogCell class] forCellReuseIdentifier:@"SingleEditorLogCell"];
    
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行数据刷新操作
        [self screenDataEditor:self.screenDict[@"userName"] sdateStr:self.screenDict[@"sdateStr"] edateStr:self.screenDict[@"edateStr"]];
    }];
    self.tableView.mj_header = header;
    
    footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self dataEditor:self.screenDict[@"userName"] sdateStr:self.screenDict[@"sdateStr"] edateStr:self.screenDict[@"edateStr"]];
    }];
    footer.automaticallyRefresh = NO;
    self.tableView.mj_footer = footer;
    
    [CenterNet.shared DeviceEditorParm:self.device_id completion:^(NSDictionary *dict, BOOL success) {
        if (success) {
            NSDictionary* dataDict = dict[@"device"];
            self.userView.creatDate = dataDict[@"createtime"];
            self.userView.userName = dataDict[@"createuser"];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

#pragma mark - 筛选
- (void)screenLog:(UIViewController *)vc
{
    SingleEditorLogScreenController* screenVc = [SingleEditorLogScreenController new];
    screenVc.group_id = self.group_id;
    screenVc.device_id = self.device_id;
    screenVc.zdelegate = self;
    screenVc.selDict = self.screenDict.copy;
    screenVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:screenVc animated:YES completion:nil];
}
#pragma mark - 刷选数据

- (void)screenDataEditor:(NSString *)userName sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr
{
    self.pageNum = 1;
    [self.editorLogList removeAllObjects];
    [self dataEditor:userName sdateStr:sdateStr edateStr:edateStr];
}

- (void)dataEditor:(NSString *)userName sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr
{
    self.screenDict[@"userName"] = userName;
    self.screenDict[@"sdateStr"] = sdateStr;
    self.screenDict[@"edateStr"] = edateStr;
    
    NSDictionary* dict = @{
        @"pageIndex": [NSNumber numberWithInteger:_pageNum],
        @"pageSize": @20,
        @"device_id": self.device_id,
        @"username":SafeString(userName),
        @"sDate": [SafeString(sdateStr) isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"%@ 00:00:00",SafeString(sdateStr)],
        @"eDate": [SafeString(edateStr) isEqualToString:@""] ? @"" : [NSString stringWithFormat:@"%@ 23:59:59",SafeString(edateStr)]
    };
    
    [CenterNet.shared logEditorParm:dict completion:^(NSArray * _Nullable dataList, BOOL success) {
        if (success) {
            NSArray* models = [NSArray yy_modelArrayWithClass:[SingleEditorLogModel class] json:dataList];
            [self.editorLogList addObjectsFromArray:models];
            if (dataList.count<20) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            self.pageNum++;
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - 批量删除
- (void)batchDeletionLog
{
    if (_editorLogList.count > 0) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
        [self.tableView setEditing:NO animated:YES];
        [self.tableView setEditing:YES animated:YES];
        _tableView.contentInset = UIEdgeInsetsMake(5, 0, 95, 0);
        [_editorLogList enumerateObjectsUsingBlock:^(SingleEditorLogModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.bgWith = 55;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        [self.view addSubview:self.delBtn];
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.delBtn.y = self.view.height - 88;
        } completion:nil];
        
    }else{
        if (self.cancelSelectItem) {
            self.cancelSelectItem();
        }
        [MBhud showText:NSLocalizedString(@"没有数据无法进行批量删除", nil) addView:zAppWindow];
    }
    
}

#pragma mark - 全选
- (void)logAllSelect
{
    
    [_editorLogList enumerateObjectsUsingBlock:^(SingleEditorLogModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }];
    
}

#pragma mark - 取消全选
- (void)logCancelSelect
{

    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    [self.tableView setEditing:NO animated:YES];
    _tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
    [_editorLogList enumerateObjectsUsingBlock:^(SingleEditorLogModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.bgWith = 16;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];

    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.delBtn.y = self.view.height;
    } completion:nil];
    
}

#pragma mark - 删除
- (void)delBtnClick
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"确定要删除吗?", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray* arr = [NSMutableArray array];
        NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
        [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [insets addIndex:obj.row];
            [arr addObject:self.editorLogList[obj.row].id];
        }];
        
        
        NSDictionary* dict = @{
            @"idList": arr.copy
        };
        
        [CenterNet.shared delEditorLogParm:dict completion:^(BOOL success) {
            [self.editorLogList removeObjectsAtIndexes:insets];
            [self.tableView deleteRowsAtIndexPaths:[self.tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
            if (self.editorLogList.count == 0) {
                if (self.cancelSelectItem) {
                    self.cancelSelectItem();
                }
            }
        }];
        
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

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _editorLogList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleEditorLogCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SingleEditorLogCell"];
    cell.model = _editorLogList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    deleteRowAction.image = [SVGKImage imageNamed:@"slide_del"].UIImage;
    deleteRowAction.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

- (void)didSelectItemIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"确定要删除吗?", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSDictionary* dict = @{
            @"idList": @[self.editorLogList[indexPath.row].id]
        };

        [CenterNet.shared delEditorLogParm:dict completion:^(BOOL success) {
            [self.editorLogList removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (tableView.isEditing) {
            // 多选
            return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
        }else{
            // 删除
            return UITableViewCellEditingStyleDelete;
        }
}


#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, self.userView.bottom + 5, self.view.width, self.view.height - (self.userView.bottom + 5)) style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor colorWithHex:@"#F6F8FA"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = 165;
        _tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_empty_list" titleStr:NSLocalizedString(@"空列表", nil) detailStr:@""];
        _tableView.ly_emptyView.contentViewOffset = -150;
        _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
        _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];
        
    }
    return _tableView;
}

- (UIButton *)delBtn
{
    if (!_delBtn) {
        _delBtn = [UIButton z_svg_setImageName:@"icon_delete_log" fontSize:17 titleColor:[UIColor whiteColor] title:[NSString stringWithFormat:@"  %@",NSLocalizedString(@"批量删除", nil)] isbold:NO];
        _delBtn.backgroundColor = [UIColor colorWithHex:@"#F1544F"];
        _delBtn.frame = CGRectMake(0, self.view.height, self.view.width, 88);
        [_delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _delBtn;
}

- (SingleEditorShowUserView *)userView
{
    if (!_userView) {
        _userView  = [[SingleEditorShowUserView alloc] initWithFrame:CGRectMake(16, 15, self.view.width - 32, 48)];
    }
    return _userView;
}


@end
