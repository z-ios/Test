//
//  FotaTopView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FotaTopView.h"

@interface FotaTopView ()

@property (nonatomic, strong) UILabel* current_t_lb;
@property (nonatomic, strong) UILabel* current_lb;
@property (nonatomic, strong) UILabel* line_lb;
@property (nonatomic, strong) UILabel* nearly_t_lb;
@property (nonatomic, strong) UILabel* nearly_lb;
@property (nonatomic, strong) UIButton* upgrade_btn;
@property (nonatomic, strong) UIImageView* imgV;

@end
@implementation FotaTopView

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
    self.layer.cornerRadius = 12;
    
    [self addSubview:self.current_t_lb];
    [self addSubview:self.current_lb];
    [self addSubview:self.line_lb];
    [self addSubview:self.nearly_t_lb];
    [self addSubview:self.nearly_lb];
    [self addSubview:self.upgrade_btn];
    [self.nearly_t_lb addSubview:self.imgV];
    
}

- (void)setFotaDict:(NSDictionary *)fotaDict
{
    _fotaDict = fotaDict;
    
    if ([_fotaDict[@"firmware"] isEqualToString:_fotaDict[@"latestversion"]]) {
        self.height = 148;
        self.upgrade_btn.hidden = YES;
        self.imgV.hidden = YES;
    }
    _current_lb.text =  _fotaDict[@"firmware"];
    _nearly_lb.text =  _fotaDict[@"latestversion"];

    
}

- (void)upgrade_btnClick
{
    
    UIAlertController *action = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"是否马上手动升级到最新版本？", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertT = [UIAlertAction actionWithTitle:NSLocalizedString(@"下次再说", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *alertF = [UIAlertAction actionWithTitle:NSLocalizedString(@"马上升级", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        [CenterNet.shared orderFotaCompletionParm:self.deviceId completion:nil];
    }];
    [alertF setValue:[UIColor colorWithHex:@"#26C464"] forKey:@"titleTextColor"];
    [alertT setValue:[UIColor colorWithHex:@"#808080"] forKey:@"titleTextColor"];
    [action addAction:alertT];
    [action addAction:alertF];
    
     [zAppWindow.rootViewController presentViewController:action animated:YES completion:nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//    });
    
    
    
}

- (UILabel *)current_t_lb
{
    if (!_current_t_lb) {
        _current_t_lb = [UILabel z_frame:CGRectMake(35, 30, self.width*0.5, 24)
                                  Text:NSLocalizedString(@"当前版本", nil)
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    }
    return _current_t_lb;
}

- (UILabel *)current_lb
{
    if (!_current_lb) {
        _current_lb = [UILabel z_frame:CGRectMake(self.width - 35 -self.width*0.5 , 30, self.width*0.5, 24)
                                  Text:@"v 1.3.4"
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#26C464"]
                                isbold:YES
                       ];
        _current_lb.textAlignment = NSTextAlignmentRight;
    }
    return _current_lb;
}

- (UILabel *)line_lb
{
    if (!_line_lb) {
        _line_lb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.current_t_lb.bottom + 20, self.width - 60, 1)];
        _line_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _line_lb;
}

- (UILabel *)nearly_t_lb
{
    if (!_nearly_t_lb) {
        _nearly_t_lb = [UILabel z_frame:CGRectMake(_current_t_lb.x, _line_lb.bottom + 20, 0, 24)
                                  Text:NSLocalizedString(@"最新版本", nil)
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
        [_nearly_t_lb sizeToFit];
    }
    return _nearly_t_lb;
}

- (UILabel *)nearly_lb
{
    if (!_nearly_lb) {
        _nearly_lb = [UILabel z_frame:CGRectMake(self.width - 35 -self.width*0.5 , _nearly_t_lb.y, self.width*0.5, 24)
                                  Text:@"v 2.3.4"
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#26C464"]
                                isbold:YES
                       ];
        _nearly_lb.textAlignment = NSTextAlignmentRight;
    }
    return _nearly_lb;
}

- (UIButton *)upgrade_btn
{
    if (!_upgrade_btn) {
        _upgrade_btn = [UIButton z_frame:CGRectMake((self.width - 84)*0.5, self.height - 33 - 15, 84, 33)
                                fontSize:14
                            cornerRadius:6
                         backgroundColor:[UIColor colorWithHex:@"#26C464" alpha:0.11]
                              titleColor:[UIColor colorWithHex:@"#26C464"]
                                   title:NSLocalizedString(@"马上升级", nil)
                                  isbold:NO
                                  Target:self
                                  action:@selector(upgrade_btnClick)
                        ];
        
        CGSize sizeNew = [_upgrade_btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _upgrade_btn.width = sizeNew.width + 20;
    }
    
    return _upgrade_btn;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(self.nearly_t_lb.width + 7, 0, 32, 15)];
        _imgV.image = [SVGKImage imageNamed:@"icon_new_label"].UIImage;
    }
    return _imgV;
}

@end
