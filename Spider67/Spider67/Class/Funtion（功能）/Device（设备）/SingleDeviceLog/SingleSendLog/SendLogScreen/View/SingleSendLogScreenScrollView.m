//
//  SingleSendLogScreenScrollView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleSendLogScreenScrollView.h"
#import "SingSelDateView.h"
#import "SingleSendLogScreenCollectionView.h"
#import "SingleSendItemModel.h"
#import "SingleSendItemView.h"

@interface SingleSendLogScreenScrollView ()<DevicePtc>

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) SingSelDateView* dateView;
@property (nonatomic, strong) UILabel* send_tl_lb;
@property (nonatomic, strong) UILabel* send_num_lb;
@property (nonatomic, strong) NSMutableArray<SingleSendItemModel *>* sendScreenList;
@property (nonatomic, strong) SingleSendLogScreenCollectionView* showsendSelcollView;
@property (nonatomic, strong) UIButton* sureBtn;

@end
@implementation SingleSendLogScreenScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (NSMutableArray<SingleSendItemModel *> *)sendScreenList
{
    if (!_sendScreenList) {
        _sendScreenList = [NSMutableArray array];
    }
    return _sendScreenList;
}

- (void)setupUI
{
    [self addSubview:self.title_lb];
    [self addSubview:self.dateView];
    [self addSubview:self.send_tl_lb];
    [self addSubview:self.send_num_lb];
    [self addSubview:self.showsendSelcollView];
    [self addSubview:self.sureBtn];
}

- (void)setSelDict:(NSDictionary *)selDict
{
    _selDict = selDict;
    
    self.dateView.edate_tf.text = _selDict[@"edateStr"];
    self.dateView.sdate_tf.text = _selDict[@"sdateStr"];
    [self showSendItemView:_selDict[@"sendArr"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.sureBtn.y = self.showsendSelcollView.bottom + 30;
        self.contentSize = CGSizeMake(self.width, self.sureBtn.bottom);
    } completion:nil];
    
}

- (void)sureBtnClick
{
    if ([self.zdelegate respondsToSelector:@selector(screenDataSendArr:sdateStr:edateStr:)]) {
        [self.zdelegate screenDataSendArr:self.showsendSelcollView.itemList sdateStr:self.dateView.sdate_tf.text edateStr:self.dateView.edate_tf.text];
    }
}
#pragma mark - 重置
- (void)allResetData
{
    self.dateView.edate_tf.text = @"";
    self.dateView.sdate_tf.text = @"";
    self.send_num_lb.text = @"0";
    
    self.showsendSelcollView.itemList = [NSMutableArray array];
    [self.showsendSelcollView reloadData];
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.showsendSelcollView.height = 58;
    } completion:nil];

}

#pragma mark - 选择动作类型
- (void)selAlarmItemData:(NSArray *)data
{
    [self.sendScreenList removeAllObjects];
    NSArray* arr = @[@"写值",@"更改上报周期",@"OTA升级请求",@"联动逻辑配置",@"擦除联动逻辑",@"发送channel配置"];
    [arr enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize contentSize = [NSObject sizeWidthWidth:obj font:[UIFont systemFontOfSize:14] maxHeight:20];
        SingleSendItemModel* model = [SingleSendItemModel new];
        model.itemW = contentSize.width + 65;
        model.sendName = obj;
        if (data.count >0) {
            [data enumerateObjectsUsingBlock:^(SingleSendItemModel*  _Nonnull mo, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([mo.sendName isEqualToString:obj]) {
                    model.isSel = YES;
                }
            }];
        }
        
        [self.sendScreenList addObject:model];
    }];
    
    SingleSendItemView* eview = [[SingleSendItemView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 554)];
    eview.itemList = self.sendScreenList.copy;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
    nkView.contentView = eview;
    [nkView show];
    eview.selSendDatas = ^(NSMutableArray<SingleSendItemModel *> * _Nonnull selSendList) {
        [self showSendItemView:selSendList];
    };

}

- (void)showSendItemView:(NSMutableArray<SingleSendItemModel *> *)selSendList
{
    [selSendList enumerateObjectsUsingBlock:^(SingleSendItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize contentSize = [NSObject sizeWidthWidth:obj.sendName font:[UIFont systemFontOfSize:17] maxHeight:24];
        obj.itemW = contentSize.width + 65;
    }];
    self.showsendSelcollView.itemList = selSendList;
    [self.showsendSelcollView reloadData];
    self.send_num_lb.text = [NSString stringWithFormat:@"%zd",selSendList.count];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WGCollectionViewLayout *layout =(WGCollectionViewLayout *)self.showsendSelcollView.collectionViewLayout;
        self.showsendSelcollView.height = (layout.columnNum+1)*68 - 10;
    });
}

- (void)selSendItemNum:(NSString *)numStr
{
    self.send_num_lb.text = numStr;
}

#pragma mark - lazy

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(25, 25, 100, 48) Text:NSLocalizedString(@"筛选", nil) fontSize:34 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _title_lb;
}

- (SingSelDateView *)dateView
{
    if (!_dateView) {
        _dateView = [[SingSelDateView alloc] initWithFrame:CGRectMake(25, self.title_lb.bottom + 30, self.width - 50, 77)];
        _dateView.backgroundColor = [UIColor whiteColor];
    }
    return _dateView;
}

- (UILabel *)send_tl_lb
{
    if (!_send_tl_lb) {
        _send_tl_lb = [UILabel z_frame:CGRectMake(25, self.dateView.bottom + 20, 60, 20) Text:@"channel" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _send_tl_lb;
}
- (UILabel *)send_num_lb
{
    if (!_send_num_lb) {
        _send_num_lb = [UILabel z_frame:CGRectMake(self.send_tl_lb.right + 10, 0, 40, 28) Text:@"0" fontSize:14 color:[UIColor colorWithHex:@"#1D68F2"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]];
        _send_num_lb.centerY = self.send_tl_lb.centerY;
        _send_num_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _send_num_lb;
}

- (SingleSendLogScreenCollectionView *)showsendSelcollView
{
    if (!_showsendSelcollView) {
        WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
        layout.itemHeight = 58;
        _showsendSelcollView = [[SingleSendLogScreenCollectionView alloc]initWithFrame:CGRectMake(15, self.send_tl_lb.bottom + 10, self.width - 30,58) collectionViewLayout:layout];
        _showsendSelcollView.zdelegate = self;
        _showsendSelcollView.backgroundColor = [UIColor whiteColor];
    }
    return _showsendSelcollView;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(16, self.showsendSelcollView.bottom + 30, self.width - 32, 50) fontSize:18 cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#26C464"] titleColor:[UIColor whiteColor] title:NSLocalizedString(@"确定", nil) isbold:YES Target:self action:@selector(sureBtnClick)];
    }
    return _sureBtn;
}


@end
