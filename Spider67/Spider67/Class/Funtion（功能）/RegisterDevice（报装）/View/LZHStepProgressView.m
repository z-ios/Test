//
//  LZHStepProgressView.m
//  LZH_StepProgress
//
//  Created by admin  on 2018/7/17.
//  Copyright © 2018年 刘中华. All rights reserved.
//

#import "LZHStepProgressView.h"
static dispatch_once_t disOnceTransverse;
static dispatch_once_t disOncePortrait;
@interface LZHStepProgressView()
//记录横向、纵向
@property(nonatomic,assign)BOOL Direction ;
//记录数量
@property(nonatomic,assign)NSInteger Count ;
//背景线
@property(nonatomic,strong)UIView * bgLinkView ;
//进度线
@property(nonatomic,strong)UIView * progressLinkView ;
//文字点数组
@property(nonatomic,strong)NSMutableArray * titleArr ;
@end

@implementation LZHStepProgressView

-(instancetype)initWithFrame:(CGRect)frame setDirection:(BOOL)Direction setCount:(NSInteger)Count{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"] ;
        
        if (Count>=2) {//数量大于等于2时
            self.Direction = Direction ;
            self.Count = Count ;
            
            _bgLinkView = [[UIView alloc]init];
            _bgLinkView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19] ;
            [self addSubview:self.bgLinkView];
            
            _progressLinkView = [[UIView alloc]init];
            _progressLinkView.backgroundColor = [UIColor colorWithHex:@"#26C464"] ;
            [self addSubview:self.progressLinkView];
            
            for (int i=0; i<Count; i++) {
                UIButton * titleLabel = [[UIButton alloc]init];
                titleLabel.backgroundColor = [UIColor colorWithHex:@"#F4F3F3"] ;
                titleLabel.frame = CGRectMake(0, 0, spotWH, spotWH);
                titleLabel.layer.cornerRadius = spotWH/2 ;
                titleLabel.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
                titleLabel.layer.borderWidth = 0.5;
                titleLabel.clipsToBounds = YES ;
                titleLabel.tag = i ;
                titleLabel.titleLabel.font = [UIFont systemFontOfSize:14] ;
                titleLabel.titleLabel.textAlignment = 1 ;
                [titleLabel setTitleColor:[UIColor colorWithHex:@"#ABB5AF"] forState:UIControlStateNormal];
                [titleLabel setTitle:@(i).description forState:UIControlStateNormal];
                [self addSubview:titleLabel];
                [self.titleArr addObject:titleLabel];
            }
        }else{//数量不够两个时
            if (Direction) {//横向
                UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                title.textColor = color(102, 102, 102, 1.0) ;
                title.textAlignment = 1 ;
                title.font = [UIFont systemFontOfSize:15] ;
                title.text = @"请把数量设置在两个或者两个以上" ;
                [self addSubview:title];
            }else{//纵向
                UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake((self.bounds.size.width-30)/2, 0, 30, self.bounds.size.height)];
                title.textColor = color(102, 102, 102, 1.0) ;
                title.textAlignment = 1 ;
                title.numberOfLines = 0 ;
                title.font = [UIFont systemFontOfSize:15] ;
                title.text = @"请把数量设置在两个或者两个以上" ;
                [self addSubview:title];
            }
        }
    }
    return self ;
}


- (void)layoutSubviews{
    if (self.Direction) {//横向
        //背景线
        self.bgLinkView.frame = CGRectMake(space, (self.bounds.size.height-0.5)/2, self.bounds.size.width-space*2, 0.5);
        
        //设置点位置
        for (int i=0; i<self.Count; i++) {
            UILabel * titleLab = self.titleArr[i];
            titleLab.center = CGPointMake(space+(self.bounds.size.width-space*2)/(self.Count-1)*i, self.bgLinkView.center.y);
        }
        
         //初始点选中,此方法只执行一次
//        dispatch_once(&disOnceTransverse,^ {
            [self setTitleContent:self.TransverseRecordIndex];
//        });
        
        //初始进度线
        self.progressLinkView.frame  = CGRectMake(space,(self.bounds.size.height-0.5)/2,(self.bounds.size.width-space*2)/(self.Count-1)*self.TransverseRecordIndex,0.5) ;
    }else{//纵向
        self.bgLinkView.frame = CGRectMake((self.bounds.size.width-linkWH)/2, space, linkWH, self.bounds.size.height-space*2);
        for (int i=0; i<self.Count; i++) {
            UILabel * titleLab = self.titleArr[i];
            titleLab.center = CGPointMake(self.bgLinkView.center.x, space+(self.bounds.size.height-space*2)/(self.Count-1)*i);
        }
        
        dispatch_once(&disOncePortrait,^ {
            [self setTitleContent:self.PortraitRecordIndex];
        });
        
        self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
    }
}

#pragma mark--上一步
-(void)lastStep{
    if (self.Direction) {//横
        if (self.TransverseRecordIndex==0) return ; //等于0时不计数
        self.TransverseRecordIndex-- ; //角标减减
        [self changTransverseLinkViewAnimations];//执行动画
    }else{//纵
        if (self.PortraitRecordIndex==0) return ;
        self.PortraitRecordIndex-- ;
        [self changPortraitLinkViewAnimations];
    }
}

#pragma mark--下一步
-(void)nextStep{
    if (self.Direction) {
        if (self.TransverseRecordIndex==self.Count-1) return ; //最后一个后不计数
        self.TransverseRecordIndex++ ;//角标加加
        [self changTransverseLinkViewAnimations];//执行动画
    }else{
        if (self.PortraitRecordIndex==self.Count-1) return ;
        self.PortraitRecordIndex++ ;
        [self changPortraitLinkViewAnimations];
    }
}

//改变横向文字状态操作
-(void)changTransverseLinkViewAnimations{
    
    [UIView animateWithDuration:0.6f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.progressLinkView.frame = CGRectMake(space,(self.bounds.size.height-1)/2,(self.bounds.size.width-space*2)/(self.Count-1)*self.TransverseRecordIndex,1) ;
        [self setTitleContent:self.TransverseRecordIndex];
    } completion:nil];
}

//改变纵向文字状态操作
-(void)changPortraitLinkViewAnimations{
    [UIView animateWithDuration:0.4 animations:^{
        self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
    }completion:^(BOOL finished) {
        [self setTitleContent:self.PortraitRecordIndex];
    }];
}

//状态改变执行
-(void)setTitleContent:(NSInteger)index{
    for (int i=0; i<self.Count; i++) {
        if (index==i) { //当前状态
            UIButton * changTitle = self.titleArr[index] ;
            [changTitle setTitleColor:[UIColor colorWithHex:@"#26C464"] forState:UIControlStateNormal];
            changTitle.layer.borderWidth = 1;
            changTitle.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor ;
            changTitle.backgroundColor = [UIColor whiteColor] ;
            [UIView animateWithDuration:0.2 animations:^{
                changTitle.transform = CGAffineTransformMakeScale(1.8, 1.8);
            }];

            if (self.errorImageName && ![self.errorImageName isEqualToString:@""]) {
                [changTitle setImage:[SVGKImage imageNamed:self.errorImageName].UIImage forState:UIControlStateNormal];
                changTitle.layer.borderWidth = 0;
            }else{
                [changTitle setTitle:@(index + 1).description forState:UIControlStateNormal];
                [changTitle setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                changTitle.layer.borderWidth = 1;
            }
            
            
        }else{//恢复状态
            
            if (index<i) {
                UIButton * titleLab = self.titleArr[i];
                titleLab.backgroundColor = [UIColor colorWithHex:@"#F4F3F3"] ;
                titleLab.transform = CGAffineTransformMakeScale(1.0, 1.0);
                [titleLab setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
                [titleLab setTitleColor:[UIColor colorWithHex:@"#ABB5AF"] forState:UIControlStateNormal];
                [titleLab setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                titleLab.layer.borderWidth = 0.5;
                titleLab.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor ;
            }else{
                UIButton * titleLab = self.titleArr[i];
                [titleLab setImage:[SVGKImage imageNamed:@"icon_dr_process_finish"].UIImage forState:UIControlStateNormal];
                titleLab.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
        }
    }
}

//数组
-(NSMutableArray * )titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:self.Count] ;
    }
    return _titleArr ;
}

@end
