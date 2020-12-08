//
//  FotaBottomView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FotaBottomView.h"
#import "FotaSelectTimeView.h"

@interface FotaBottomView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel* automatic_t_lb;
@property (nonatomic, strong) UISwitch* automatic_sw;
@property (nonatomic, strong) UILabel* note_t_lb;
@property (nonatomic, strong) UILabel* line_lb;
@property (nonatomic, strong) UILabel* timing_t_lb;
@property (nonatomic, strong) UITextField* timing_tf;

@end
@implementation FotaBottomView

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
    
    [self addSubview:self.automatic_t_lb];
    [self addSubview:self.automatic_sw];
    [self addSubview:self.note_t_lb];
    [self addSubview:self.line_lb];
    [self addSubview:self.timing_t_lb];
    [self addSubview:self.timing_tf];
    
}

- (void)saveConfigDataCompletion:(void (^ __nullable)(void))completion;
{
    NSDictionary* dict = @{
        @"device_id":_deviceId,
        @"autoupdate": [NSNumber numberWithBool:_automatic_sw.on],
        @"updatetime": @([_timing_tf.text intValue] - 1)
    };
    [CenterNet.shared saveFotaCompletionParm:dict completion:^(BOOL success) {
        completion();
    }];
    
}

- (void) change:(UISwitch*) sw{
    NSLog(@"状态 = %@", sw.on == YES ? @"开启" : @"关闭");
    if (sw.on) {
        _timing_tf.enabled = YES;
        _timing_tf.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    }else{
        _timing_tf.enabled = NO;
        _timing_tf.backgroundColor = [UIColor colorWithHex:@"#E9E9E9"];
    }
}

- (void)setFotaDict:(NSDictionary *)fotaDict
{
    _fotaDict = fotaDict;
    
    if ([_fotaDict[@"autoupdate"] intValue] == 1) {
        [_automatic_sw setOn:YES animated:YES];
        
    }else{
        [_automatic_sw setOn:NO animated:YES];
        _timing_tf.enabled = NO;
        _timing_tf.backgroundColor = [UIColor colorWithHex:@"#E9E9E9"];
    }
    
    _timing_tf.text = _fotaDict[@"updatetime"];

}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _timing_tf) {
        FotaSelectTimeView* eview = [[FotaSelectTimeView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 235)];
        eview.backgroundColor = [UIColor whiteColor];
        eview.dataStr = textField.text;
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
        nkView.contentView = eview;
        nkView.type  = NKAlertViewTypeBottom;
        nkView.hiddenWhenTapBG = YES;
        [nkView show];
        eview.selectFotaTime = ^(NSString * _Nonnull timeStr) {
            textField.text = timeStr;
        };
        return NO;
    }
    return YES;
}


#pragma mark - lazy

- (UILabel *)automatic_t_lb
{
    if (!_automatic_t_lb) {
        _automatic_t_lb = [UILabel z_frame:CGRectMake(35, 30, self.width*0.5, 24)
                                  Text:NSLocalizedString(@"自动升级", nil)
                              fontSize:17
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    }
    return _automatic_t_lb;
}



- (UISwitch *)automatic_sw
{
    if (!_automatic_sw) {
        _automatic_sw = [[UISwitch alloc] init];
        _automatic_sw.x = self.width - _automatic_sw.width - 35;
        _automatic_sw.centerY = self.automatic_t_lb.centerY;
        [_automatic_sw addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    }
    return _automatic_sw;
}

- (UILabel *)note_t_lb
{
    if (!_note_t_lb) {
        _note_t_lb = [UILabel z_frame:CGRectMake(35, self.automatic_t_lb.bottom + 10, self.width - 70, 40)
                                  Text:NSLocalizedString(@"每次定时自动检测FOTA并升级到最新版本", nil)
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    return _note_t_lb;
}

- (UILabel *)line_lb
{
    if (!_line_lb) {
        _line_lb = [[UILabel alloc] initWithFrame:CGRectMake(30, self.note_t_lb.bottom + 20, self.width - 60, 1)];
        _line_lb.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    }
    return _line_lb;
}

- (UILabel *)timing_t_lb
{
    if (!_timing_t_lb) {
        _timing_t_lb = [UILabel z_frame:CGRectMake(35, self.line_lb.bottom + 20, self.width - 70, 20)
                                  Text:NSLocalizedString(@"定时升级设置", nil)
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    return _timing_t_lb;
}

- (UITextField *)timing_tf
{
    if (!_timing_tf) {
        _timing_tf = [UITextField  z_frame:CGRectMake(self.timing_t_lb.x, self.timing_t_lb.bottom + 3, self.width - self.timing_t_lb.x*2, 48)
                                             bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                                        cornerRadius:6
                                         borderWidth:0
                                         borderColor:nil
                                                text:nil
                                            textFont:[UIFont systemFontOfSize:17]
                                           textColor:[UIColor colorWithHex:@"#121212"]
                                         placeholder:@""
                                     placeholderFont:nil
                                    placeholderColor:nil
                                         leftImgName:nil
                                         leftImgSize:CGSizeZero
                                        rightImgName:@"icon_arrow_dropdown"
                                        rightImgSize:CGSizeMake(40, 24)
                                ];
        
        _timing_tf.delegate = self;
        _timing_tf.textAlignment = NSTextAlignmentCenter;
    }
    return _timing_tf;
}

@end
