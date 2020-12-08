//
//  ModulesListModel.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/12.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ModulesListModel.h"

@implementation ModulesListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"channels" : [ChannelListModel class]};
}


@end
