//
//  MeController.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "MeController.h"
#import "UserView.h"
#import "LanguageSetView.h"
#import "PwBackView.h"

@interface MeController ()

@property (nonatomic, strong) UserView* userV;
@property (nonatomic, strong) LanguageSetView* languageSetV;
@property (nonatomic, strong) PwBackView* pwbV;

@end

@implementation MeController

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
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    [self.view addSubview:self.userV];
    [self.view addSubview:self.languageSetV];
    [self.view addSubview:self.pwbV];
    
}

- (UserView *)userV
{
    if (!_userV) {
        _userV = [[UserView alloc] initWithFrame:CGRectMake(0, SPH(108), self.view.width , SPH(72))];
    }
    return _userV;
}

- (LanguageSetView *)languageSetV
{
    if (!_languageSetV) {
        _languageSetV = [[LanguageSetView alloc] initWithFrame:CGRectMake(16, self.userV.bottom + SPH(25), self.view.width - 32 , SPH(82))];
    }
    return _languageSetV;
}

- (PwBackView *)pwbV
{
    if (!_pwbV) {
        _pwbV = [[PwBackView alloc] initWithFrame:CGRectMake(16, self.languageSetV.bottom + SPH(10), self.view.width - 32 , SPH(134))];
    }
    return _pwbV;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSURL *url = [[NSURL alloc] initWithString:UIApplicationOpenSettingsURLString];
//    if ([[UIApplication sharedApplication] canOpenURL:url])
//
//    {
//
//        NSData *encryptString=[[NSData alloc] initWithBytes:(unsigned char []){0x41,0x70,0x70,0x2d,0x50,0x72,0x65,0x66,0x73,0x3a,0x72,0x6f,0x6f,0x74,0x3d,0x57,0x49,0x46,0x49,0x54,0x49,0x4f,0x4e,0x53,0x5f,0x49,0x44} length:27];
//        NSString *string=[[NSString alloc] initWithData:encryptString encoding:NSUTF8StringEncoding];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string] options:@{} completionHandler:^(BOOL success) {
//
//        }];
//
//    }
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                                   selector:@selector(imcomingBack)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

//- (void)imcomingBack
//{
//
//}



@end
