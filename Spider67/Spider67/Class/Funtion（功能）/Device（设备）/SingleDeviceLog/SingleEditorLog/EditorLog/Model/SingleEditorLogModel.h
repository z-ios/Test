//
//  SingleEditorLogModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleEditorLogModel : NSObject

@property (nonatomic, assign) CGFloat bgWith;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* device_id;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* logTime;
@property (nonatomic, copy) NSString* editContent;

@end

NS_ASSUME_NONNULL_END

