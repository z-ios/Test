//
//  UserView.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/15.
//  Copyright © 2020 apple. All rights reserved.
//

#import "UserView.h"

@implementation UserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    //
    UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(SPW(29), 0, self.height, self.height)];
    imgV.image = [UIImage imageNamed:@"icon_userphoto_me"];
    [self addSubview:imgV];
    //
    UILabel* nameLb = [UILabel z_frame:CGRectMake(imgV.right + SPW(20), 0, SPW(75), SPH(33))
                                  Text:NSLocalizedString(@"罗伯特", nil)
                              fontSize:24
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:YES
                       ];
    [self addSubview:nameLb];
    

    NSString* roleString;
    if ([CenterManager.shared.role_id isEqual:@"1"]) {
        roleString = NSLocalizedString(@"系统管理员", nil);
    }else if ([CenterManager.shared.role_id isEqual:@"1"]) {
        roleString = NSLocalizedString(@"群组管理员", nil);
    }else if ([CenterManager.shared.role_id isEqual:@"1"]) {
        roleString = NSLocalizedString(@"普通用户", nil);
    }
    
    UIButton* typeBtn = [UIButton z_svg_setImageName:@"icon_charactor_admin" fontSize:14 CornerRadius:4 backgroundColor:[UIColor colorWithHex:@"#FDC313"] titleColor:[UIColor whiteColor] title:roleString isbold:NO];
    typeBtn.width = 106;
    typeBtn.height = 24;
    typeBtn.x = nameLb.right + 8;
    typeBtn.centerY = nameLb.centerY;
    [self addSubview:typeBtn];
    
    //
    UIImageView* groupImgV = [[UIImageView alloc] initWithFrame:CGRectMake(nameLb.x, nameLb.bottom + 10, 18, 18)];
    groupImgV.image = [SVGKImage imageNamed:@"icon_group"].UIImage;
    [self addSubview:groupImgV];
    
    UILabel* groupLb = [UILabel z_frame:CGRectMake(groupImgV.right + SPW(5), 0, 36, 20)
                                   Text:CenterManager.shared.groupname
                               fontSize:14
                                  color:[UIColor colorWithHex:@"#808080"]
                                 isbold:NO
                        ];
    groupLb.centerY = groupImgV.centerY;
    [groupLb sizeToFit];
    [self addSubview:groupLb];
    //
    UIImageView* telImgV = [[UIImageView alloc] initWithFrame:CGRectMake(groupLb.right + SPW(32), nameLb.bottom + 10, 18, 18)];
    telImgV.image = [SVGKImage imageNamed:@"icon_login_phone"].UIImage;
    [self addSubview:telImgV];
    
    UILabel* telLb = [UILabel z_frame:CGRectMake(telImgV.right + SPW(5), 0, 90, 20)
                                 Text:CenterManager.shared.telephone
                             fontSize:14
                                color:[UIColor colorWithHex:@"#808080"]
                               isbold:NO
                      ];
    telLb.centerY = telImgV.centerY;
    [telLb sizeToFit];
    [self addSubview:telLb];
    
}


@end
