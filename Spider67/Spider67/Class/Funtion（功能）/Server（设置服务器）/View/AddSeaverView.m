//
//  AddSeaverView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AddSeaverView.h"
#import "BzView.h"
#import "IPView.h"
#import "PortView.h"
#import "XieYiView.h"

@interface AddSeaverView ()

@property (nonatomic, strong) BzView* bzV;
@property (nonatomic, strong) IPView* ipV;
@property (nonatomic, strong) PortView* portV;
@property (nonatomic, strong) XieYiView* xyV;

@end
@implementation AddSeaverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}



- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 18;
    self.layer.masksToBounds = YES;

    //备注
     [self addSubview:self.bzV];
     
     // IP
     [self addSubview:self.ipV];
     
     // portV
     [self addSubview:self.portV];
     
     // 协议
     [self addSubview:self.xyV];
    
    UIButton* sureBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                            norImageName:nil
                            selImageName:nil
                                  Target:self
                                  action:@selector(sureClick)
                                   title:NSLocalizedString(@"确定", nil)
                                selTitle:nil
                                    font:[UIFont boldSystemFontOfSize:SPFont(17)]
                           norTitleColor:[UIColor colorWithHex:@"#26C464"]
                           selTitleColor:nil
                                 bgColor:nil
                            cornerRadius:0
                              borderWidth:0.5
                             borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                        ];
    
       [self addSubview:sureBtn];
       
    UIButton *cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                       norImageName:nil
                       selImageName:nil
                             Target:self
                             action:@selector(cancelClick)
                              title:NSLocalizedString(@"取消", nil)
                           selTitle:nil
                               font:[UIFont boldSystemFontOfSize:SPFont(17)]
                      norTitleColor:[UIColor colorWithHex:@"#808080"]
                      selTitleColor:nil
                            bgColor:nil
                       cornerRadius:0
                                borderWidth:0.5
                        borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                   ];
    
       
       [self addSubview:cancelBtn];
       
    
    
    
}

- (void)sureClick
{
    
//    if (self.sureBlock) {
//        self.sureBlock(@"s");
//    }
    [self saveData];
}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
//    if (self.sureBlock) {
//        self.sureBlock(@"f");
//    }
}

- (void)saveData{
    NSString* ipStr;
        
        if (self.ipV.typeNum == 0) {
            if (self.ipV.tf1.text.length > 0 && self.ipV.tf2.text.length > 0 && self.ipV.tf3.text.length > 0 && self.ipV.tf4.text.length > 0 && self.portV.ptf.text.length > 0) {
                   NSArray* arr = @[self.ipV.tf1.text,self.ipV.tf2.text,self.ipV.tf3.text,self.ipV.tf4.text];
                   ipStr = [arr componentsJoinedByString:@"."];
    //               ipStr = [NSString stringWithFormat:@"%@:%@",ipStr,self.portV.ptf.text];
               }else{
                   [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:[UIApplication sharedApplication].keyWindow];
                   return;
               }
        }else{
            
            if (self.ipV.domainTf.text.length > 0) {
                ipStr = self.ipV.domainTf.text;
            }else{
                [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:[UIApplication sharedApplication].keyWindow];
                return;
            }
        }
        if (self.portV.ptf.text.length == 0) {
            [MBhud showText:NSLocalizedString(@"IP信息错误", @"HUD loading title") addView:[UIApplication sharedApplication].keyWindow];
            return;
        }
       NSLog(@"%@",ipStr);

        // 存值
        NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverhistory"];
        NSMutableArray* arrM = [NSMutableArray array];
        [arrM addObjectsFromArray:arr];
        __block BOOL iscontent = NO;
        [arrM enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          if (([obj[@"devIp"] isEqualToString:ipStr] && [obj[@"devPort"] isEqualToString:self.portV.ptf.text])) {
              iscontent = YES;
          }
        }];
        if (iscontent == NO) {
            NSMutableDictionary* dictM = [NSMutableDictionary dictionary];
            dictM[@"devIp"] = ipStr;
            dictM[@"devPort"] = self.portV.ptf.text;
            dictM[@"devTitle"] = self.bzV.beizhuTf.text;
            dictM[@"devpro"] = self.xyV.xyStr;
            dictM[@"devType"] = @(self.ipV.typeNum);
            [arrM insertObject:dictM atIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:arrM forKey:@"serverhistory"];
            if ([self.delegate respondsToSelector:@selector(saveData:port:titleStr:xieyiStr:typeNum:)]) {
                [self.delegate saveData:ipStr port:self.portV.ptf.text titleStr:self.bzV.beizhuTf.text xieyiStr:self.xyV.xyStr typeNum:self.ipV.typeNum];
            }
        }

    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}


#pragma mark - lazy

- (BzView *)bzV
{
    if (!_bzV) {
        _bzV = [[BzView alloc] initWithFrame:CGRectMake(SPW(20), SPH(40), self.width - SPW(40), SPH(71))];
        _bzV.bzW = self.width - 40;

    }
    
    return _bzV;
}

- (IPView *)ipV
{
    if (!_ipV) {
        _ipV = [[IPView alloc] initWithFrame:CGRectMake(SPW(20),self.bzV.bottom + SPH(15), self.width - SPW(40), SPH(94))];
        _ipV.ipW = 48;

    }
    
    return _ipV;
}

- (PortView *)portV
{
    if (!_portV) {
        _portV = [[PortView alloc] initWithFrame:CGRectMake(SPW(20), self.ipV.bottom + SPH(15), self.width - SPW(40), SPH(71))];
        _portV.portW = 170;
        

      }
      
      return _portV;
}

- (XieYiView *)xyV
{
    if (!_xyV) {
        _xyV = [[XieYiView alloc] initWithFrame:CGRectMake(SPW(20), self.portV.bottom + SPH(15), self.width - SPW(40), SPH(71))];
        _xyV.xyHeight = 48;
      
        
    }
         
         return _xyV;
}


@end
