//
//  SingAlarmItemModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingAlarmItemModel : NSObject

@property (nonatomic, copy) NSString* tagcolor;
@property (nonatomic, copy) NSString* tagname;
@property (nonatomic, assign) CGFloat itemW;
@property (nonatomic, assign) BOOL isSel;
@property (nonatomic, copy) NSString* id;

@end

NS_ASSUME_NONNULL_END

