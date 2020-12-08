//
//  LinkageChannelSelectModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/24.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinkageChannelSelectModel : NSObject

@property (nonatomic, copy) NSString* port;
@property (nonatomic, copy) NSString* channelname;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
