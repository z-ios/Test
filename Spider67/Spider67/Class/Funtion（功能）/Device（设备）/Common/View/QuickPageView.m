//
//  QuickPageView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "QuickPageView.h"
#import "QuickPageCollectionViewCell.h"
#import "PageModel.h"

@interface QuickPageView ()<UICollectionViewDelegate,UICollectionViewDataSource,WGCollectionViewLayoutDelegate>

@property (nonatomic, strong) UICollectionView* pageSelcollView;

@end
@implementation QuickPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)arrData
{
    if (!_arrData) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _titleLb.frame = CGRectMake(20, 25, self.width - 40, 24);
    _pageSelcollView.frame = CGRectMake(10, self.titleLb.bottom + 10, self.width - 20, self.height - 15 - (self.titleLb.bottom + 10));
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 32;
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.18].CGColor;
    self.layer.shadowOpacity = 18;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    [self addSubview:self.titleLb];
    [self addSubview:self.pageSelcollView];

}


#pragma mark - delegate
-  (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QuickPageCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"QuickPageCollectionViewCell" forIndexPath:indexPath];
    cell.model = _arrData[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(pageBtnClick:)]) {
        [self.delegate pageBtnClick:indexPath.row];
    }
    [_arrData enumerateObjectsUsingBlock:^(PageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (indexPath.row == idx) {
            obj.isSel = YES;
        }else{
            obj.isSel = NO;
        }
    }];
    
    [collectionView reloadData];

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(WGCollectionViewLayout*)collectionViewLayout wideForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 96;
    }else{
        return 43;
    }
}


#pragma mark - lazy

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(20, 25, self.width - 40, 24) Text:NSLocalizedString(@"快速跳转", nil) fontSize:17 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    return _titleLb;
}

- (UICollectionView *)pageSelcollView
{
    if (!_pageSelcollView) {
        WGCollectionViewLayout *layout = [[WGCollectionViewLayout alloc] init];
        layout.itemHeight = 34;
        layout.delegate = self;
        _pageSelcollView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, self.titleLb.bottom + 10, self.width - 20, self.height - 15 - (self.titleLb.bottom + 10) ) collectionViewLayout:layout];
        _pageSelcollView.delegate = self;
        _pageSelcollView.dataSource = self;
        [_pageSelcollView registerClass:[QuickPageCollectionViewCell class] forCellWithReuseIdentifier:@"QuickPageCollectionViewCell"];
        _pageSelcollView.backgroundColor = [UIColor clearColor];
        
    }
    return _pageSelcollView;
}




@end
