//
//  FinishRegisterCollectionViewCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/8/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "FinishRegisterCollectionViewCell.h"
#import "BtnView.h"
#import "FinishRegisterView.h"

@interface FinishRegisterCollectionViewCell ()

@property (nonatomic, strong) BtnView* btnV;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) FinishRegisterView* finishRgView;
@property (nonatomic, strong) UILabel* titleLb;
@property (nonatomic, strong) UILabel* subtitleLb;
@property (nonatomic, strong) UIImageView* imgV;

@end
@implementation FinishRegisterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupUI];
        });
    }
    return self;
}

#pragma mark - 页面显示触发代理方法
- (void)collectViewCellWillAppearDictData:(NSDictionary *)dictData
{
    
    _finishRgView.nameLb.text = dictData[@"devieceName"];
    _finishRgView.biaoshimaLb.text = dictData[@"biaoshimaStr"];
    _finishRgView.groupLb.text = dictData[@"groupName"];
    _finishRgView.iotHubName.text = dictData[@"iotHubName"];
    _finishRgView.iotHubIp.text = dictData[@"iothubIp"];
    _finishRgView.xinghaoLb.text = dictData[@"xinghaoStr"];
    _finishRgView.thingIdLb.text = dictData[@"thingId"];
    
    NSString* registerId = dictData[@"registerId"];
    if (registerId.length == 0) {
        _btnV.typeBtnStr = @"取消注册";
        _titleLb.textColor = [UIColor colorWithHex:@"#F1544F"];
        _titleLb.text = NSLocalizedString(@"注册失败", nil);
        _imgV.image = [SVGKImage imageNamed:@"icon_dr_process_fail"].UIImage;
        
        NSDictionary* dict =   dictData[@"note"];
        if ([[NSBundle currentLanguage] isEqualToString:@"zh-Hans"]) {
            self.subtitleLb.text = dict[@"message_cn"];
        }else{
            self.subtitleLb.text = dict[@"message_en"];
        }
        
        if ([self.delegate respondsToSelector:@selector(iotHubcheckFail)]) {
            [self.delegate iotHubcheckFail];
        }
    }else{
        _btnV.typeBtnStr = @"完成注册";
        _finishRgView.regIdLb.text = dictData[@"registerId"];
        [_finishRgView.regIdLb sizeToFit];
    }
    
}

- (void)setupUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    if (IS_IPHONE_Xx) {
        self.scrollView.contentSize = CGSizeMake(0, SPH(780));
    }else{
        self.scrollView.contentSize = CGSizeMake(0, SPH(900));
    }
    
    [self.scrollView addSubview:self.titleLb];
    [self.scrollView addSubview:self.imgV];
    [self.scrollView addSubview:self.subtitleLb];
    [self.scrollView addSubview:self.finishRgView];
    [self addSubview:self.btnV];
    
}


- (void)stepClick
{
    if ([self.delegate respondsToSelector:@selector(stepClick)]) {
        [self.delegate stepClick];
    }
}

- (void)nextClick
{
    if ([self.delegate respondsToSelector:@selector(nextClick)]) {
        [self.delegate nextClick];
    }
    
}

- (void)cancelClick
{
    if ([self.delegate respondsToSelector:@selector(cancelClick)]) {
        [self.delegate cancelClick];
    }
}
#pragma mark - 控件懒加载

- (BtnView *)btnV
{
    if (!_btnV) {
        _btnV = [[BtnView alloc] initWithFrame:CGRectMake(SPW(16), self.height - SPH(44) - SPH(52), self.width - SPW(16)*2, SPH(52))];
        _btnV.delegate = self;
        _btnV.typeBtnStr = @"两个按钮可点击";
    }
    
    return _btnV;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [UILabel z_frame:CGRectMake(25, SPH(30), self.width - 32, SPH(33)) Text:NSLocalizedString(@"注册完成", nil) fontSize:24 color:[UIColor colorWithHex:@"#121212"] isbold:YES];
    }
    return _titleLb;
}
    
- (UIImageView *)imgV
{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(_titleLb.right + 10, 0, 24, 24)];
        _imgV.centerY = _titleLb.centerY;
        _imgV.image = [SVGKImage imageNamed:@"icon_check"].UIImage;
    }
    
    return _imgV;
}

- (UILabel *)subtitleLb
{
    if (!_subtitleLb) {
        _subtitleLb = [UILabel z_frame:CGRectMake(25,_titleLb.bottom + SPH(8), self.width - 32, SPH(20)) Text:NSLocalizedString(@"该设备已成功注册", nil) fontSize:14 color:[UIColor colorWithHex:@"#808080"] isbold:NO];
    }
    return _subtitleLb;
}

- (FinishRegisterView *)finishRgView
{
    if (!_finishRgView) {
        _finishRgView = [[FinishRegisterView alloc] initWithFrame:CGRectMake(25, _subtitleLb.bottom + 25, self.width - 50, 536)];
    }
    
    return _finishRgView;
}

@end
