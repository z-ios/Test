//
//  CenterManager.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "CenterManager.h"

@implementation CenterManager

+ (instancetype)shared{
    
    static CenterManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    instance = [CenterManager new];

    });
    return  instance;
}

@end
