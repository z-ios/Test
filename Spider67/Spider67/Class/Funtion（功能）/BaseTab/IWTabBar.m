//
//  IWTabBar.m
//  WeiBo17
//
//  Created by teacher on 15/8/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWTabBar.h"

@interface IWTabBar()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation IWTabBar

//编译器认为我们自己定义的成员与父类重名,会有我们自己的逻辑,我们如果没有自己的逻辑的话,可以使用@dynamic标识
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化一个uibutton
        UIButton *button = [[UIButton alloc] init];
    
        //设置按钮的背景图片
//        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
        //设置按钮的中间imageView的图片
        [button setImage:[UIImage imageNamed:@"icon_tabbar_add"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        //设置大小-->当前状态的button
        button.size = button.currentImage.size;
//         button.size = CGSizeMake(24, 24);
        
        //添加点击事件
        [button addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        self.plusButton = button;
        
    }
    return self;
}


- (CGRect)getTabBarItemFrameWithCount:(NSInteger)count index:(NSInteger)index
{
    NSInteger i = 0;
    CGRect itemFrame = CGRectZero;
    for (UIView *view in self.subviews) {
        if (![NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        //找到指定的tabBarItem
        if (index == i++) {
            itemFrame = view.frame;
            break;
        }
    }
    
    return itemFrame;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
    //调整加号按钮的位置
    CGRect itemFrame = [self getTabBarItemFrameWithCount:self.items.count index:2];
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = itemFrame.size.height*0.5;
    NSLog(@"==%@",NSStringFromCGRect(self.frame ));
    
    
    //取出子控件的个数
    NSInteger count = self.subviews.count;
    
    //计算每一个button的宽度
    CGFloat buttonWidth = self.width / 5;
    
    
    NSInteger index = 0;
    
    
    for (int i=0; i<count; i++) {
        //根据index调整UITabbarButton的位置
        UIView *childView = self.subviews[i];
        
        //判断是否是UITabBarButton
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置宽度与x值
            childView.width = buttonWidth;
            //这个地方乘以的是自己维护的一个index-->UITabBar里面的子控件不只是UITabBarButton
            childView.x = buttonWidth * index;
            
            //在设置完一个按钮之后,index就加了一个1
            index ++;
            //如果发现第2个按钮设置完成,第3个按钮的位置需要多向后面移一个,所以加一个1
            if (index == 2) {
                index ++;
            }
        }
        
    }
}


- (void)plusButtonClick:(UIButton *)button{
    
//    if (self.plusBtnClick) {
//        self.plusBtnClick();
//    }
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectPlusButton:)]) {
        [self.delegate tabBar:self didSelectPlusButton:button];
    }
}


@end
