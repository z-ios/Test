//
//  SendSuccessView.h
//  Spider67
//
//  Created by 宾哥 on 2020/11/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendSuccessView : UIView

+ (void)showSuccess:(BOOL)isSuccess vc:(UIViewController *)vc note:(NSString *)note completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
