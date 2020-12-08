//
//  SingSelChannelView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingSelChannelView.h"
#import "SingSelChannelTableViewCell.h"
#import "ChannelListModel.h"

@interface SingSelChannelView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UILabel* num_lb;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong) UIButton* sureBtn;
@property (nonatomic,strong) UIButton* cancelBtn;

//@property (nonatomic,copy) NSString* valueStr;
//@property (nonatomic,copy) NSString* colorStr;
@property (nonatomic, assign) NSInteger selNum;

@end
@implementation SingSelChannelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 18;
    [self addSubview:self.title_lb];
    [self addSubview:self.num_lb];
    [self addSubview:self.tableView];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
    
    [self.tableView registerClass:[SingSelChannelTableViewCell class] forCellReuseIdentifier:@"SingSelChannelTableViewCell"];

}

- (void)setItemList:(NSArray<ChannelListModel *> *)itemList
{
    _itemList = itemList;
    
    [_itemList enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSel) {
            self.selNum +=1;
        }
        self.num_lb.text = [NSString stringWithFormat:@"%zd",_selNum];
    }];
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingSelChannelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SingSelChannelTableViewCell"];
    
    cell.model = _itemList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _itemList[indexPath.row].isSel = !_itemList[indexPath.row].isSel;
    if (_itemList[indexPath.row].isSel) {
        _selNum +=1;
    }else{
        _selNum -=1;
    }
    _num_lb.text = [NSString stringWithFormat:@"%zd",_selNum];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - btnclick
- (void)sureClick
{

    NSMutableArray* arrM = [NSMutableArray array];
    [_itemList enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSel) {
            [arrM addObject:obj];
        }
    }];
    if (self.selChannelDatas) {
        self.selChannelDatas(arrM);
    }
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}

#pragma mark - lazy

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(25, 30, 0, 33) Text:NSLocalizedString(@"选择channel（多选）", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_title_lb sizeToFit];
    }
    
    return _title_lb;
}

- (UILabel *)num_lb
{
    if (!_num_lb) {
        _num_lb = [UILabel z_frame:CGRectMake(self.title_lb.right + 2, 0, 40, 28) Text:@"0" fontSize:14 color:[UIColor colorWithHex:@"#1D68F2"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]];
        _num_lb.centerY = self.title_lb.centerY;
        _num_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _num_lb;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(25, self.title_lb.bottom + 25, self.width - 50, self.height - (self.title_lb.bottom + 25 + 64)) style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = 115;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_empty_list" titleStr:NSLocalizedString(@"空列表", nil) detailStr:@""];
        _tableView.ly_emptyView.contentViewOffset = -150;
        _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
        _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];

    }
    return _tableView;
}


- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                        norImageName:nil
                        selImageName:nil
                              Target:self
                              action:@selector(sureClick)
                               title:NSLocalizedString(@"确定", nil)
                            selTitle:nil
                                font:[UIFont boldSystemFontOfSize:SPFont(17)]
                       norTitleColor:[UIColor colorWithHex:@"#26C464"]
                       selTitleColor:nil
                             bgColor:nil
                        cornerRadius:0
                         borderWidth:0.5
                         borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                    ];
    }
    
    return _sureBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                          norImageName:nil
                          selImageName:nil
                                Target:self
                                action:@selector(cancelClick)
                                 title:NSLocalizedString(@"取消", nil)
                              selTitle:nil
                                  font:[UIFont boldSystemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#808080"]
                         selTitleColor:nil
                               bgColor:nil
                          cornerRadius:0
                           borderWidth:0.5
                           borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                      ];
    }
    
    return _cancelBtn;
}


@end
