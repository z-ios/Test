//
//  WgContentView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgContentView.h"
#import "WgContentOneCell.h"
#import "WgContentTwoCell.h"
#import "WgContentThreeCell.h"
#import "WgContentFourCell.h"
#import "HeaderView.h"
#import "ModulesListModel.h"
#import "TableViewAnimationKitHeaders.h"

@interface WgContentView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) HeaderView* headerV;


@end
@implementation WgContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerV;
    [self.tableView registerClass:[WgContentOneCell class] forCellReuseIdentifier:@"WgContentOneCell"];
    [self.tableView registerClass:[WgContentTwoCell class] forCellReuseIdentifier:@"WgContentTwoCell"];
    [self.tableView registerClass:[WgContentThreeCell class] forCellReuseIdentifier:@"WgContentThreeCell"];
    [self.tableView registerClass:[WgContentFourCell class] forCellReuseIdentifier:@"WgContentFourCell"];
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    self.headerV.deviceDict = _deviceDict;
    [self.tableView reloadData];
    [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeLayDown tableView:self.tableView];
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WgContentOneCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WgContentOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model0 = _model0;
        cell.model1 = _model1;
        return cell;
    }else if (indexPath.row == 1) {
        WgContentTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WgContentTwoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.deviceDict = _deviceDict;
        return cell;
    }else if (indexPath.row == 2) {
        WgContentThreeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WgContentThreeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.deviceDict = _deviceDict;
        return cell;
    }else {
        WgContentFourCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WgContentFourCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.deviceDict = _deviceDict;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 129;
    }else if (indexPath.row == 1) {
        return 114;
    }else if (indexPath.row == 2) {
        return 290;
    }else {
        return 351;
    }
}


#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor colorWithHex:@"#F6F8FA"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_empty_list" titleStr:NSLocalizedString(@"空列表", nil) detailStr:@""];
        _tableView.ly_emptyView.contentViewOffset = -150;
        _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
        _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];
        
    }
    return _tableView;
}

- (HeaderView *)headerV
{
    if (!_headerV) {
        _headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.width, 49)];
    }
    return _headerV;
}


@end
