//
//  BaseTableView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

#define k_ash_action_img [@"__action" hash]

- (void)layoutSubviews {

   [super layoutSubviews];

   if (@available(iOS 11.0, *)) {

       if (self.editing)

       for (UIView *swipeActionPullView in self.subviews)

       {

           if([swipeActionPullView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]){

               for (UIView *swipeActionStandardButton in swipeActionPullView.subviews) {

                   if ([swipeActionStandardButton isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {

                       for (UIImageView *imageView in swipeActionStandardButton.subviews) {

                           if ([imageView isKindOfClass:[UIImageView class]]) {

                               if ([imageView viewWithTag:k_ash_action_img]==nil) {

                                   UIImageView *addedImageView = [[UIImageView alloc] initWithFrame:imageView.bounds];

                                   addedImageView.tag = k_ash_action_img;

                                   addedImageView.image= [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

                                   [imageView addSubview:addedImageView];

                               }

                               break;

                           }

                       }

                   }

               }

           }

       }

   }

}


@end
