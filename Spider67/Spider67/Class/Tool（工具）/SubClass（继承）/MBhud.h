//
//  MBhud.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/29.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBhud : NSObject

+ (instancetype)shared;
+ (void)showText:(NSString *)text addView:(UIView *)addView;
- (void)showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location;
- (void)once_showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location;
- (void)showHudText:(NSString *)text addView:(UIView *)addView;
@property (nonatomic, strong) MBProgressHUD *hud;
- (void)showText:(NSString *)text addView:(UIView *)addView location:(CGFloat)location completion:(void (^ __nullable)(MBProgressHUD * _Nonnull hud))completion;
@end

NS_ASSUME_NONNULL_END
