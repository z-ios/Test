//
//  AppDelegate.m
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "LanguageController.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()<DevicePtc>

@end

@implementation AppDelegate

// 提示（可删）
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 13, *)) {
        
    }else
    {
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"serverIp"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"http://60.29.126.12:5502" forKey:@"serverIp"];
        }
        
        [self showWindow];
        
        // 键盘弹出
        [IQKeyboardManager sharedManager].enable = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
        
        
        if ([application.zdelegate respondsToSelector:@selector(logAllSelect)]) {
            [application.zdelegate logAllSelect];
        }
        
    }
    return YES;
}

- (void)showWindow
{
    LanguageController* enterVc = [[LanguageController alloc] init];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:enterVc];
    self.window.rootViewController = nav;
    [_window makeKeyAndVisible];

}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){  
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

// WIFI权限申请理由
//Our application is designed for the hardware devices of enterprises, including the configuration of WIFI information, each enterprise has its own WIFI, I can get the SSID name and password through the company's background service, so that we can make the hardware devices connected to the company's WIFI, through the WIFI network to establish data transmission with the cloud platform.

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {// 退到后台
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    if ([application.zdelegate respondsToSelector:@selector(logAllSelect)]) {
        [application.zdelegate logAllSelect];
    }

}


- (void)applicationWillEnterForeground:(UIApplication *)application {// 进入前台
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
