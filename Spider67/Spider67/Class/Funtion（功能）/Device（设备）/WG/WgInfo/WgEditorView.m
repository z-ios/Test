//
//  WgEditorView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/18.
//  Copyright © 2020 apple. All rights reserved.
//

#import "WgEditorView.h"
#import "WgContentView.h"
#import "EditorAlertView.h"
#import "ModulesListModel.h"

@interface WgEditorView ()

@property (nonatomic, strong) UIView* topView;
@property (nonatomic, strong) WgContentView* contentView;
@property (nonatomic, strong) UIButton* cancelBtn;
@property (nonatomic, strong) UIButton* editorBtn;

@end
@implementation WgEditorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor  clearColor];
    [self addSubview:self.topView];
    [self addSubview:self.contentView];
    [self.topView addSubview:self.cancelBtn];
    [self.topView addSubview:self.editorBtn];
    self.topView.y = -88;
    self.contentView.y = self.height;
    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topView.y = 0;
        self.contentView.y = 88;
    } completion:nil];

}

- (void)setModel0:(ModulesListModel *)model0
{
    _model0 = model0;
    self.contentView.model0 = _model0;
}

- (void)setModel1:(ModulesListModel *)model1
{
    _model1 = model1;
    self.contentView.model1 = _model1;
}

- (void)setDeviceDict:(NSDictionary *)deviceDict
{
    _deviceDict = deviceDict;
    self.contentView.deviceDict = _deviceDict;
}

- (void)cancelBtnClick
{
    [UIView animateWithDuration:0.45f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.topView.y = -88;
        self.contentView.y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

- (void)editorBtnClick
{
    EditorAlertView* eview = [[EditorAlertView alloc] initWithFrame:CGRectMake(0, 0, self.width - 32, 354)];
    eview.dataDict= _deviceDict;
    NKAlertView* nkView = [[NKAlertView alloc] initWithAddView:zAppWindow];
    nkView.contentView = eview;
    [nkView show];
    eview.editorSuccess = ^(NSString * _Nonnull devName, NSString * _Nonnull groupName) {
        NSMutableDictionary*dictM = [NSMutableDictionary dictionaryWithDictionary:self.deviceDict];
        dictM[@"groupname"] = groupName;
        dictM[@"devicename"] = devName;
        self.deviceDict = dictM.copy;
    };
    
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 88)];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.12].CGColor;
        _topView.layer.shadowOpacity = 14;
        _topView.layer.shadowOffset = CGSizeMake(0, 0);
    }
    
    return _topView;
}

- (WgContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[WgContentView alloc] initWithFrame:CGRectMake(0, 88, self.width, self.height - 88)];
        _contentView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];;
    }
    
    return _contentView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, self.topView.height - 24 - 10, 24, 24)];
        [_cancelBtn setImage:[SVGKImage imageNamed:@"icon_arrow_down"].UIImage forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)editorBtn
{
    if (!_editorBtn) {
        _editorBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.topView.width - 20 - 30, self.topView.height - 20 - 10, 30, 20)];
        [_editorBtn setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
        [_editorBtn setTitleColor:[UIColor colorWithHex:@"#4D8CEB"] forState:UIControlStateNormal];
        _editorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_editorBtn addTarget:self action:@selector(editorBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editorBtn;
}


@end
