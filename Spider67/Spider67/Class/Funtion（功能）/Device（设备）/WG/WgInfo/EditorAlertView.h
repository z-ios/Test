//
//  EditorAlertView.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditorAlertView : UIView

@property (nonatomic, strong) NSDictionary * dataDict;
@property (nonatomic, copy) void(^editorSuccess)(NSString* devName,NSString* groupName);

@end

NS_ASSUME_NONNULL_END
