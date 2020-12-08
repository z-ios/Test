//
//  XieYiView.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/16.
//  Copyright © 2020 apple. All rights reserved.
//

#import "XieYiView.h"

@interface XieYiView ()

@property (nonatomic, strong) UIView *httpView;
@property (nonatomic, strong) UIView *httpsView;
@property (nonatomic, strong) UIImageView *httpImgV;
@property (nonatomic, strong) UIImageView *httpsImgV;
@property (nonatomic, strong) UILabel* httpLb;
@property (nonatomic, strong) UILabel* httpsLb;


@end
@implementation XieYiView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setupUI];
    }
    return self;
}

- (void)setXyHeight:(CGFloat)xyHeight
{
    _xyHeight = xyHeight;
    _httpView.height = xyHeight;
    _httpsView.height = xyHeight;
    _httpsLb.y = (xyHeight - 24) *0.5;
    _httpLb.y = (xyHeight - 24) *0.5;

}

- (void)setupUI{
    
    UILabel* xyLb = [UILabel z_frame:CGRectMake(0,0, SPW(100), SPH(20))
                                          Text:NSLocalizedString(@"协议", nil)
                                      fontSize:14
                                         color:[UIColor colorWithHex:@"#808080"]
                                        isbold:NO
                               ];
    [self addSubview:xyLb];
    
    
    UIView* httpV = [[UIView alloc] initWithFrame:CGRectMake(0, xyLb.bottom + 3, (self.width - SPW(16)) * 0.5, SPH(65))];
    httpV.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    httpV.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
    httpV.layer.borderWidth = 0.5;
    httpV.layer.cornerRadius = 4;
    [self addSubview:httpV];
    UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    httpV.tag = 1000;
    [httpV addGestureRecognizer:tap0];
    _httpView = httpV;
    
    
    UIView* httpsV = [[UIView alloc] initWithFrame:CGRectMake(httpV.right + SPW(16), httpV.y, httpV.width, httpV.height)];
    httpsV.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    httpsV.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    httpsV.layer.borderWidth = 0.5;
    httpsV.layer.cornerRadius = 4;
    [self addSubview:httpsV];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    httpsV.tag = 1001;
    [httpsV addGestureRecognizer:tap1];
    _httpsView = httpsV;
    
    
    UILabel* httpLb = [UILabel z_frame:CGRectMake((httpV.width - SPW(40))*0.5, (httpV.height - SPH(24)) * 0.5, SPW(40), SPH(24))
                                  Text:@"http"
                              fontSize:SPFont(17)
                                 color:[UIColor colorWithHex:@"#121212"]
                                isbold:NO
                       ];
    [httpV addSubview:httpLb];
    _httpLb = httpLb;
    
    UILabel* httpsLb = [UILabel z_frame:CGRectMake((httpV.width - SPW(40))*0.5, (httpV.height - SPH(24)) * 0.5, SPW(40), SPH(24))
                                     Text:@"https"
                                 fontSize:SPFont(17)
                                    color:[UIColor colorWithHex:@"#121212"]
                                   isbold:NO
                          ];
    [httpsV addSubview:httpsLb];
    _httpsLb = httpsLb;
    
    UIImageView* httpImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_server_highlight"]];
    httpImgV.frame = CGRectMake(httpV.width - SPH(18), 0, SPH(18), SPH(18));
    [httpV addSubview:httpImgV];
    _httpImgV = httpImgV;
    
    UIImageView* httpsImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_server_highlight"]];
    httpsImgV.frame = CGRectMake(httpsV.width - SPH(18), 0, SPH(18), SPH(18));
    [httpsV addSubview:httpsImgV];
    _httpsImgV = httpsImgV;
    _httpsImgV.hidden = YES;
    
    _xyStr = @"http";
}

- (void)tapView:(UITapGestureRecognizer *)sender{
    
    switch (sender.view.tag) {
        case 1000:
            _httpImgV.hidden = NO;
            _httpsImgV.hidden = YES;
            _httpView.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
            _httpsView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
            _xyStr = @"http";
            break;
        case 1001:
            _httpImgV.hidden = YES;
            _httpsImgV.hidden = NO;
            _httpsView.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
            _httpView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
            _xyStr = @"https";
            break;
            
        default:
            break;
    }
}

- (void)setXyStr:(NSString *)xyStr
{
    _xyStr = xyStr;
    
    if ([xyStr isEqualToString:@"http"]) {
        _httpImgV.hidden = NO;
        _httpsImgV.hidden = YES;
        _httpView.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
        _httpsView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    }else{
        _httpImgV.hidden = YES;
        _httpsImgV.hidden = NO;
        _httpsView.layer.borderColor = [UIColor colorWithHex:@"#26C464"].CGColor;
        _httpView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    }
    
}

@end
