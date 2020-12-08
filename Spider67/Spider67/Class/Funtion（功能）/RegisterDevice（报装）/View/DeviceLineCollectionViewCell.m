//
//  DeviceLineCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DeviceLineCollectionViewCell.h"
#import "BleLineCell.h"
#import "BleModel.h"
#import "BtnView.h"
#import "BaseTableView.h"

@interface DeviceLineCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,BlePtc,RegisterPtc>

@property (nonatomic, strong) BaseTableView* tableView;
@property (nonatomic, strong) NSMutableArray<CBPeripheral *>* peripheralDataArray;
@property (nonatomic, strong) BluetoothEquipment* ble;
@property (nonatomic, strong) NSMutableArray<BleModel *>* bleModelList;
@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, assign) BOOL isReline;

@end
@implementation DeviceLineCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self initBle];
    }
    return self;
}

- (void)initBle{
    
    _ble = [[BluetoothEquipment alloc] init];
    _ble.delegate = self;
    [_ble initCentralManager];
    
}

- (NSMutableArray<CBPeripheral *> *)peripheralDataArray
{
    if (!_peripheralDataArray) {
        _peripheralDataArray = [NSMutableArray array];
    }
    return _peripheralDataArray;
}
- (NSMutableArray<BleModel *> *)bleModelList
{
    if (!_bleModelList) {
        _bleModelList = [NSMutableArray array];
        [self addSubview:self.btnV];
    }
    return _bleModelList;
}

- (void)setupUI{

    self.backgroundColor = [UIColor whiteColor];
    
    UILabel* titleLb = [UILabel z_frame:CGRectMake(16, SPH(30), 0, SPH(33)) Text:NSLocalizedString(@"设备连接", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    [titleLb sizeToFit];
    [self addSubview:titleLb];
    
    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    activityIndicator.x = titleLb.right + 15;
    activityIndicator.centerY = titleLb.centerY;
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
    
    _tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(12, titleLb.bottom+7.5, self.width - 24, self.height - (titleLb.bottom + SPH(15))) style:(UITableViewStylePlain)];
    _tableView.backgroundColor =  [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.rowHeight = SPH(143);
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SPH(80), 0);
    [self addSubview:self.tableView];
    
    [_tableView registerClass:[BleLineCell class] forCellReuseIdentifier:@"BleLineCell"];
    _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"pic_dr_nodevice" titleStr:NSLocalizedString(@"当前无设备", nil) detailStr:@""];
    _tableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#808080"];
    _tableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:14];
    
}


#pragma mark - 蓝牙扫描结果代理方法

- (void)bleScanResDiscoverPeripheral:(CBPeripheral *)peripheral
{
    if(![self.peripheralDataArray containsObject:peripheral]) {
        [self.peripheralDataArray addObject:peripheral];
        BleModel* model = [BleModel new];
        model.name = peripheral.name;
        model.identifierString = peripheral.identifier.UUIDString;
        model.lineState = NSLocalizedString(@"未连接", nil);
        model.peripheral = peripheral;
        [self.bleModelList addObject:model];
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.peripheralDataArray.count -1 inSection:0];
        [indexPaths addObject:indexPath];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

    }
}


#pragma mark - tabView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _bleModelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BleLineCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BleLineCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.bleModelList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.bleModelList[indexPath.row].lineState isEqualToString:NSLocalizedString(@"未连接", nil)]) {
        __block  BOOL isContent = NO;
        [self.bleModelList enumerateObjectsUsingBlock:^(BleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.lineState isEqualToString:NSLocalizedString(@"已连接", nil)]) {
                // 断开
                if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hans"]) {
                    [self alertWithTextString:[NSString stringWithFormat:@"已连接设备“%@”，继续操作则会断开当前连接，是否继续？",obj.name] lineModel:self.bleModelList[indexPath.row] disconnectModel:obj];
                }else{
                    [self alertWithTextString:[NSString stringWithFormat:@"Currently connected to %@, continue operation will disconnect, whether to continue",obj.name] lineModel:self.bleModelList[indexPath.row] disconnectModel:obj];
                }
                
                isContent = YES;
            }else if ([obj.lineState isEqualToString:NSLocalizedString(@"连接中...", nil)]) {
                isContent = YES;
            }
        }];
        
        if (isContent == NO) {
            self.bleModelList[indexPath.row].lineState = NSLocalizedString(@"连接中...", nil);
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            // 连接设别
            [_ble setUpConnectPeripheral:self.bleModelList[indexPath.row].peripheral];
        }
    }
}

#pragma mark - tableview侧滑删除
//开启tableview的编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.bleModelList.count > 0) {
        if ([self.bleModelList[indexPath.row].lineState isEqualToString:NSLocalizedString(@"已连接", nil)]) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
    
}

//iOS11之后侧滑删除-支持设置图片【设置后iOS11优先走这里，与上面不冲突】
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        self.isReline = YES;
        // 断开连接
        [self.ble.centralManager cancelPeripheralConnection:self.bleModelList[indexPath.row].peripheral];
        completionHandler (YES);
    }];
    deleteRowAction.image = [SVGKImage imageNamed:@"icon_unlink"].UIImage;
    deleteRowAction.backgroundColor = [UIColor whiteColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    return config;
}

#pragma mark - 蓝牙连接成功
- (void)connectSuccessCentralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self.bleModelList enumerateObjectsUsingBlock:^(BleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifierString isEqualToString:peripheral.identifier.UUIDString]) {
            obj.lineState = NSLocalizedString(@"已连接", nil);
            [self.tableView reloadData];
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(bleConnnectedSuccessBle:Peripheral:)]) {
        [self.delegate bleConnnectedSuccessBle:_ble Peripheral:peripheral];
    }
    
    self.btnV.typeBtnStr = @"一个按钮可点击";
}

#pragma mark - 连接失败、掉线
- (void)bleCentralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral
{
    [self.bleModelList enumerateObjectsUsingBlock:^(BleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifierString isEqualToString:peripheral.identifier.UUIDString]) {
            obj.lineState = NSLocalizedString(@"未连接", nil);
            [self.tableView reloadData];
        }
    }];
    
    if ([self.delegate respondsToSelector:@selector(bleDisconnnectedBle:Peripheral:isReline:)]) {
        [self.delegate bleDisconnnectedBle:_ble Peripheral:peripheral isReline:_isReline];
    }
        
    _isReline = NO;
    self.btnV.typeBtnStr = @"一个按钮不可点击";
  
}

#pragma mark - 蓝牙读取结果
- (void)bleReadRes:(NSString *)res Peripheral:(CBPeripheral *)peripheral
{
    if ([self.delegate respondsToSelector:@selector(bleReadValueSuccessBleRes:Peripheral:)]) {
        [self.delegate bleReadValueSuccessBleRes:res Peripheral:peripheral];
    }
}

#pragma mark - 切换连接设备提示
- (void)alertWithTextString:(NSString *)textStr lineModel:(BleModel *)lineModel disconnectModel:(BleModel *)disconnectModel
{
    
    UIAlertController *action = [UIAlertController alertControllerWithTitle:textStr message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"返回", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:NSLocalizedString(@"继续", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.isReline = YES;
        // 断开
        [self.ble.centralManager cancelPeripheralConnection:disconnectModel.peripheral];
        // 连接
        [self.ble setUpConnectPeripheral:lineModel.peripheral];
        
    }];
    [alertF setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
    [alertT setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
    [action addAction:alertT];
    [action addAction:alertF];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [zAppWindow.rootViewController.presentedViewController presentViewController:action animated:YES completion:nil];
    });

}

#pragma mark - btnV点击代理方法-

- (void)nextClick
{
    if (_ble.c == nil) {
        [MBhud showText:NSLocalizedString(@"蓝牙正在获取特征值...", nil) addView:zAppWindow];
    }else{
        if ([self.delegate respondsToSelector:@selector(nextClick)]) {
            [self.delegate nextClick];
        }
    }
}

#pragma mark - 控件懒加载

- (BtnView *)btnV
{
    if (!_btnV) {
        _btnV = [[BtnView alloc] initWithFrame:CGRectMake(SPW(16), self.height - SPH(44) - SPH(52), self.width - SPW(16)*2, SPH(52))];
        _btnV.delegate = self;
        _btnV.typeBtnStr = @"一个按钮不可点击";
    }
    
    return _btnV;
}



@end
