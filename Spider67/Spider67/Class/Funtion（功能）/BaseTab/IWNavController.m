//
//  IWNavController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IWNavController.h"

@interface IWNavController ()

@end

@implementation IWNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationBar.prefersLargeTitles = true;
    } else {
        // Fallback on earlier versions
    }
 
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#121212"]}];

    if (zScreenHeight == 896) {
             [[NSUserDefaults standardUserDefaults] setFloat:414 forKey:@"navRightItemX"];
         }else if (zScreenHeight == 736) {
             [[NSUserDefaults standardUserDefaults] setFloat:394 forKey:@"navRightItemX"];
         }else{
             [[NSUserDefaults standardUserDefaults] setFloat:359 forKey:@"navRightItemX"];
         }
    
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 首页不需要隐藏tabbar
    NSString *ctrlName = NSStringFromClass([viewController class]);
    
    if ([ctrlName isEqualToString:@"DeviceController"] ) {
        
        viewController.hidesBottomBarWhenPushed = NO;

    }else{
       // 其他push时需要隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这一句别忘记了啊
    [super pushViewController:viewController animated:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateView];
}

- (void)updateView{
    
    UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    
    blackLineImageView.hidden = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



@end
