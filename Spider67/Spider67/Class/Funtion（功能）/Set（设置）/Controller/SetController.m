//
//  SetController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SetController.h"
#import "SetScrollView.h"

@interface SetController ()

@property (nonatomic, strong) SetScrollView* scrollView;

@end

@implementation SetController

//- (void)viewWillAppear:(BOOL)animated {
//
//[super viewWillAppear:animated];
//
//[self.navigationController setNavigationBarHidden:YES animated:animated];
//
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//
//[super viewWillDisappear:animated];
//
//[self.navigationController setNavigationBarHidden:NO animated:animated];
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
           self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
       } else {
           // Fallback on earlier versions
       }
}


- (SetScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[SetScrollView alloc] initWithFrame:self.view.bounds];
    }
    return _scrollView;
}

@end
