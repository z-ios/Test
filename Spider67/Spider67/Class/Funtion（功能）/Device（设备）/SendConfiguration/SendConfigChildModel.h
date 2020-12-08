//
//  SendConfigChildModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendConfigChildModel : NSObject

@property (nonatomic, copy) NSString* port;
@property (nonatomic, copy) NSString* channelname;
@property (nonatomic, copy) NSString* channeltype;
@property (nonatomic, copy) NSString* channeltitle;

@end

NS_ASSUME_NONNULL_END
