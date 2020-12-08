//
//  SelectWarnItemView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/22.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SelectWarnItemView.h"
#import "WarnItemBtn.h"

@interface SelectWarnItemView ()

////滚动视图
@property (strong,nonatomic) UIScrollView *scroller;
////最后一个按钮的frame
@property (assign,nonatomic) CGRect frameRect;
/**
 按钮高度，默认 30
 */
@property (assign, nonatomic) CGFloat butHeight;

/**
 两按钮左右之间的距离 默认 为 10
 */
@property (assign, nonatomic) CGFloat maragin_x;
/**
 文字字体
 */
@property (strong, nonatomic) UIFont * font;
/**
 文字默认颜色
 */
@property (strong, nonatomic) UIColor * contentNorColor;
/**
 两按钮上下之间的距离 默认为 10
 */
@property (assign, nonatomic) CGFloat maragin_y;
/**
 默认颜色
 */
@property (strong, nonatomic) UIColor * bgColor;

/**
 圆角 默认 radius = 6
 */
@property (assign, nonatomic) CGFloat radius;

@property (nonatomic, strong) NSMutableArray* btns;

@end
@implementation SelectWarnItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)setWarnItems:(NSArray *)warnItems
{
    _warnItems = warnItems;
    
    [self setupUI];
}

- (void)setupUI{
    
    _butHeight = 42;
    _maragin_x = 10;
    _font = [UIFont systemFontOfSize:14];
    _contentNorColor = [UIColor colorWithHex:@"#3F4248"];
    _maragin_y = 10;
    _bgColor = [UIColor colorWithHex:@"#F6F8FA"];
    _radius = 21;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.scroller];

    self.frameRect = [self setSignView:self.warnItems];
    //设置滚动视图的滚动范围
    self.scroller.contentSize = CGSizeMake(0, self.frameRect.size.height + self.frameRect.origin.y + 10);
}



- (void)butClick:(UIButton *)sender
{
    [_btns enumerateObjectsUsingBlock:^(WarnItemBtn*  _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (btn == sender) {
            btn.backgroundColor = [UIColor colorWithHex:@"#26C464"];
            btn.selectImgV.image = [SVGKImage imageNamed:@"icon_set_allert_check"].UIImage;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(selectWarnColor:value:)]) {
                [self.delegate selectWarnColor:btn.colorStr value:btn.titleLabel.text];
            }
        }else{
            btn.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
            btn.selectImgV.image = [SVGKImage imageNamed:@"icon_add"].UIImage;
            [btn setTitleColor:[UIColor colorWithHex:@"#3F4248"] forState:UIControlStateNormal];
        }
    }];
}

- (CGRect)setSignView:(NSArray *)dataArr{
    
    CGRect rect = CGRectZero;
    CGFloat butHeight = _butHeight;
    CGFloat but_totalHeight = 0;
    CGFloat butorignX = _maragin_x;
    CGFloat alineButWidth = 0;
    CGRect current_rect;
    for (NSInteger i = 0; i < dataArr.count; ++i) {
        
        CGSize contentSize = [NSObject sizeWidthWidth:dataArr[i][@"tagname"] font:_font maxHeight:butHeight];
        //创建按钮
        WarnItemBtn *but = [WarnItemBtn new];
        [but setTitleColor:_contentNorColor forState:UIControlStateNormal];
        [but setTitle:dataArr[i][@"tagname"] forState:UIControlStateNormal];
        but.titleLabel.font = _font;
        [self.scroller addSubview:but];
        
        CGFloat butWidth = contentSize.width + 99;
        butorignX = alineButWidth + _maragin_x;
        alineButWidth = _maragin_x + butWidth + alineButWidth;
        if (alineButWidth >= self.width) {
            butorignX = _maragin_x;
            alineButWidth = butorignX + butWidth;
            but_totalHeight = current_rect.size.height + current_rect.origin.y + _maragin_y;
        }
        
        but.frame = CGRectMake(butorignX, but_totalHeight, butWidth, butHeight);
        current_rect = but.frame;
        but.backgroundColor = _bgColor;
        but.tag = 100 + i + 1;
        //按钮样式
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        but.layer.cornerRadius = _radius;
        but.layer.masksToBounds = YES;
        
        but.colorView.frame = CGRectMake(20, (but.height - 20)*0.5, 20, 20);
        but.colorView.backgroundColor = [UIColor colorWithHex:dataArr[i][@"tagcolor"]];
        but.selectImgV.frame = CGRectMake(but.width - 24 - 15, (but.height - 24)*0.5, 24, 24);
        but.colorStr = dataArr[i][@"tagcolor"];
        
        if (i == dataArr.count - 1) {
            //当最后一个按钮时，返回坐标
            rect = but.frame;
        }
        
        [self.btns addObject:but];
    }
    
    return rect;
}

#pragma mark---lazy

- (UIScrollView *)scroller{
    if (!_scroller) {
        _scroller =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scroller.showsVerticalScrollIndicator = NO;
        _scroller.showsHorizontalScrollIndicator = NO;
    }
    return _scroller;
}


@end
