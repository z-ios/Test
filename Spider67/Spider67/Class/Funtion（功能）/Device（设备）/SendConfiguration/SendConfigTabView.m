//
//  SendConfigTabView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendConfigTabView.h"
#import "SendConfigCell.h"
#import "SendConfigModel.h"
#import "SendConfigHeaderView.h"

#define headerHeight 74
@interface SendConfigTabView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<SendConfigModel *> *dataArray;
//@property (nonatomic, retain) NSIndexPath *indexPath;

@end
@implementation SendConfigTabView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor =  [UIColor clearColor];
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
//    self.rowHeight = 74;
//    self.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"pic_empty_list" titleStr:@"列表为空" detailStr:@"" btnTitleStr:@"重新加载" btnClickBlock:^{
//
//    }];
//    self.ly_emptyView.actionBtnBackGroundColor = [UIColor colorWithHex:@"#26C464"];
//    self.ly_emptyView.actionBtnCornerRadius = 6;
//    self.ly_emptyView.actionBtnTitleColor = [UIColor whiteColor];
//    self.ly_emptyView.actionBtnFont = [UIFont boldSystemFontOfSize:18];
//    self.ly_emptyView.contentViewOffset = -50;
//    self.ly_emptyView.titleLabTextColor = [UIColor colorWithHex:@"#121212"];
//    self.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:20];
//    self.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    
    [self registerClass:[SendConfigCell class] forCellReuseIdentifier:@"SendConfigCell"];

}

- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    
    _dataArray = [NSArray yy_modelArrayWithClass:[SendConfigModel class] json:datas];
    
    NSLog(@"%@---%@",_dataArray,_dataArray[0].channels);
    [self reloadData];
}

#pragma mark - tabView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray[section].isExpand) {
        return [self.dataArray[section].channels count];;
    }else{
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, headerHeight)];
    UIView* vv = [[UIView alloc] initWithFrame:CGRectMake(16, 0, zScreenWidth - 32, headerHeight)];
    vv.backgroundColor = [UIColor whiteColor];
    [headView addSubview:vv];
    SendConfigHeaderView *backView = [[SendConfigHeaderView alloc] initWithFrame:CGRectMake(0, 0, vv.width, headerHeight)];
    backView.model = self.dataArray[section];
    
    UIImageView *turnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backView.width - 24 - 15, (backView.height - 24)*0.5, 24, 24)];
    turnImageView.image = [[UIImage imageNamed:@"icon_arrow_dropdown"] imageWithRenderingMode:1];
    [backView addSubview:turnImageView];
    
    backView.tag = 1000 + section;
    headView.backgroundColor = [UIColor clearColor];
    
    if (self.dataArray[section].isExpand) {
        turnImageView.image = [[UIImage imageNamed:@"icon_arrow_packup"] imageWithRenderingMode:1];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = backView.bounds;
        maskLayer.path = maskPath.CGPath;
        vv.layer.mask = maskLayer;
        backView.line_lb.hidden = NO;
        backView.height = 64;
        
    }else{
        turnImageView.image = [[UIImage imageNamed:@"icon_arrow_dropdown"] imageWithRenderingMode:1];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = backView.bounds;
        maskLayer.path = maskPath.CGPath;
        vv.layer.mask = maskLayer;
        backView.line_lb.hidden = YES;
        backView.height = headerHeight;
    }
    
    [vv addSubview:backView];
    
    [backView addTarget:self action:@selector(didClickedSection:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return headView;
}

- (void)didClickedSection:(UIControl *)view{
    NSInteger i = view.tag - 1000;
    self.dataArray[i].isExpand = !self.dataArray[i].isExpand;
    NSIndexSet *index = [NSIndexSet indexSetWithIndex:i];
    [self reloadSections:index withRowAnimation:(UITableViewRowAnimationAutomatic)];
    /** 如果需要收起上一个分区 就用下面的代码 */
    //    [self.dataArray enumerateObjectsUsingBlock:^(AddFeedbackModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        if ([obj.title isEqualToString:self.dataArray[i].title]) {
    //            obj.isExpand = !obj.isExpand;
    //        }
    //        else{
    //            obj.isExpand = NO;
    //        }
    //    }];
        //刷新列表
    //    [_tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.row == 0) {
    SendConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SendConfigCell"];
    cell.model = _dataArray[indexPath.section].channels[indexPath.row];
    
//    if (self.indexPath.section == indexPath.section) {
//        if (self.indexPath == indexPath) {
//            self.dataArray[indexPath.section].content[indexPath.row].isSelect = YES;
//
//        }else{
//            self.dataArray[indexPath.section].content[indexPath.row].isSelect = NO;
//
//        }
//    }
//    cell.childModel = self.dataArray[indexPath.section].content[indexPath.row];
    
    return cell;
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SendConfigCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SendConfigCell"];
//    cell.backgroundColor = [UIColor orangeColor];
//       cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
////    cell.dict = _linkageList[indexPath.row];
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.indexPath = indexPath;
//    [tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

/** 设置分区圆角 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    if ([cell isKindOfClass:[LZRowTableViewCell class]]) {
    
    // 圆角弧度半径
    CGFloat cornerRadius = 8.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    cell.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(cell.bounds, 16, 0);
    
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    //        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
    //            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMinX(bounds), CGRectGetMidY(bounds), cornerRadius);
    //            CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
    //        }
    //        else if (indexPath.row == 0) {
    //            // 初始起点为cell的左下角坐标
    //            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
    //            // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
    //            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
    //            // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
    //            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
    //
    //        }
    
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    } else {
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    cell.backgroundView = roundView;
    
    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
    //    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
    //    backgroundLayer.fillColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1].CGColor;
    //    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
    //    selectedBackgroundView.backgroundColor = UIColor.clearColor;
    //    cell.selectedBackgroundView = selectedBackgroundView;
    //    }
}


@end
