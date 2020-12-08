//
//  SmallLinkageDetailsView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallLinkageDetailsView.h"
#import "LinkageChannelSelectView.h"
#import "LinkageChannelSelectModel.h"
#import "SmallSelectLjView.h"

@interface SmallLinkageDetailsView ()<UITextFieldDelegate,DevicePtc>

@property (nonatomic, strong) UILabel* performch_t_lb;
@property (nonatomic, strong) UILabel* performlj_t_lb;
@property (nonatomic, strong) NumberCalculate *performlj_numberView;
@property (nonatomic, strong) UIView *performView;
@end
@implementation SmallLinkageDetailsView

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
    self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    self.layer.shadowOpacity = 10;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    
    [self addSubview:self.performch_t_lb];
    [self addSubview:self.perform_tf];
    [self addSubview:self.performlj_t_lb];
    [self addSubview:self.performlj_tf];
    [self addSubview:self.performlj_numberView];
    [self addSubview:self.performView];
    
    zWEAKSELF
    self.performlj_numberView.resultNumber = ^(NSString *number) {
           weakSelf.relationval = number;
       };
    
}

- (void)setLinkageList:(NSArray *)linkageList
{
    _linkageList = linkageList;
    if (linkageList.count > 0) {
        self.perform_tf.text = linkageList[0][@"channel_out"];
        self.performlj_tf.text = _linkageList[0][@"relation"];
        self.performlj_numberView.baseNum = [NSString stringWithFormat:@"%@",_linkageList[0][@"relationval"]];
        self.relationval = _linkageList[0][@"relationval"];
    }else{
        self.relationval = self.performlj_numberView.baseNum;
    }
}

#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _perform_tf) {
        
        [CenterNet.shared linkageChannelCompletionParm:_dict[@"device_id"] channelName:_dict[@"channelname"] completion:^(NSArray * _Nullable dataList) {
            NSArray* modelList = [NSArray yy_modelArrayWithClass:[LinkageChannelSelectModel class] json:dataList];
            LinkageChannelSelectView* eview = [[LinkageChannelSelectView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth - 32, 495)];
            eview.delegate = self;
            eview.modelDatas = modelList;
            NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
            nkView.contentView = eview;
            [nkView show];
        }];
        
        return NO;
    }else if (textField == _performlj_tf) {
        
        SmallSelectLjView* eview = [[SmallSelectLjView alloc] initWithFrame:CGRectMake(0, 0, zScreenWidth, 235)];
        eview.backgroundColor = [UIColor whiteColor];
        eview.dataStr = textField.text;
        NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
        nkView.contentView = eview;
        nkView.type  = NKAlertViewTypeBottom;
        nkView.hiddenWhenTapBG = YES;
        [nkView show];
        eview.selectSymbol = ^(NSString * _Nonnull symbolStr) {
            textField.text = symbolStr;
        };
        return NO;
    }
    return YES;
}

- (void)selectLinkageChannel:(NSString *)port channnelName:(NSString *)channnelName
{
    _perform_tf.text = channnelName;
}

#pragma mark -  lazy

- (UILabel *)performch_t_lb
{
    if (!_performch_t_lb) {
        _performch_t_lb = [UILabel z_frame:CGRectMake(20, 20, 200, 20)
                                      Text:NSLocalizedString(@"执行channel", nil)
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _performch_t_lb;
}

- (UITextField *)perform_tf
{
    if (!_perform_tf) {
        _perform_tf = [UITextField  z_frame:CGRectMake(self.performch_t_lb.x, self.performch_t_lb.bottom + 5, self.width - 40, 52)
                                             bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                                        cornerRadius:6
                                         borderWidth:0
                                         borderColor:nil
                                                text:nil
                                            textFont:[UIFont systemFontOfSize:17]
                                           textColor:[UIColor colorWithHex:@"#121212"]
                                         placeholder:NSLocalizedString(@"未设置", nil)
                                     placeholderFont:nil
                                    placeholderColor:nil
                                         leftImgName:nil
                                         leftImgSize:CGSizeZero
                                        rightImgName:@"icon_arrow_dropdown"
                                        rightImgSize:CGSizeMake(40, 24)
                                ];
        
        _perform_tf.delegate = self;
    }
    return _perform_tf;
}

- (UILabel *)performlj_t_lb
{
    if (!_performlj_t_lb) {
        _performlj_t_lb = [UILabel z_frame:CGRectMake(20, self.perform_tf.bottom + 10, 200, 20)
                                      Text:NSLocalizedString(@"逻辑", nil)
                                  fontSize:14
                                     color:[UIColor colorWithHex:@"#808080"]
                                    isbold:NO
                           ];
    }
    return _performlj_t_lb;
}

- (UITextField *)performlj_tf
{
    if (!_performlj_tf) {
        _performlj_tf = [UITextField  z_frame:CGRectMake(self.performch_t_lb.x, self.performlj_t_lb.bottom + 5, 96, 52)
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
        
        _performlj_tf.delegate = self;
        _performlj_tf.textAlignment = NSTextAlignmentCenter;
    }
    return _performlj_tf;
}

- (NumberCalculate *)performlj_numberView
{
    if (!_performlj_numberView) {
        _performlj_numberView = [[NumberCalculate alloc]initWithFrame:CGRectMake(self.performlj_tf.right + 15, self.performlj_tf.y, self.width - (self.performlj_tf.right + 15 + 20), 52)];
        _performlj_numberView.numborderColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
        _performlj_numberView.isShake = YES;
        _performlj_numberView.baseNum = @"1000";
        _performlj_numberView.layer.cornerRadius = 6;
    }
    return _performlj_numberView;
}

- (UIView *)performView
{
    if (!_performView) {
        _performView = [[UIView alloc] initWithFrame:CGRectMake(20, _performlj_tf.bottom + 25, self.width - 40, 98)];
        _performView.layer.cornerRadius = 8;
        _performView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        
        UILabel* t_lb = [UILabel z_frame:CGRectMake(20, 20, _performView.width - 40, 24) Text:NSLocalizedString(@"执行动作", nil) fontSize:17 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
        [_performView addSubview:t_lb];
        UILabel* lb = [UILabel z_frame:CGRectMake(20, t_lb.bottom + 6, _performView.width - 40, 28) Text:@"闭合（true）" fontSize:20 color:[UIColor colorWithHex:@"#121212"] isbold:NO];
        [_performView addSubview:lb];
    }
    return _performView;
}

@end
