//
//  SingleSendLogScreenCollectionView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleSendLogScreenCollectionView.h"
#import "SingleSendScreenCollectionViewCell.h"
#import "SingleSendItemModel.h"
#import "SingAlermAddCollectionViewCell.h"

@interface SingleSendLogScreenCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,WGCollectionViewLayoutDelegate,DevicePtc>

@end
@implementation SingleSendLogScreenCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        WGCollectionViewLayout *layout =(WGCollectionViewLayout *)self.collectionViewLayout;
        layout.delegate = self;
        [self registerClass:[SingleSendScreenCollectionViewCell class] forCellWithReuseIdentifier:@"SingleSendScreenCollectionViewCell"];
        [self registerClass:[SingAlermAddCollectionViewCell class] forCellWithReuseIdentifier:@"SingAlermAddCollectionViewCell"];
    }
    return self;
}

- (NSMutableArray<SingleSendItemModel *> *)itemList
{
    if (!_itemList) {
        _itemList = [NSMutableArray array];
    }
    return _itemList;
}

#pragma mark - delegate
-  (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemList.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _itemList.count) {
        SingAlermAddCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SingAlermAddCollectionViewCell" forIndexPath:indexPath];
        if (_itemList.count == 0) {
            cell.imgV.image = [UIImage imageNamed:[[NSBundle currentLanguage] isEqualToString:@"zh-Hans"] ? @"tag_notset_chinese" : @"tag_notset_english"];
        }else{
            cell.imgV.image = [UIImage imageNamed:@"icon_tag_add"];
        }
        return cell;
    }else{
        SingleSendScreenCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"SingleSendScreenCollectionViewCell" forIndexPath:indexPath];
        cell.cellPath = indexPath;
        cell.model = _itemList[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_itemList.count == indexPath.row) {
        if ([self.zdelegate respondsToSelector:@selector(selAlarmItemData:)]) {
            [self.zdelegate selAlarmItemData:_itemList.copy];
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout*)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_itemList.count == indexPath.row) {
        if (_itemList.count == 0) {
            return 190;
        }else{
            return 58;
        }
    }else{
        return _itemList[indexPath.row].itemW;
    }
}

- (void)delAlarmItemIndexPath:(NSIndexPath *)indexPath
{
    [_itemList removeObjectAtIndex:indexPath.item];
    [self deleteItemsAtIndexPaths:@[indexPath]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.itemList enumerateObjectsUsingBlock:^(SingleSendItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [CATransaction setDisableActions:YES];
            [self reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:idx inSection:0], nil]];
            [CATransaction commit];
        }];

        [CATransaction setDisableActions:YES];
        [self reloadItemsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:self.itemList.count inSection:0], nil]];
        [CATransaction commit];
    });
    
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        WGCollectionViewLayout *layout =(WGCollectionViewLayout *)self.collectionViewLayout;
        self.height = (layout.columnNum+1)*68 - 10;
    } completion:nil];
    
    if ([self.zdelegate respondsToSelector:@selector(selSendItemNum:)]) {
        [self.zdelegate selSendItemNum:[NSString stringWithFormat:@"%zd",_itemList.count]];
    }
}


@end
