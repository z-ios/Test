//
//  LinkageTableView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/23.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LinkageTableView.h"
#import "LinkageTableViewCell.h"

@interface LinkageTableView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LinkageTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor =  [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.rowHeight = 125;
    self.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_empty_list" titleStr:NSLocalizedString(@"无配置联动数据", nil) detailStr:@""];
    self.ly_emptyView.contentViewOffset = -50;
    self.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
    self.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];
    self.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    
    [self registerClass:[LinkageTableViewCell class] forCellReuseIdentifier:@"LinkageTableViewCell"];
    
}

#pragma mark - tabView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _linkageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LinkageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LinkageTableViewCell"];
    cell.dict = _linkageList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
