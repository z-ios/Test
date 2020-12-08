//
//  SendLinkageModel.h
//  Spider67
//
//  Created by 宾哥 on 2020/10/10.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SendLinkageModel : NSObject

@property (nonatomic, copy) NSString* channel_in;
@property (nonatomic, copy) NSString* channel_out;
@property (nonatomic, copy) NSString* relationval;
@property (nonatomic, copy) NSString* relation;
@property (nonatomic, copy) NSString* port_in;
@property (nonatomic, copy) NSString* port_out;
@property (nonatomic, copy) NSString* moduletype_in;
@property (nonatomic, copy) NSString* moduletype_out;
@property (nonatomic, copy) NSString* title_in;
@property (nonatomic, copy) NSString* title_out;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) BOOL isSelect;


@end

NS_ASSUME_NONNULL_END


//"id": 50,
//       "device_id": "5676ed1d-4ec1-48e3-80cb-71f938089031",
//       "channel_in": "module_0.channel_0",
//       "relation": "=",
//       "relationval": 0,
//       "channel_out": "module_1.channel_0",
//       "port_in": "P0 A",
//       "title_in": "title",
//       "modulename_in": "module_0",
//       "moduletype_in": "CH8_DUP_M12",
//       "port_out": "P4 A",
//       "title_out": "null",
//       "module_out": "module_1",
//       "moduletype_out": "CH8_DUP_M12"
