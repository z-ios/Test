//
//  UIApplication+app.m
//  Spider67
//
//  Created by 宾哥 on 2020/12/8.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UIApplication+app.h"
#import <objc/runtime.h>

static char  * moveTimeKey ="moveTimeKey";

@implementation UIApplication (app)

- (id<DevicePtc>)zdelegate
{
    return  objc_getAssociatedObject(self, moveTimeKey);
}

- (void)setZdelegate:(id<DevicePtc>)zdelegate
{
    objc_setAssociatedObject(self, moveTimeKey, zdelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
