//
//  TuoJiView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "TuoJiView.h"
#import "TuoJiCell.h"

@interface TuoJiView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* dataList;

@end
@implementation TuoJiView

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
    self.layer.cornerRadius = 34;
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(SPW(32), SPH(30), SPW(150), SPH(33))
                                   Text:NSLocalizedString(@"脱机应用", nil)
                               fontSize:SPFont(24)
                                  color:[UIColor colorWithHex:@"#121212"]
                                 isbold:YES
                        ];
    [self addSubview:titleLb];
    
    UIButton* cancelBtn = [[UIButton alloc] init];
    [cancelBtn setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [self addSubview:cancelBtn];
    cancelBtn.width = SPW(24);
    cancelBtn.height = SPW(24);
    cancelBtn.x = self.width - SPW(24) - SPW(26);
    cancelBtn.centerY = titleLb.centerY;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _dataList = @[
        @{@"img":@"app_demo",@"title":NSLocalizedString(@"spider67演示箱", nil),@"subtitle":NSLocalizedString(@"互动样品箱", nil)},
        @{@"img":@"app_bluetooth",@"title":NSLocalizedString(@"spider67蓝牙版", nil),@"subtitle":NSLocalizedString(@"蓝牙版本", nil)}
    ];
    
    self.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleLb.bottom + SPH(15), self.width, self.height -(titleLb.bottom + SPH(15)) ) style:(UITableViewStylePlain)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.rowHeight = SPH(112);
    [self addSubview:_tableView];
    
    [_tableView registerClass:[TuoJiCell class] forCellReuseIdentifier:@"TuoJiCell"];
}

- (void)cancelBtnClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuoJiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TuoJiCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = self.dataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self jumpToAnotherApp:indexPath.row];
}

- (void)jumpToAnotherApp:(NSInteger)idx {
    NSURL *url;
    if (idx == 0) {
        url = [NSURL URLWithString:@"Spider67Box://"];
    }else{
        url = [NSURL URLWithString:@"Spider67Ble://"];
    }
    
    BOOL isCanOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if (isCanOpen) {
        #ifdef NSFoundationVersionNumber_iOS_10_0
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        #else
            [[UIApplication sharedApplication] openURL:url];
        #endif
        NSLog(@"App1打开App2");
    }else{
        NSLog(@"设备没有安装App2");
        if (idx == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://jappstore.com/qjd7"] options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/spider67-m/id1463350646"] options:@{} completionHandler:nil];
        }
    }
}


@end
