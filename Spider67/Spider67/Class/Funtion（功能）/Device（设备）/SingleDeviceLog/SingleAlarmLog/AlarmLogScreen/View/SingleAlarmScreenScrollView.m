//
//  SingleAlarmScreenScrollView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/20.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleAlarmScreenScrollView.h"
#import "SingleSelectAlarmView.h"
#import "SingAlarmItemModel.h"
#import "SingleAlarmShowSelCollectionView.h"
#import "SingSelDateView.h"
#import "SingSelChannelView.h"
#import "ChannelListModel.h"
#import "SingleChannelShwoSelCollectionView.h"

@interface SingleAlarmScreenScrollView ()<DevicePtc>

@property (nonatomic, strong) NSMutableArray<SingAlarmItemModel *>* alarmItemList;
@property (nonatomic, strong) UILabel* alarm_tl_lb;
@property (nonatomic, strong) UILabel* alarm_num_lb;
@property (nonatomic, strong) SingleAlarmShowSelCollectionView* showAlarmSelcollView;
@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) SingSelDateView* dateView;
@property (nonatomic, strong) UILabel* channel_tl_lb;
@property (nonatomic, strong) UILabel* channel_num_lb;
@property (nonatomic, strong) SingleChannelShwoSelCollectionView* showChannelSelcollView;
@property (nonatomic, strong) UIButton* sureBtn;

@end
@implementation SingleAlarmScreenScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (NSMutableArray<SingAlarmItemModel *> *)alarmItemList
{
    if (!_alarmItemList) {
        _alarmItemList = [NSMutableArray array];
    }
    return _alarmItemList;
}


- (void)setupUI
{
    [self addSubview:self.title_lb];
    [self addSubview:self.dateView];
    [self addSubview:self.channel_tl_lb];
    [self addSubview:self.channel_num_lb];
    [self addSubview:self.showChannelSelcollView];
    [self addSubview:self.alarm_tl_lb];
    [self addSubview:self.alarm_num_lb];
    [self addSubview:self.showAlarmSelcollView];
    [self addSubview:self.sureBtn];
}

- (void)setSelDict:(NSDictionary *)selDict
{
    _selDict = selDict;
    
    self.dateView.edate_tf.text = _selDict[@"edateStr"];
    self.dateView.sdate_tf.text = _selDict[@"sdateStr"];
    [self showSelChannel:_selDict[@"channelArr"]];
    [self showSelAlarm:_selDict[@"alarmArr"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.alarm_tl_lb.y = self.showChannelSelcollView.bottom + 20;
        self.alarm_num_lb.centerY = self.alarm_tl_lb.centerY;
        self.showAlarmSelcollView.y = self.alarm_tl_lb.bottom + 10;
        self.sureBtn.y = self.showAlarmSelcollView.bottom + 30;
        self.contentSize = CGSizeMake(self.width, self.sureBtn.bottom);
    } completion:nil];
    
}

- (void)sureBtnClick
{
    if ([self.zdelegate respondsToSelector:@selector(screenDataAlarmArr:channelArr:sdateStr:edateStr:)]) {
        [self.zdelegate screenDataAlarmArr:self.showAlarmSelcollView.itemList channelArr:self.showChannelSelcollView.itemList sdateStr:self.dateView.sdate_tf.text edateStr:self.dateView.edate_tf.text];
    }
}
#pragma mark - 重置
- (void)allResetData
{
    self.dateView.edate_tf.text = @"";
    self.dateView.sdate_tf.text = @"";
    self.alarm_num_lb.text = @"0";
    self.channel_num_lb.text = @"0";
    
    self.showChannelSelcollView.itemList = [NSMutableArray array];
    [self.showChannelSelcollView reloadData];
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.showChannelSelcollView.height = 58;
    } completion:nil];
    
    self.showAlarmSelcollView.itemList = [NSMutableArray array];
    [self.showAlarmSelcollView reloadData];
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.showAlarmSelcollView.height = 58;
    } completion:nil];
}

#pragma mark - 选择channel
- (void)selChannelItemData:(NSArray *)data
{
    [CenterNet.shared DeviceEditorParm:_device_id completion:^(NSDictionary *dict, BOOL success) {
        if (success) {
            NSMutableArray* arrM = [NSMutableArray array];
            NSArray * arr = dict[@"modules"];
            [arr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull channelDict, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray* channels = channelDict[@"channels"];
                [channels enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [arrM addObject:obj];
                }];
            }];
            
            NSArray* channelsList = [NSArray yy_modelArrayWithClass:[ChannelListModel class] json:arrM.copy];
            [channelsList enumerateObjectsUsingBlock:^(ChannelListModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (data.count >0) {
                    [data enumerateObjectsUsingBlock:^(ChannelListModel*  _Nonnull mo, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([mo.port isEqualToString:model.port]) {
                            model.isSel = YES;
                        }
                    }];
                }
            }];
            
            SingSelChannelView* eview = [[SingSelChannelView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 576)];
            eview.itemList = channelsList;
            NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
            nkView.contentView = eview;
            [nkView show];
            eview.selChannelDatas = ^(NSMutableArray<ChannelListModel *> * _Nonnull selChannelList) {
                [self showSelChannel:selChannelList];
            };
        }
    }];
}

#pragma mark - 选择报警类型
- (void)selAlarmItemData:(NSArray *)data
{
    [self.alarmItemList removeAllObjects];
    [CenterNet.shared checkWarnItemCompletionParm:_group_id completion:^(NSArray * _Nullable dataList) {
        [dataList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGSize contentSize = [NSObject sizeWidthWidth:obj[@"tagname"] font:[UIFont systemFontOfSize:14] maxHeight:20];
            SingAlarmItemModel* model = [SingAlarmItemModel new];
            model.itemW = contentSize.width + 99;
            model.tagname = obj[@"tagname"];
            model.tagcolor = obj[@"tagcolor"];
            model.id = obj[@"id"];
            if (data.count >0) {
                [data enumerateObjectsUsingBlock:^(SingAlarmItemModel*  _Nonnull mo, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([[NSString stringWithFormat:@"%@",mo.id] isEqualToString:[NSString stringWithFormat:@"%@",obj[@"id"]]]) {
                        model.isSel = YES;
                    }
                }];
            }
            
            [self.alarmItemList addObject:model];
        }];
        SingleSelectAlarmView* eview = [[SingleSelectAlarmView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 554)];
        eview.itemList = self.alarmItemList.copy;
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
        nkView.contentView = eview;
        [nkView show];
        eview.selAlarmDatas = ^(NSMutableArray<SingAlarmItemModel *> * _Nonnull selAlarmList) {
            [self showSelAlarm:selAlarmList];
        };
        
    }];
}

- (void)showSelChannel:(NSMutableArray<ChannelListModel *> *)selChannelList
{
    self.showChannelSelcollView.itemList = selChannelList;
    [self.showChannelSelcollView reloadData];
    self.channel_num_lb.text = [NSString stringWithFormat:@"%zd",selChannelList.count];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WGCollectionViewLayout *layout =(WGCollectionViewLayout *)self.showChannelSelcollView.collectionViewLayout;
        self.showChannelSelcollView.height = (layout.columnNum+1)*68 - 10;
    });
}
- (void)showSelAlarm:(NSMutableArray<SingAlarmItemModel *> *)selAlarmList
{
    [selAlarmList enumerateObjectsUsingBlock:^(SingAlarmItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize contentSize = [NSObject sizeWidthWidth:obj.tagname font:[UIFont systemFontOfSize:17] maxHeight:24];
        obj.itemW = contentSize.width + 93;
    }];
    self.showAlarmSelcollView.itemList = selAlarmList;
    [self.showAlarmSelcollView reloadData];
    self.alarm_num_lb.text = [NSString stringWithFormat:@"%zd",selAlarmList.count];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        WGCollectionViewLayout *layout =(WGCollectionViewLayout *)self.showAlarmSelcollView.collectionViewLayout;
        self.showAlarmSelcollView.height = (layout.columnNum+1)*68 - 10;
    });
}

- (void)selAlarmItemNum:(NSString *)numStr
{
    self.alarm_num_lb.text = numStr;
}

- (void)selChannelItemNum:(NSString *)numStr
{
    self.channel_num_lb.text = numStr;
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

- (UILabel *)channel_tl_lb
{
    if (!_channel_tl_lb) {
        _channel_tl_lb = [UILabel z_frame:CGRectMake(25, self.dateView.bottom + 20, 55, 20) Text:@"channel" fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _channel_tl_lb;
}
- (UILabel *)channel_num_lb
{
    if (!_channel_num_lb) {
        _channel_num_lb = [UILabel z_frame:CGRectMake(self.channel_tl_lb.right + 10, 0, 40, 28) Text:@"0" fontSize:14 color:[UIColor colorWithHex:@"#1D68F2"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]];
        _channel_num_lb.centerY = self.channel_tl_lb.centerY;
        _channel_num_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _channel_num_lb;
}

- (SingleChannelShwoSelCollectionView *)showChannelSelcollView
{
    if (!_showChannelSelcollView) {
        WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
        layout.itemHeight = 58;
        _showChannelSelcollView = [[SingleChannelShwoSelCollectionView alloc]initWithFrame:CGRectMake(15, self.channel_tl_lb.bottom + 10, self.width - 30,58) collectionViewLayout:layout];
        _showChannelSelcollView.zdelegate = self;
        _showChannelSelcollView.backgroundColor = [UIColor whiteColor];
    }
    return _showChannelSelcollView;
}

- (UILabel *)alarm_tl_lb
{
    if (!_alarm_tl_lb) {
        _alarm_tl_lb = [UILabel z_frame:CGRectMake(25, self.showChannelSelcollView.bottom + 20, 70, 20) Text:NSLocalizedString(@"告警标签", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _alarm_tl_lb;
}

- (UILabel *)alarm_num_lb
{
    if (!_alarm_num_lb) {
        _alarm_num_lb = [UILabel z_frame:CGRectMake(self.alarm_tl_lb.right + 10, 0, 40, 28) Text:@"0" fontSize:14 color:[UIColor colorWithHex:@"#1D68F2"] isbold:YES cornerRadius:14 backgroundColor:[UIColor colorWithHex:@"#1D68F2" alpha:0.13]];
        _alarm_num_lb.centerY = self.alarm_tl_lb.centerY;
        _alarm_num_lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _alarm_num_lb;
}

- (SingleAlarmShowSelCollectionView *)showAlarmSelcollView
{
    if (!_showAlarmSelcollView) {
        WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
        layout.itemHeight = 58;
        _showAlarmSelcollView = [[SingleAlarmShowSelCollectionView alloc]initWithFrame:CGRectMake(15, self.alarm_tl_lb.bottom + 10, self.width - 30,58) collectionViewLayout:layout];
        _showAlarmSelcollView.zdelegate = self;
        _showAlarmSelcollView.backgroundColor = [UIColor whiteColor];
    }
    return _showAlarmSelcollView;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(16, self.showAlarmSelcollView.bottom + 30, self.width - 32, 50) fontSize:18 cornerRadius:6 backgroundColor:[UIColor colorWithHex:@"#26C464"] titleColor:[UIColor whiteColor] title:NSLocalizedString(@"确定", nil) isbold:YES Target:self action:@selector(sureBtnClick)];
    }
    return _sureBtn;
}


@end
