//
//  CustomGifHeader.m
//  Spider67
//
//  Created by 宾哥 on 2020/7/28.
//  Copyright © 2020 apple. All rights reserved.
//

#import "CustomGifHeader.h"

@implementation CustomGifHeader

#pragma mark - 实现父类的方法
- (void)prepare {
    [super prepare];
    
    NSArray* imageArr = [self processingGIFPictures:@"gif_refresh"];
    
    //GIF数据
    NSArray * idleImages = @[imageArr[0]];
    NSArray * refreshingImages = imageArr;
    //普通状态
    [self setImages:idleImages forState:MJRefreshStateIdle];
    //即将刷新状态
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    //正在刷新状态
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    self.gifView.backgroundColor = [UIColor redColor];
}

- (void)placeSubviews {
    [super placeSubviews];
    //隐藏状态显示文字
//    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
}
- (NSArray *)processingGIFPictures:(NSString *)name
{
//获取Gif文件
NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource: name withExtension:@"gif"];

//获取Gif图的原数据
CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);

//获取Gif图有多少帧
size_t gifcount = CGImageSourceGetCount(gifSource);


NSMutableArray *images = [[NSMutableArray alloc] init];


for (NSInteger i = 0; i < gifcount; i++) {
        
        //由数据源gifSource生成一张CGImageRef类型的图片
        
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        [images addObject:image];
        CGImageRelease(imageRef);
    }
//得到图片数组
    return images;
}

@end
