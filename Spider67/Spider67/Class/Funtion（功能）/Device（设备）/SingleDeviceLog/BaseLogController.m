//
//  BaseLogController.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/26.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BaseLogController.h"

@interface BaseLogController ()

@end

@implementation BaseLogController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)slideMenuViewWillAppear:(NSInteger)index
{

    self.vc.delegate = self;
}

@end
