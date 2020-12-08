//
//  SmallFormulaModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/9/25.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmallFormulaModel : NSObject

@property (nonatomic, copy) NSString* formulaname;
@property (nonatomic, copy) NSString* unit;
@property (nonatomic, copy) NSString* formula;
@property (nonatomic, copy) NSString* createtime;
@property (nonatomic, assign) BOOL isSelected;

@end

NS_ASSUME_NONNULL_END
