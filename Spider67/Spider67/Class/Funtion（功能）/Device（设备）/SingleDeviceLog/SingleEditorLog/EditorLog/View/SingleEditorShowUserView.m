//
//  SingleEditorShowUserView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingleEditorShowUserView.h"

@interface SingleEditorShowUserView ()

@property (nonatomic, strong) UIImageView* userImgV;
@property (nonatomic, strong) UILabel* user_lb;
@property (nonatomic, strong) UIImageView* dateImgV;
@property (nonatomic, strong) UILabel* date_lb;

@end
@implementation SingleEditorShowUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor colorWithHex:@"#4D8CEB"];
    self.layer.cornerRadius = 8;
    
    [self addSubview:self.userImgV];
    [self addSubview:self.user_lb];
    [self addSubview:self.dateImgV];
    [self addSubview:self.date_lb];
    
}

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    
    self.user_lb.text = _userName;
    self.date_lb.text = [NSObject getTimeStrWithString:_creatDate form:@"yyyy-MM-dd'T'HH:mm:ss"];
}

- (UIImageView *)userImgV
{
    if (!_userImgV) {
        _userImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.height - 24)*0.5, 24, 24)];
        _userImgV.image = [SVGKImage imageNamed:@"icon_people"].UIImage;
    }
    return _userImgV;
}

- (UILabel *)user_lb
{
    if (!_user_lb) {
        _user_lb = [UILabel z_frame:CGRectMake(self.userImgV.right + 5, 0, self.width*0.5 - 49, self.height)
                               Text:@"--"
                           fontSize:14
                              color:[UIColor whiteColor]
                             isbold:NO
                    ];
        _date_lb.numberOfLines = 2;
    }
    return _user_lb;
}

- (UIImageView *)dateImgV
{
    if (!_dateImgV) {
        _dateImgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.width*0.5, (self.height - 24)*0.5, 24, 24)];
        _dateImgV.image = [SVGKImage imageNamed:@"icon_information_time"].UIImage;
    }
    return _dateImgV;
}

- (UILabel *)date_lb
{
    if (!_date_lb) {
        _date_lb = [UILabel z_frame:CGRectMake(self.dateImgV.right + 5, 0, self.width*0.5 - 49, self.height)
                               Text:@"--"
                           fontSize:14
                              color:[UIColor whiteColor]
                             isbold:NO
                    ];
        _date_lb.numberOfLines = 2;
    }
    return _date_lb;
}


@end
