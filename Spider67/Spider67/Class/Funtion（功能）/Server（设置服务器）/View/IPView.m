//
//  IPView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IPView.h"
#import "IpCell.h"
#import "DomainCell.h"

@interface IPView ()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,ServerPtc>

@property (nonatomic, strong) UILabel* greenLine;
@property (nonatomic, strong) TYCyclePagerView* ipView;

@end
@implementation IPView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       [self setupUI];
        
    }
    return self;
}


- (void)setupUI{

    UIButton* ipBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width * 0.5, SPH(39))];
    [ipBtn setTitle:@"IP" forState:UIControlStateNormal];
    [ipBtn setTitleColor:[UIColor colorWithHex:@"#808080"] forState:UIControlStateNormal];
    ipBtn.titleLabel.font = [UIFont systemFontOfSize:SPFont(14)];
    [self addSubview:ipBtn];
    ipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, ipBtn.width*0.8);
    [ipBtn addTarget:self action:@selector(ipBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    UIButton* domainBtn = [[UIButton alloc] initWithFrame:CGRectMake(ipBtn.right, 0, ipBtn.width, ipBtn.height)];
    [domainBtn setTitle:@"Domain" forState:UIControlStateNormal];
    [domainBtn setTitleColor:[UIColor colorWithHex:@"#808080"] forState:UIControlStateNormal];
    domainBtn.titleLabel.font = [UIFont systemFontOfSize:SPFont(14)];
    [self addSubview:domainBtn];
    domainBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, domainBtn.width*0.6);
    [domainBtn addTarget:self action:@selector(domainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* line = [[UILabel alloc] initWithFrame:CGRectMake(ipBtn.x, ipBtn.bottom - 0.25, self.width, 0.5)];
    line.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [self addSubview:line];
    
    UILabel* greenLine = [[UILabel alloc] initWithFrame:CGRectMake(ipBtn.x, ipBtn.bottom - 1, self.width * 0.5, 2)];
    greenLine.backgroundColor = [UIColor colorWithHex:@"#26C464"];
    [self addSubview:greenLine];
    _greenLine = greenLine;
    
    TYCyclePagerView *ipView = [[TYCyclePagerView alloc]initWithFrame:CGRectMake(ipBtn.x, greenLine.bottom + SPH(15), line.width, SPH(48))];
    ipView.isInfiniteLoop = NO;
    ipView.dataSource = self;
    ipView.delegate = self;
    [ipView registerClass:[IpCell class] forCellWithReuseIdentifier:@"IpCell"];
    [ipView registerClass:[DomainCell class] forCellWithReuseIdentifier:@"DomainCell"];
    [self addSubview:ipView];
    _ipView = ipView;
    [ipView reloadData];
    
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return 2;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    if (index == 0) {
        IpCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"IpCell" forIndex:index];
        cell.ipW = _ipW;
        _tf1 = cell.tf1;
        _tf2 = cell.tf2;
        _tf3 = cell.tf3;
        _tf4 = cell.tf4;
        cell.delegate = self;
        return cell;
    }else{
        DomainCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"DomainCell" forIndex:index];
        cell.ipW = _ipW;
        _domainTf = cell.domainTf;
        cell.delegate = self;
        return cell;
    }
    
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {

    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = pageView.bounds.size;
    layout.itemSpacing = 2;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    if (toIndex == 0) {
        _typeNum = 0;
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.greenLine.x = 0;
        } completion:nil];
    }else{
        _typeNum = 1;
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
              self.greenLine.x = self.greenLine.width;
          } completion:nil];
    }
}

- (void)ipshowServerList
{
    if ([self.delegate respondsToSelector:@selector(showServerList)]) {
           [self.delegate showServerList];
       }
}

- (void)setTypeNum:(NSInteger)typeNum
{
    _typeNum = typeNum;
    
    if (typeNum == 0) {
        [_ipView scrollToItemAtIndex:0 animate:YES];
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
           self.greenLine.x = 0;
        } completion:nil];
    }else{
        [_ipView scrollToItemAtIndex:1 animate:YES];
        [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.greenLine.x = self.greenLine.width;
        } completion:nil];
    }

}

- (void)ipBtnClick:(UIButton *)btn
{
    [_ipView scrollToItemAtIndex:0 animate:YES];
    _typeNum = 0;
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.greenLine.x = 0;
    } completion:nil];
}

- (void)domainBtnClick:(UIButton *)btn
{
    [_ipView scrollToItemAtIndex:1 animate:YES];
    _typeNum = 1;
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.greenLine.x = self.greenLine.width;
    } completion:nil];
}




@end
