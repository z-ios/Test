//
//  ModulesListModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChannelListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModulesListModel : NSObject

@property (nonatomic, copy) NSArray<ChannelListModel *> *channels;
@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *moduletype;
@property (nonatomic, copy) NSString *modulename;
@property (nonatomic, copy) NSString *moduletitle;

@end

NS_ASSUME_NONNULL_END

