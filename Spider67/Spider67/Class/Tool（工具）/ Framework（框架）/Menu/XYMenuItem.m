//
//  XYMenuItem.m
//  XYMenu
//
//  Created by FireHsia on 2018/1/26.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "XYMenuItem.h"


@interface XYMenuItem ()

@property (nonatomic, strong) UIImageView *iconImage; // 图标icon
@property (nonatomic, strong) UILabel *titleLab; // title
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *seliconName;
@property (nonatomic, copy) NSString *title;

@end

@implementation XYMenuItem

- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _iconName = iconName;
        _title = title;
        // 添加手势
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(norhandleTap:)];
        [self addGestureRecognizer:tapRecognize];
    }
    return self;
}

- (instancetype)initWithIconName:(NSString *)iconName selecticonName:(NSString *)selecticonName title:(NSString *)title
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _iconName = iconName;
        _title = title;
        _seliconName = selecticonName;
        // 添加手势
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapRecognize];
    }
    return self;
}

-(void)handleTap:(UITapGestureRecognizer *)recognizer
{
    if (self.iconImage.tag == 100) {
        self.iconImage.image = [UIImage imageNamed:_seliconName];
        self.iconImage.tag = 101;
    }else{
        self.iconImage.image = [UIImage imageNamed:_iconName];
        self.iconImage.tag = 100;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectMenuItem:imgTag:)]) {
        [self.delegate selectMenuItem:recognizer.view.tag imgTag:self.iconImage.tag];
    }
    NSLog(@"---单击手势-------%ld--%ld",(long)recognizer.view.tag,self.iconImage.tag);
    
}

-(void)norhandleTap:(UITapGestureRecognizer *)recognizer
{
    if ([self.delegate respondsToSelector:@selector(selectMenuItem:imgTag:)]) {
        [self.delegate selectMenuItem:recognizer.view.tag imgTag:self.iconImage.tag];
    }
    NSLog(@"---单击手势-------%ld--%ld",(long)recognizer.view.tag,self.iconImage.tag);
    
}

- (void)setUpViewsWithRect:(CGRect)rect idx:(NSInteger)idx
{
    self.frame = rect;
    [self addSubview:self.iconImage];
    [self addSubview:self.titleLab];
    if (idx == 0) {
        self.iconImage.frame = CGRectMake(15, self.bounds.size.height*0.5 - 12 + 5, 24, 24);
        self.titleLab.frame = CGRectMake(self.iconImage.right + 5, self.bounds.size.height*0.5 - 10 + 5, self.width -(self.iconImage.right + 5) - 15 , 20);
    }else{
        self.iconImage.frame = CGRectMake(15, self.bounds.size.height*0.5 - 12 - 5, 24, 24);
        self.titleLab.frame = CGRectMake(self.iconImage.right + 5, self.bounds.size.height*0.5 - 10 - 5, self.width -(self.iconImage.right + 5) - 15 , 20);
    }
    
}

- (void)nor_setUpViewsWithRect:(CGRect)rect idx:(NSInteger)idx
{
    self.frame = rect;
    [self addSubview:self.iconImage];
    [self addSubview:self.titleLab];
    self.iconImage.frame = CGRectMake(15, self.bounds.size.height*0.5 - 12, 24, 24);
    self.titleLab.frame = CGRectMake(self.iconImage.right + 5, self.bounds.size.height*0.5 - 10, self.width -(self.iconImage.right + 5) - 15 , 20);
}

- (UIImageView *)iconImage
{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_iconName]];
        _iconImage.tag = 100;
    }
    return _iconImage;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor colorWithHex:@"#121212"];
        _titleLab.text = _title;
        _titleLab.font = [UIFont systemFontOfSize:14.0];
        _titleLab.backgroundColor = [UIColor clearColor];
    }
    return _titleLab;
}

@end
