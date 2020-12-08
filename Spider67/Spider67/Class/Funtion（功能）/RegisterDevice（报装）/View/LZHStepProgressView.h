//
//  LZHStepProgressView.h
//  LZH_StepProgress
//
//  Created by admin  on 2018/7/17.
//  Copyright © 2018年 刘中华. All rights reserved.
//

#import <UIKit/UIKit.h>

#define color(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
//主色值
#define NeedColor [UIColor colorWithHex:@"#26C464"]
//线左右间隙
#define space 15
//原点大小
#define spotWH 24
//字体大小
#define titleFont spotWH/2+2
//线宽或者高
#define linkWH 4
@interface LZHStepProgressView : UIView


/**
 Direction ：YES：横向 、 NO：纵向
 Count ：圆点个数 ，大于等于2
 */
-(instancetype)initWithFrame:(CGRect)frame setDirection:(BOOL)Direction setCount:(NSInteger)Count ;
//横向角标,默认为0
@property(nonatomic,assign)NSInteger TransverseRecordIndex ;
//纵向角标,默认为0
@property(nonatomic,assign)NSInteger PortraitRecordIndex ;
//上一步
-(void)lastStep ;
//下一步
-(void)nextStep ;

@property (nonatomic, strong) NSString* errorImageName;

-(void)changTransverseLinkViewAnimations;



@end
