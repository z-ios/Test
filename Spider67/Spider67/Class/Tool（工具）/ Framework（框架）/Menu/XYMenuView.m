//
//  XYMenuView.m
//  XYMenu
//
//  Created by FireHsia on 2018/1/18.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "XYMenuView.h"
#import "XYMenuItem.h"

#define kXYMenuContentBackColor [UIColor colorWithWhite:1.0 alpha:1.0]
#define kXYMenuContentLineColor [UIColor colorWithWhite:0.7 alpha:1.0]
#define kItemBtnTag 1001
static const CGFloat kTriangleHeight = 8;

@interface XYMenuView()<XYMenuItemDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *imagesArr;
@property (nonatomic, strong) NSArray *titlesArr;
@property (nonatomic, assign) XYMenuType menuType;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, copy) ItemClickBlock itemClickBlock;

@end

@implementation XYMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _isDown = YES;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        self.contentView.frame = frame;
//        self.layer.shadowRadius = 1;
        self.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.17].CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowOffset = CGSizeMake(0, 0);
    }
    return self;
}

- (void)setImagesArr:(NSArray *)imagesArr titles:(NSArray *)titles withRect:(CGRect)rect withMenuType:(XYMenuType)menuType isDown:(BOOL)isDown withItemClickBlock:(ItemClickBlock)block
{
    if (isDown) _isDown = isDown;
    _isDown = isDown;
    _menuType = menuType;
    _imagesArr = [NSArray arrayWithArray:imagesArr];
    _titlesArr = [NSArray arrayWithArray:titles];
    [self setMenuItemsWithRect:(CGRect)rect MenuType:menuType];
    if (block) {
        _itemClickBlock = block;
    }
    [self setNeedsDisplay];
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat kContentWidth = self.bounds.size.width;
    CGFloat kContentHeight = self.bounds.size.height;
    CGFloat kContentMidX = CGRectGetMidX(self.bounds);
    CGFloat triangleX;
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    if (_isDown) {
        switch (_menuType) {
            case XYMenuLeftNormal:
            case XYMenuLeftNavBar:
            {
                triangleX = (kContentWidth / 4) - (kTriangleLength / 2) - 12;
            }
                break;
            case XYMenuRightNormal:
            case XYMenuRightNavBar:
            {
               
//                triangleX = kContentMidX + (kContentWidth / 3) - (kTriangleLength / 2);
                CGFloat flag = zScreenWidth - [[NSUserDefaults standardUserDefaults] floatForKey:@"navRightItemX"];
                
                triangleX = self.width - flag - (kTriangleLength / 2) - 10;
            }
                break;
            default:
                triangleX = kContentMidX - (kTriangleLength / 2);
                break;
        }
        
        [trianglePath moveToPoint:CGPointMake(triangleX, kTriangleHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + (kTriangleLength / 2), 0)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + kTriangleLength, kTriangleHeight)];
        
    }else {
        switch (_menuType) {
            case XYMenuLeftNormal:
            case XYMenuLeftNavBar:
            {
                triangleX = (kContentWidth / 4) - (kTriangleLength / 2);
            }
                break;
            case XYMenuRightNormal:
            case XYMenuRightNavBar:
            {
                triangleX = kContentMidX + (kContentWidth / 4) - (kTriangleLength / 2);
            }
                break;
            default:
                triangleX = kContentMidX - (kTriangleLength / 2);
                break;
        }
        [trianglePath moveToPoint:CGPointMake(triangleX, kContentHeight - kTriangleHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + (kTriangleLength / 2), kContentHeight)];
        [trianglePath addLineToPoint:CGPointMake(triangleX + kTriangleLength, kContentHeight - kTriangleHeight)];
    }
    
    [kXYMenuContentBackColor set];
    [trianglePath fill];
    
    if (_isDown) {
        UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, kTriangleHeight, self.bounds.size.width, self.bounds.size.height - kTriangleHeight) cornerRadius:10];
        [kXYMenuContentBackColor set];
        [radiusPath fill];
    }else {
        UIBezierPath *radiusPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - kTriangleHeight) cornerRadius:5];
        [kXYMenuContentBackColor set];
        [radiusPath fill];
    }
    
}

- (void)showContentView
{
//    self.contentView.hidden = NO;
    self.contentView.alpha = 1;
    self.contentView.frame = self.bounds;
}

- (void)hideContentView
{
//    self.contentView.hidden = YES;
    self.contentView.alpha = 0;
}

- (void)btnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (_itemClickBlock) {
        _itemClickBlock(sender.tag - 1000,sender.selected);
    }
}

- (void)selectMenuItem:(NSInteger)itemTag imgTag:(NSInteger)imgTag
{
    bool isDaoxu = imgTag == 100 ? YES : NO;
    if (_itemClickBlock) {
        _itemClickBlock(itemTag - 100,isDaoxu);
    }
}

#pragma mark --- 创建Items
- (void)setMenuItemsWithRect:(CGRect)rect MenuType:(XYMenuType)menuType
{
    
    NSArray *subViews = self.contentView.subviews;
    for (UIView *subV in subViews) {
        [subV removeFromSuperview];
    }
    CGFloat menuContentWidth = rect.size.width;
    CGFloat menuContentHeight = rect.size.height;
    NSInteger count = self.titlesArr.count;
    CGFloat kContentItemHeight = (menuContentHeight - kTriangleHeight) / count;
    
    if (menuType == XYMenuRightNormal) {
        NSArray* selectImages = @[@"icon_rank_name_fan",@"icon_rank_number_fan"];
        for (int i = 0; i < count; i++) {
            
            XYMenuItem* item = [[XYMenuItem alloc] initWithIconName:self.imagesArr[i] selecticonName:selectImages[i] title:self.titlesArr[i]];
            item.tag = i + 100;
            item.delegate = self;
            [self.contentView addSubview:item];
            [item setUpViewsWithRect:CGRectMake(0, (i * kContentItemHeight) + kTriangleHeight, menuContentWidth, kContentItemHeight) idx:i];
            
        }
    }else if (menuType == XYMenuRightNavBar) {
        for (int i = 0; i < count; i++) {
        
            XYMenuItem* item = [[XYMenuItem alloc] initWithIconName:self.imagesArr[i] title:self.titlesArr[i]];
            item.tag = i + 100;
            item.delegate = self;
            [self.contentView addSubview:item];
            [item nor_setUpViewsWithRect:CGRectMake(0, (i * kContentItemHeight) + kTriangleHeight, menuContentWidth, kContentItemHeight) idx:i];
            
        }
    }
}


- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = YES;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.autoresizesSubviews = YES;
    }
    return _contentView;
}

@end

