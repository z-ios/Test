//
//  SceneDelegate.m
//  Spider67
//
//  Created by apple on 17/7/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SceneDelegate.h"
#import "LanguageController.h"
#import <IQKeyboardManager.h>
#import "IWNavController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    
    [self initialvalue];
    
    [self showWindow];
    
    // 键盘弹出
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    if ([UIApplication.sharedApplication.zdelegate respondsToSelector:@selector(logAllSelect)]) {
        [UIApplication.sharedApplication.zdelegate logAllSelect];
    }
    
}

- (void)initialvalue
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"serverIp"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"http://60.29.126.12:5502" forKey:@"serverIp"];
    }
    
    if (![[NSUserDefaults standardUserDefaults] floatForKey:@"httptimeout"]) {
        [[NSUserDefaults standardUserDefaults] setFloat:10 forKey:@"httptimeout"];
    }
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"websocketreset"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"websocketreset"];
    }
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"blereset"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:5 forKey:@"blereset"];
    }
}

- (void)showWindow
{
    
    LanguageController* enterVc = [[LanguageController alloc] init];
    self.window.rootViewController = enterVc;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:enterVc];
    self.window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
    if (@available(iOS 13.0, *)) {
        _window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }

}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
    if ([UIApplication.sharedApplication.zdelegate respondsToSelector:@selector(logAllSelect)]) {
        [UIApplication.sharedApplication.zdelegate logAllSelect];
    }
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
