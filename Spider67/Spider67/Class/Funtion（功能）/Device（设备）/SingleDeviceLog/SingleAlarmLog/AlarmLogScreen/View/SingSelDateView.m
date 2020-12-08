//
//  SingSelDateView.m
//  Spider67
//
//  Created by 宾哥 on 2020/10/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SingSelDateView.h"
#import "CZHDatePickerView.h"

@interface SingSelDateView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel* tl_lb;
@property (nonatomic, strong) UIView* dateV;
@property (nonatomic, strong) UIImageView* imgV;
@property (nonatomic, strong) UILabel* lb;

@end
@implementation SingSelDateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.tl_lb];
    [self addSubview:self.dateV];
    [self.dateV addSubview:self.imgV];
    [self.dateV addSubview:self.sdate_tf];
    [self.dateV addSubview:self.lb];
    [self.dateV addSubview:self.edate_tf];
}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _sdate_tf) {
        [CZHDatePickerView sharePickerViewWithCurrentDate:@"" DateBlock:^(NSString *dateString) {
            textField.text = dateString;
            if (self.edate_tf.text.length > 0) {
                NSInteger ss = [NSObject compareDate:self.sdate_tf.text withDate:self.edate_tf.text];
                if (ss == 1) {
                    textField.text = @"";
                    [MBhud showText:NSLocalizedString(@"开始时间不能大于结束时间", nil) addView:zAppWindow];
                }
            }
        }];
        return NO;
    }else if (textField == _edate_tf) {
        [CZHDatePickerView sharePickerViewWithCurrentDate:@"" DateBlock:^(NSString *dateString) {
            textField.text = dateString;
            if (self.sdate_tf.text.length > 0) {
                NSInteger ss = [NSObject compareDate:self.sdate_tf.text withDate:self.edate_tf.text];
                if (ss == 1) {
                    textField.text = @"";
                    [MBhud showText:NSLocalizedString(@"开始时间不能大于结束时间", nil) addView:zAppWindow];
                }
            }
        }];
        return NO;
    }
    return YES;
}

#pragma mark - lazy

- (UILabel *)tl_lb
{
    if (!_tl_lb) {
        _tl_lb = [UILabel z_frame:CGRectMake(0, 0, 100, 20) Text:NSLocalizedString(@"时间段", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    
    return _tl_lb;
}

- (UIView *)dateV
{
    if (!_dateV) {
        _dateV = [[UIView alloc] initWithFrame:CGRectMake(0, self.tl_lb.bottom + 5, self.width, 52)];
        _dateV.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _dateV.layer.cornerRadius = 6;
    }
    return _dateV;
}

- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (self.dateV.height - 24)*0.5, 24, 24)];
        _imgV.image = [SVGKImage imageNamed:@"icon_calendar"].UIImage;
    }
    
    return _imgV;
}

- (UITextField *)sdate_tf
{
    if (!_sdate_tf) {
        _sdate_tf = [[UITextField alloc] initWithFrame:CGRectMake(self.imgV.right + 10, 0, self.dateV.width*0.35, self.dateV.height)];
        _sdate_tf.placeholder = NSLocalizedString(@"开始时间", nil);
        _sdate_tf.font = [UIFont systemFontOfSize:14];
        _sdate_tf.delegate = self;
    }
    return _sdate_tf;
}

- (UILabel *)lb
{
    if (!_lb) {
        _lb = [UILabel z_frame:CGRectMake(self.sdate_tf.right + 10, 0, 14, self.dateV.height) Text:@"至" fontSize:14 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
    }
    
    return _lb;
}

- (UITextField *)edate_tf
{
    if (!_edate_tf) {
        _edate_tf = [[UITextField alloc] initWithFrame:CGRectMake(self.lb.right + 15, 0, self.dateV.width*0.35, self.dateV.height)];
        _edate_tf.placeholder = NSLocalizedString(@"结束时间", nil);
        _edate_tf.delegate = self;
        _edate_tf.font = [UIFont systemFontOfSize:14];
    }
    return _edate_tf;
}

@end
