//
//  SendConfigModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SendConfigChildModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SendConfigModel : NSObject

@property (nonatomic, copy) NSString* moduletype;
@property (nonatomic, copy) NSString* modulename;
/** 内容 */
@property (nonatomic, copy) NSArray<SendConfigChildModel *> *channels;

/** 是否展开 */
@property (nonatomic, assign) BOOL isExpand;

/** 已反馈 */
@property (nonatomic, copy) NSString *giveFeedback;

@end

NS_ASSUME_NONNULL_END
