//
//  SendLinkageController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/9.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendLinkageController.h"
#import "SendLinkageCell.h"
#import "SendLinkageModel.h"
#import "SendSuccessView.h"

@interface SendLinkageController ()<UITableViewDelegate,UITableViewDataSource,DevicePtc>

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataList;
@property (nonatomic, strong) NSArray<SendLinkageModel *>* arr;
@property (nonatomic, strong) UIButton* sendBtn;

@end

@implementation SendLinkageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = NSLocalizedString(@"下发联动", nil);
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    
    [self.view addSubview:self.title_lb];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sendBtn];
    [self.tableView registerClass:[SendLinkageCell class] forCellReuseIdentifier:@"SendLinkageCell"];
    
    [CenterNet.shared checkLinkageChannelCompletionParm:_deviceId completion:^(NSArray * _Nullable dataList) {
        self.arr = [NSArray yy_modelArrayWithClass:[SendLinkageModel class] json:dataList];
        [self.tableView reloadData];
        NSString* textStr = [[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? [NSString stringWithFormat:@"共配置了%zd条",self.arr.count] : [NSString stringWithFormat:@"A total of %zd are configured",self.arr.count];
        self.title_lb.text = textStr;
        if (self.arr.count == 0) {
            self.sendBtn.hidden = YES;
        }else{
            self.sendBtn.hidden = NO;
        }
    }];
    
}

- (void)sendBtnClick
{
    [self addActivityIndicator];
    [CenterNet.shared sendLogicDeviceId:_deviceId completion:^(BOOL success, NSString * _Nullable failStr) {
        [SendSuccessView showSuccess:success vc:self note:failStr completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];

}

- (void)addActivityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]init];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_sendBtn addSubview:activityIndicator];
    //设置小菊花的frame
    activityIndicator.frame= _sendBtn.bounds;
    //设置小菊花颜色
    activityIndicator.color = [UIColor whiteColor];
    //设置背景颜色
    activityIndicator.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    activityIndicator.hidesWhenStopped = true;
    //开始旋转
    [activityIndicator startAnimating];
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SendLinkageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SendLinkageCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.model = _arr[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _arr[indexPath.row].cellHeight;
}

- (void)sendLinkageIndexPath:(NSIndexPath *)indexPath btn:(nonnull UIButton *)btn
{
    
    _arr[indexPath.row].isSelect = !_arr[indexPath.row].isSelect;
//    btn.selected = !btn.selected;
//    NSLog(@"--%d",btn.selected);
    if (_arr[indexPath.row].isSelect) {// 展开
        _arr[indexPath.row].cellHeight = 362;
    }else{// 收缩
        _arr[indexPath.row].cellHeight = 222;
    }
    
//    [_tableView reloadData];

    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - 懒加载

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(16, Height_NavBar + 20, self.view.width - 32, 20)
                                     Text:@"共配置了4条"
                                 fontSize:14
                                    color:[UIColor colorWithHex:@"#4D8CEB"]
                                   isbold:NO
                          ];
       }
       return _title_lb;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.title_lb.bottom + 10, self.view.width, self.view.height - (self.title_lb.bottom + 10)) style:(UITableViewStylePlain)];
        _tableView.backgroundColor =  [UIColor colorWithHex:@"#F6F8FA"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        //        _tableView.rowHeight = 222;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
        _tableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"pic_empty_list" titleStr:@"列表为空" detailStr:@"" btnTitleStr:@"重新加载" btnClickBlock:^{
            [CenterNet.shared checkLinkageChannelCompletionParm:self.deviceId completion:^(NSArray * _Nullable dataList) {
                self.arr = [NSArray yy_modelArrayWithClass:[SendLinkageModel class] json:dataList];
                [self.tableView reloadData];
            }];
        }];
        _tableView.ly_emptyView.actionBtnBackGroundColor = [UIColor colorWithHex:@"#26C464"];
        _tableView.ly_emptyView.actionBtnCornerRadius = 6;
        _tableView.ly_emptyView.actionBtnTitleColor = [UIColor whiteColor];
        _tableView.ly_emptyView.actionBtnFont = [UIFont boldSystemFontOfSize:18];
        _tableView.ly_emptyView.contentViewOffset = -50;
        _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#121212"];
        _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:20];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        
    }
    return _tableView;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton z_frame:CGRectMake(16, self.view.height - 44 - 50, self.view.width - 32, 50)
                            fontSize:18
                        cornerRadius:6
                     backgroundColor:[UIColor colorWithHex:@"#26C464"]
                          titleColor:[UIColor whiteColor]
                               title:NSLocalizedString(@"下发联动", nil)
                              isbold:YES
                              Target:self
                              action:@selector(sendBtnClick)
                    ];
    }
    return _sendBtn;
}


@end
