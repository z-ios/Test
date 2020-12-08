//
//  DevicePtc.h
//  Spider67
//
//  Created by 宾哥 on 2020/8/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DevicePtc <NSObject>

@optional

//钮点击方法
- (void)didSelectItemName:(NSString *)itemName indexPath:(NSIndexPath *)indexPath;
// 选择页数按钮
- (void)pageBtnClick:(NSInteger)pageNum;
// 配置channel
- (void)selectChannelType:(NSString *)channelType;
// 选择报警颜色、值
- (void)selectWarnColor:(NSString *)color value:(NSString *)value;
// 选择执行channel
- (void)selectLinkageChannel:(NSString *)port channnelName:(NSString *)channnelName;
// 选择公式
- (void)selectFormulaName:(NSString *)formulaName unitStr:(NSString *)unitStr formulaStr:(NSString *)formulaStr createtime:(NSString *)createtime;
// 展开下发联动cell
- (void)sendLinkageIndexPath:(NSIndexPath *)indexPath btn:(UIButton *)btn;
// 日志刷选
- (void)screenLog:(UIViewController *)vc;
// 日志批量删除
- (void)batchDeletionLog;
// 日志全选
- (void)logAllSelect;
// 日志取消选中
- (void)logCancelSelect;
// 删除报警条目
- (void)delAlarmItemIndexPath:(NSIndexPath *)indexPath;
// 已选择的报警条目
- (void)selAlarmItemData:(NSArray *)data;
// 已选择的channel条目
- (void)selChannelItemData:(NSArray *)data;
// 已选择的channel条目
- (void)selChannelItemNum:(NSString *)numStr;
// 已选择的报警条目
- (void)selAlarmItemNum:(NSString *)numStr;
// 筛选报警数据
- (void)screenDataAlarmArr:(NSArray *)alarmArr channelArr:(NSArray *)channelArr sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr;
// 已选择动作条目
- (void)selSendItemNum:(NSString *)numStr;
// 筛选操作数据
- (void)screenDataSendArr:(NSArray *)sendArr sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr;
// 筛选channel数据
- (void)screenDataChannelArr:(NSArray *)channelArr sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr;
// 筛选编辑日志数据
- (void)screenDataEditor:(NSString *)userName sdateStr:(NSString *)sdateStr edateStr:(NSString *)edateStr;


@end

NS_ASSUME_NONNULL_END
