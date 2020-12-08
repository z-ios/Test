//
//  RegisterContentView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "RegisterContentView.h"
#import "DeviceLineCollectionViewCell.h"
#import "NetLineCollectionViewCell.h"
#import "IoTHubCollectionViewCell.h"
#import "TestIoTHubCollectionViewCell.h"
#import "EditPropertiesCollectionViewCell.h"
#import "FinishRegisterCollectionViewCell.h"

@interface RegisterContentView ()<UICollectionViewDataSource,UICollectionViewDelegate,RegisterPtc,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, copy) NSString* directionStr;
@property (nonatomic, strong) NSMutableDictionary* dictData;
@property (nonatomic, assign) NSInteger reLineNum;

@end
@implementation RegisterContentView
{
   CGFloat lastContentOffset;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (NSMutableDictionary *)dictData
{
    if (!_dictData) {
        _dictData = [NSMutableDictionary dictionary];
    }
    return _dictData;
}

- (void)setupUI{
    
    _scrollIndex = 0;
    _reLineNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"blereset"];
    _directionStr = @"前";
    self.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(32,32)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.itemSize = CGSizeMake(self.width, self.height - SPH(30));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - SPH(30)) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollEnabled = NO;
    [self addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor redColor];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"DateCell"];
    [_collectionView registerClass:[DeviceLineCollectionViewCell class] forCellWithReuseIdentifier:@"DeviceLineCollectionViewCell"];
    [_collectionView registerClass:[NetLineCollectionViewCell class] forCellWithReuseIdentifier:@"NetLineCollectionViewCell"];
    [_collectionView registerClass:[IoTHubCollectionViewCell class] forCellWithReuseIdentifier:@"IoTHubCollectionViewCell"];
    [_collectionView registerClass:[TestIoTHubCollectionViewCell class] forCellWithReuseIdentifier:@"TestIoTHubCollectionViewCell"];
    [_collectionView registerClass:[EditPropertiesCollectionViewCell class] forCellWithReuseIdentifier:@"EditPropertiesCollectionViewCell"];
    [_collectionView registerClass:[FinishRegisterCollectionViewCell class] forCellWithReuseIdentifier:@"FinishRegisterCollectionViewCell"];
    

}


#pragma mark - UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        DeviceLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeviceLineCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 1) {
        NetLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NetLineCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 2) {
        IoTHubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IoTHubCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 3) {
        TestIoTHubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TestIoTHubCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 4) {
        EditPropertiesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditPropertiesCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 5) {
        FinishRegisterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FinishRegisterCollectionViewCell" forIndexPath:indexPath];
        return cell;
    }

    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

    if ([cell isKindOfClass:[DeviceLineCollectionViewCell class]]) {
        DeviceLineCollectionViewCell *devicecell = (DeviceLineCollectionViewCell *)cell;
        devicecell.delegate = self;
    }else if ([cell isKindOfClass:[NetLineCollectionViewCell class]]) {
        NetLineCollectionViewCell *netcell = (NetLineCollectionViewCell *)cell;
        self.delegate = netcell;
        netcell.delegate = self;
        if ([_directionStr isEqualToString:@"前"]) {
            if ([self.delegate respondsToSelector:@selector(collectViewCellWillAppearDictData:)]) {
                [self.delegate collectViewCellWillAppearDictData:self.dictData.copy];
            }
        }
    }else if ([cell isKindOfClass:[IoTHubCollectionViewCell class]]) {
        IoTHubCollectionViewCell *iotcell = (IoTHubCollectionViewCell *)cell;
        self.delegate = iotcell;
        iotcell.delegate = self;
        if ([_directionStr isEqualToString:@"前"]) {
            if ([self.delegate respondsToSelector:@selector(collectViewCellWillAppearDictData:)]) {
                [self.delegate collectViewCellWillAppearDictData:self.dictData.copy];
            }
        }
    }else if ([cell isKindOfClass:[TestIoTHubCollectionViewCell class]]) {
        TestIoTHubCollectionViewCell *testcell = (TestIoTHubCollectionViewCell *)cell;
        self.delegate = testcell;
        testcell.delegate = self;
        if ([_directionStr isEqualToString:@"前"]) {
            if ([self.delegate respondsToSelector:@selector(collectViewCellWillAppearDictData:)]) {
                [self.delegate collectViewCellWillAppearDictData:self.dictData.copy];
            }
        }
    }else if ([cell isKindOfClass:[EditPropertiesCollectionViewCell class]]) {
        EditPropertiesCollectionViewCell *editorcell = (EditPropertiesCollectionViewCell *)cell;
        self.delegate = editorcell;
        editorcell.delegate = self;
        if ([_directionStr isEqualToString:@"前"]) {
            if ([self.delegate respondsToSelector:@selector(collectViewCellWillAppearDictData:)]) {
                [self.delegate collectViewCellWillAppearDictData:self.dictData.copy];
            }
        }
    }else if ([cell isKindOfClass:[FinishRegisterCollectionViewCell class]]) {
        FinishRegisterCollectionViewCell *finishcell = (FinishRegisterCollectionViewCell *)cell;
        self.delegate = finishcell;
        finishcell.delegate = self;
        if ([_directionStr isEqualToString:@"前"]) {
            if ([self.delegate respondsToSelector:@selector(collectViewCellWillAppearDictData:)]) {
                [self.delegate collectViewCellWillAppearDictData:self.dictData.copy];
            }
        }
    }
}


- (void)setScrollIndex:(NSInteger)scrollIndex
{
    if (_scrollIndex < scrollIndex) {
        _directionStr = @"前";
    }else{
        _directionStr = @"后";
    }
    _scrollIndex = scrollIndex;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:scrollIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

#pragma mark - 上一步，下一步
- (void)stepClick
{
    if (self.stepBlock) {
        self.stepBlock();
    }
}
- (void)nextClick
{
    if (self.nextBlock) {
        self.nextBlock();
    }
}

- (void)cancelClick
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - 蓝牙断开重连提示
- (void)bleDisconnnectedBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral isReline:(BOOL)isReline
{
    if (_scrollIndex>0) {
        if ([self.delegate respondsToSelector:@selector(bleDisconnnectedBle:Peripheral:)]) {
            [self.delegate bleDisconnnectedBle:ble Peripheral:peripheral];
        }
    }else{
        //             重连
        if (_scrollIndex == 0 && !isReline && [_directionStr isEqualToString:@"前"]) {
            [ble setUpConnectPeripheral:peripheral];
            [MBhud.shared showText:NSLocalizedString(@"设备重连中...", nil) addView:zAppWindow location:zScreenHeight*0.35 completion:^(MBProgressHUD * _Nonnull hud) {
                [MBhud showText:NSLocalizedString(@"连接超时", nil) addView:zAppWindow];
            }];
            --_reLineNum;
        }
    }
}

#pragma mark - 蓝牙连接成功
- (void)bleConnnectedSuccessBle:(BluetoothEquipment *)ble Peripheral:(CBPeripheral *)peripheral
{
    self.dictData[@"ble"] = ble;
    self.dictData[@"peripheral"] = peripheral;
    if (_scrollIndex>0) {
        if ([self.delegate respondsToSelector:@selector(bleConnnectedSuccessBle:Peripheral:)]) {
            [self.delegate bleConnnectedSuccessBle:ble Peripheral:peripheral];
        }
    }else{
        [MBhud.shared.hud hideAnimated:YES];
//        [MBhud showText:NSLocalizedString(@"连接成功", nil) addView:zAppWindow];
    }
}

#pragma mark - 蓝牙读取数据
- (void)bleReadValueSuccessBleRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral
{
    if ([self.delegate respondsToSelector:@selector(bleReadValueSuccessBleRes:Peripheral:)]) {
        [self.delegate bleReadValueSuccessBleRes:res Peripheral:peripheral];
    }
}

#pragma mark - 把服务器端口和地址传到iothub配置

- (void)netIpAndPortWithSeverIp:(NSString *)severIp severPort:(NSString *)severPort biaoshima:(NSString *)biaoshimaStr xinghao:(NSString *)xinghaoStr
{
    self.dictData[@"severIp"] = severIp;
    self.dictData[@"severPort"] = severPort;
    self.dictData[@"biaoshimaStr"] = biaoshimaStr;
    self.dictData[@"xinghaoStr"] = xinghaoStr;
}
#pragma mark - 选择之后的ip和iot名字
- (void)selectediotHubInfo:(NSDictionary *)dict
{
    self.dictData[@"iotHubName"] = dict[@"instancename"];
    self.dictData[@"iothubIp"] = dict[@"domain"];
    self.dictData[@"iothubPort"] = dict[@"mqttport"];
    self.dictData[@"protocol"] = dict[@"protocol"];
    self.dictData[@"password"] = dict[@"password"];
    self.dictData[@"username"] = dict[@"username"];
    self.dictData[@"version"] = dict[@"version"];
}

#pragma mark - iothub验证失败
- (void)iotHubcheckFail
{
    if (self.checkFailBlock) {
        self.checkFailBlock();
    }
}

#pragma mark - 取消蓝牙连接
- (void)cancelBleConnected
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    if (self.resetIndexBlock) {
        self.resetIndexBlock();
    }
}

#pragma mark - 蓝牙重新连接
- (void)BluetoothReconnection
{
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:_scrollIndex inSection:0]]];
}

#pragma mark - 传值thingId
- (void)iothubThingId:(NSString *)thingId
{
    self.dictData[@"thingId"] = thingId;
}

#pragma mark - 群组名字,注册id
- (void)deviceName:(NSString *)devieceName groupName:(NSString *)groupName registerId:(NSString *)registerId note:(nonnull NSDictionary *)note
{
    self.dictData[@"devieceName"] = devieceName;
    self.dictData[@"groupName"] = groupName;
    self.dictData[@"registerId"] = registerId;
    self.dictData[@"note"] = note;
}

@end
