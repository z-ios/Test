//
//  IWTabBarController.m
//  WeiBo17
//
//  Created by teacher on 15/8/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "IWTabBarController.h"
#import "IWTabBar.h"
#import "DeviceController.h"
#import "LogController.h"
#import "SetController.h"
#import "MeController.h"
#import "IWNavController.h"
#import "RegisterController.h"

@interface IWTabBarController ()<IWTabBarDelegate>

@end

@implementation IWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化一个自定义的tabbar
    IWTabBar *tabbar = [[IWTabBar alloc] init];
    //不写下面这行代码也是可以的,因为系统会自动帮我们设置,因我们的delegate这个成员变量与父类的名字一样
//    tabbar.delegate = self;
//    [tabbar setPlusBtnClick:^{
//        NSLog(@"block调用了");
//    }];
    //因为是只读属性,所以通过kvc的方式去赋值
    [self setValue:tabbar forKeyPath:@"tabBar"];
//    self.tabBar = tabbar;
    
    //设备
    DeviceController *deviceCtrl = [DeviceController new];
    [self addChildViewController:deviceCtrl imageName:@"icon_tabbar_device" title:nil];
    //日志
    LogController *logCtrl = [LogController new];
    [self addChildViewController:logCtrl imageName:@"icon_tabbar_log" title:nil];
//    //设置
    SetController *discoverCtrl = [SetController new];
    [self addChildViewController:discoverCtrl imageName:@"icon_tabbar_set" title:nil];
//    //我
    MeController *profileCtrl = [MeController new];
    [self addChildViewController:profileCtrl imageName:@"icon_tabbar_me" title:nil];
    
    
    
    
//    NSLog(@"%@",self.tabBar.delegate);
}

//添加子控制器,设置标题与图片
- (void)addChildViewController:(UIViewController *)childCtrl imageName:(NSString *)imageName title:(NSString *)title{
    
    //    //使用自定义的tabBarItem,以便遍历badge身上的view
    //    childCtrl.tabBarItem = [[IWTabBarItem alloc] init];
    
    //    childCtrl.tabBarItem.badgeImageName = @"main_badge";
    //设置选中与未选中的图片-->指定一下渲染模式-->图片以原样的方式显示出来
    childCtrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置标题
    //    childCtrl.tabBarItem.title = title;
    //    childCtrl.navigationItem.title = title;
    childCtrl.title = title;
    
    //    childCtrl.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    //指定一下属性
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //指定字体
    //    dic[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    //指定选中状态下文字颜色
    [childCtrl.tabBarItem setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    if ([childCtrl isKindOfClass:DeviceController.class]) {
        IWNavController *navCtrl = [[IWNavController alloc] initWithRootViewController:childCtrl];
        [self addChildViewController:navCtrl];
    }else{
        [self addChildViewController:childCtrl];
    }
    
}


- (void)tabBar:(IWTabBar *)tabBar didSelectPlusButton:(UIButton *)button{
    NSLog(@"加号按钮点击了");
    RegisterController* vc = [[RegisterController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
