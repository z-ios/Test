//
//  CustomView.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/13.
//  Copyright © 2020 apple. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@property (nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) UILabel* textLabel;
@property (nonatomic, assign) NSInteger idx;

@end
@implementation CustomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.cornerRadius = 12;
        self.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.75];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                       [self addSubview:self.activityIndicator];
                       [self addSubview:self.textLabel];
                   });
        
        self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1
               target:self
             selector:@selector(mainThreadTimerDidFire:)
             userInfo:nil
              repeats:YES
        dispatchQueue:dispatch_get_main_queue()];
        
        _idx = 10;


    }
    return self;
}

#pragma mark - MSWeakTimerDelegate

- (void)mainThreadTimerDidFire:(MSWeakTimer *)timer
{
    self.textLabel.text = [NSString stringWithFormat:@"%@%zds",NSLocalizedString(@"设备重连中...", nil),--_idx];
    if (_idx == 0) {// 第二次请求
        if (self.timeOutBlock) {
            self.timeOutBlock();
        }
        [timer invalidate];
    }

}

- (void)setTextStr:(NSString *)textStr
{
    _textStr = textStr;
    
//    [self addSubview:self.activityIndicator];
//    [self addSubview:self.textLabel];
 
}

- (CGSize)intrinsicContentSize {
    CGFloat height = 44;
    CGFloat width = 200;
    return CGSizeMake(width, height);
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [UILabel z_labelWithText:NSLocalizedString(@"设备重连中...", nil) fontSize:SPFont(14) color:[UIColor whiteColor] isbold:NO];
        _textLabel.height = self.height;
        _textLabel.x = self.activityIndicator.right + 10;
        _textLabel.centerY = self.height * 0.5;
        _textLabel.width = self.width - _textLabel.x - 20;
       _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UIActivityIndicatorView *)activityIndicator
{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        _activityIndicator.x = 20;
        _activityIndicator.centerY = self.height * 0.5;
        [_activityIndicator startAnimating];
        
    }
    
    return _activityIndicator;
}

@end
