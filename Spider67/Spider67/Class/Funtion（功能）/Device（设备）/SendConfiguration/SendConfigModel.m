//
//  SendConfigModel.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendConfigModel.h"

@implementation SendConfigModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"channels" : [SendConfigChildModel class]};
}

@end
