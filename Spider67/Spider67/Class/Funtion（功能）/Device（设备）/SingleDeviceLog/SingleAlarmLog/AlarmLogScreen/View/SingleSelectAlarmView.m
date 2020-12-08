//
//  SingleSelectAlarmView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleSelectAlarmView.h"
#import "SingAlarmItemModel.h"
#import "SingleSelAlarmCollectionViewCell.h"

@interface SingleSelectAlarmView ()<UICollectionViewDelegate,UICollectionViewDataSource,WGCollectionViewLayoutDelegate>

@property (nonatomic, strong) UILabel* title_lb;
@property (nonatomic, strong) UILabel* num_lb;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) UIButton* sureBtn;
@property (nonatomic,strong) UIButton* cancelBtn;
@property (nonatomic, assign) NSInteger selNum;

@end
@implementation SingleSelectAlarmView

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
    [self addSubview:self.collectionView];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];

}

- (void)setItemList:(NSArray<SingAlarmItemModel *> *)itemList
{
    _itemList = itemList;
    
    [_itemList enumerateObjectsUsingBlock:^(SingAlarmItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSel) {
                self.selNum +=1;
            }
            self.num_lb.text = [NSString stringWithFormat:@"%zd",_selNum];
    }];
}

#pragma mark - delegate
-  (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SingleSelAlarmCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleSelAlarmCollectionViewCell" forIndexPath:indexPath];

    cell.model = _itemList[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    _itemList[indexPath.row].isSel = !_itemList[indexPath.row].isSel;
    if (_itemList[indexPath.row].isSel) {
        _selNum +=1;
    }else{
        _selNum -=1;
    }
    _num_lb.text = [NSString stringWithFormat:@"%zd",_selNum];
    [CATransaction setDisableActions:YES];
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:0], nil]];
    [CATransaction commit];
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout*)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _itemList[indexPath.row].itemW;
}

#pragma mark - btnclick
- (void)sureClick
{

    NSMutableArray* arrM = [NSMutableArray array];
    [_itemList enumerateObjectsUsingBlock:^(SingAlarmItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSel) {
            [arrM addObject:obj];
        }
    }];
    if (self.selAlarmDatas) {
        self.selAlarmDatas(arrM);
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
        _title_lb = [UILabel z_frame:CGRectMake(25, 30, 0, 33) Text:NSLocalizedString(@"选择一个标签（多选）", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
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

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
        layout.delegate = self;
        layout.itemHeight = 42;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, self.title_lb.bottom + 25, self.width - 30, self.height - (self.title_lb.bottom + 25+64)) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.collectionView registerClass:[SingleSelAlarmCollectionViewCell class] forCellWithReuseIdentifier:@"SingleSelAlarmCollectionViewCell"];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return _collectionView;
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
