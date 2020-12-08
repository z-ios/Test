//
//  ServerListController.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ServerListController.h"
#import "SeaverListCell.h"
#import "AddSeaverView.h"

@interface ServerListController ()<UITableViewDelegate,UITableViewDataSource,MGSwipeTableCellDelegate,ServerPtc>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataList;

@end

@implementation ServerListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem* leftItem = [UIBarButtonItem itemWithNormalIcon:@"icon_back_nav" highlightedIcon:nil target:self action:@selector(backToVc)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem* rightItem = [UIBarButtonItem itemWithNormalIcon:@"icon_add_list" highlightedIcon:nil target:self action:@selector(addList)];
     self.navigationItem.rightBarButtonItem = rightItem;
    [self initData];
    [self setupUI];
}

- (void)backToVc
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addList
{
    AddSeaverView* addV = [[AddSeaverView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - SPW(32), SPH(490))];
    addV.delegate = self;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:self.navigationController.view];
    nkView.contentView = addV;
    [nkView show];
}

- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.title = @"Server List";
       
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    _tableView.backgroundColor =  [UIColor colorWithHex:@"#F6F8FA"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.rowHeight = SPH(142);
    [self.view addSubview:_tableView];
       
    [_tableView registerClass:[SeaverListCell class] forCellReuseIdentifier:@"SeaverListCell"];
    
    
}

- (void)initData{
    
     _dataList = [NSMutableArray array];
     if ([[NSUserDefaults standardUserDefaults] objectForKey:@"serverhistory"]) {
         NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverhistory"];
         [self.dataList addObjectsFromArray:arr];
     }else{
         if (![[NSUserDefaults standardUserDefaults] objectForKey:@"once"]) {// 添加默认数据
             [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"once"];
             NSMutableDictionary* dictM_v = [NSMutableDictionary dictionary];
             dictM_v[@"devIp"] = @"47.105.62.95";
             dictM_v[@"devPort"] = @"8883";
             dictM_v[@"devTitle"] = @"China v1.1";
             dictM_v[@"devpro"] = @"http";
             dictM_v[@"devType"] = @(0);
             [self.dataList addObject:dictM_v];
             NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
             dictM[@"devIp"] = @"47.92.138.208";
             dictM[@"devPort"] = @"1885";
             dictM[@"devTitle"] = @"China Sever";
             dictM[@"devpro"] = @"http";
             dictM[@"devType"] = @(0);
             [self.dataList addObject:dictM];
             NSMutableDictionary* dictM_tls = [NSMutableDictionary dictionary];
             dictM_tls[@"devIp"] = @"47.92.138.208";
             dictM_tls[@"devPort"] = @"8885";
             dictM_tls[@"devTitle"] = @"China Sever(TLS)";
             dictM_tls[@"devpro"] = @"http";
             dictM_tls[@"devType"] = @(0);
             [self.dataList addObject:dictM_tls];
             NSMutableDictionary* dict = [NSMutableDictionary dictionary];
             dict[@"devIp"] = @"148.251.82.23";
             dict[@"devPort"] = @"1891";
             dict[@"devTitle"] = @"German Sever";
             dict[@"devType"] = @(0);
             [self.dataList addObject:dict];
             NSMutableDictionary* dict_tls = [NSMutableDictionary dictionary];
             dict_tls[@"devIp"] = @"148.251.82.23";
             dict_tls[@"devPort"] = @"8891";
             dict_tls[@"devTitle"] = @"German Sever(TLS)";
             dict_tls[@"devpro"] = @"http";
             dict_tls[@"devType"] = @(0);
             [self.dataList addObject:dict_tls];
             [[NSUserDefaults standardUserDefaults] setObject:self.dataList.copy forKey:@"serverhistory"];
         }
    }
}
#pragma mark - delegate
- (void)saveData:(NSString *)ipStr port:(NSString *)portStr titleStr:(NSString *)titleStr xieyiStr:(NSString *)xieyiStr typeNum:(NSInteger)typeNum
{
    [self addCellData:ipStr port:portStr titleStr:titleStr xieyiStr:xieyiStr typeNum:typeNum];
}
#pragma mark - 增加cell
- (void)addCellData:(NSString *)ipStr port:(NSString *)portStr titleStr:(NSString *)titleStr xieyiStr:(NSString *)xieyiStr typeNum:(NSInteger)typeNum
{
    NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
    dictM[@"devIp"] = ipStr;
    dictM[@"devPort"] = portStr;
    dictM[@"devTitle"] = titleStr;
    dictM[@"devpro"] = xieyiStr;
    dictM[@"devType"] = @(typeNum);
    [self.dataList insertObject:dictM atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:self.dataList.copy forKey:@"history"];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [indexPaths addObject: indexPath];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];

}


#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeaverListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SeaverListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.dict = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(severListselectedData:)]) {
        [self.delegate severListselectedData:self.dataList[indexPath.row]];
       }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Swipe Delegate

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    swipeSettings.transition = MGSwipeTransitionBorder;
    
    if (direction == MGSwipeDirectionRightToLeft){
        
        MGSwipeButton * del = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"icon_delete_circle"] backgroundColor:nil insets:UIEdgeInsetsMake(0, 8, 0, 0) callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
//            [Center.shared alertWithFrame:CGRectMake(0, 0, 343, 156) addView:[UIApplication sharedApplication].keyWindow type:AlDelSetItem completion:^(NSString *flag) {
//                if ([flag isEqualToString:@"sure"]) {
                    [self.dataList removeObjectAtIndex:indexPath.row];
                    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    [[NSUserDefaults standardUserDefaults] setObject:self.dataList.copy forKey:@"serverhistory"];
//                }
//            }];

            return YES;
        }];
        
        return @[del];
    }
    
    return nil;
    
}

- (void)dealloc
{
    
}


@end
