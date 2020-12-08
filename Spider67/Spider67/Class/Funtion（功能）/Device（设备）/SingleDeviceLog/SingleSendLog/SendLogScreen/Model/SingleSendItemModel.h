//
//  SingleSendItemModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleSendItemModel : NSObject

@property (nonatomic, copy) NSString* sendName;
@property (nonatomic, assign) CGFloat itemW;
@property (nonatomic, assign) BOOL isSel;

@end

NS_ASSUME_NONNULL_END
