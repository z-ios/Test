//
//  XYMenuItem.h
//  XYMenu
//
//  Created by FireHsia on 2018/1/26.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYMenuItemDelegate <NSObject>

- (void)selectMenuItem:(NSInteger)itemTag imgTag:(NSInteger)imgTag;

@end
@interface XYMenuItem : UIView

- (instancetype)initWithIconName:(NSString *)iconName title:(NSString *)title;

- (instancetype)initWithIconName:(NSString *)iconName selecticonName:(NSString *)selecticonName title:(NSString *)title;

- (void)setUpViewsWithRect:(CGRect)rect idx:(NSInteger)idx;

- (void)nor_setUpViewsWithRect:(CGRect)rect idx:(NSInteger)idx;

@property (nonatomic, weak) id<XYMenuItemDelegate> delegate;

@end
