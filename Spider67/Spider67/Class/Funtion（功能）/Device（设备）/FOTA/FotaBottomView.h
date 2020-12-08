//
//  FotaBottomView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FotaBottomView : UIView

@property (nonatomic, strong) NSDictionary* fotaDict;
@property (nonatomic, copy) NSString* deviceId;
- (void)saveConfigDataCompletion:(void (^ __nullable)(void))completion;;
@end

NS_ASSUME_NONNULL_END
