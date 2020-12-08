//
//  LanguageView.h
//  Spider67
//
//  Created by 宾哥 on 2020/6/11.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 @protocol LeftBodyCellDelegate <NSObject>

 - (void)selectedItemButton:(NSInteger)index;

 @optional
 - (void)optionalFouction;
 @end
@interface LanguageView : UIView

//@property (nonatomic, copy) NSString* languageName;
@property (nonatomic, copy) void(^setSuccessLanguage)(NSString* name);

@end

NS_ASSUME_NONNULL_END
