//
//  SmallFormulaSelectView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallFormulaSelectView.h"
#import "SmallFormulaSelectCell.h"
#import "SmallFormulaModel.h"

@interface SmallFormulaSelectView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel* t_lb;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic,strong) UIButton* sureBtn;
@property (nonatomic,strong) UIButton* cancelBtn;

@end
@implementation SmallFormulaSelectView

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
    
    [self addSubview:self.t_lb];
    [self addSubview:self.tableView];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.sureBtn];
    
}

- (void)sureClick
{
    __block BOOL isContent = NO;
    [_formulaDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SmallFormulaModel* model = obj;
        if (model.isSelected == YES) {
            isContent = YES;
            if ([self.delegate respondsToSelector:@selector(selectFormulaName:unitStr:formulaStr:createtime:)]) {
                [self.delegate selectFormulaName:model.formulaname unitStr:model.unit formulaStr:model.formula createtime:model.createtime];
            }
            NKAlertView *alertView = (NKAlertView *)self.superview;
            [alertView hide];
        }
    }];

    if (isContent == NO) {
        [MBhud showText:@"请选择公式" addView:zAppWindow];
    }

}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _formulaDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SmallFormulaSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SmallFormulaSelectCell"];
    cell.model = _formulaDatas[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_formulaDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SmallFormulaModel* model = obj;
        if (indexPath.row == idx) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }];

    [self.tableView reloadData];
}


#pragma mark - lazy

- (UILabel *)t_lb
{
    if (!_t_lb) {
        _t_lb = [UILabel z_frame:CGRectMake(25, 30, 200, 33)
                            Text:NSLocalizedString(@"公式名", nil)
                        fontSize:24
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:NO
                 ];
    }
    
    return _t_lb;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, self.t_lb.bottom + 25, self.width - 40, self.height - (self.t_lb.bottom + 25+64)) style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
                _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.rowHeight = 101;
        [_tableView registerClass:[SmallFormulaSelectCell class] forCellReuseIdentifier:@"SmallFormulaSelectCell"];
        
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
