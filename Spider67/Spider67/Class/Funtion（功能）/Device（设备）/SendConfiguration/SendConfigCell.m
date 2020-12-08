//
//  SendConfigCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/30.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SendConfigCell.h"
#import "SendConfigChildModel.h"

@interface SendConfigCell ()

@property (nonatomic, strong) UIView* backView;
@property (nonatomic, strong) UILabel* pab_lb;
@property (nonatomic, strong) UILabel* type_lb;
@property (nonatomic, strong) UILabel* channel_lb;
@property (nonatomic, strong) UILabel* title_lb;

@end
@implementation SendConfigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupUI];
        });
        
    }
    
    return self;
}

- (void)setModel:(SendConfigChildModel *)model
{
    _model = model;
    NSArray *array = [model.channelname componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pab_lb.text = model.port;
        self.type_lb.text = model.channeltype;
        self.channel_lb.text = array[1];
        self.title_lb.text = model.channeltitle;
    });
    
    
}


- (void)setupUI
{
    
    [self addSubview:self.backView];
    [self.backView addSubview:self.pab_lb];
    [self.backView addSubview:self.type_lb];
    [self.backView addSubview:self.channel_lb];
    [self.backView addSubview:self.title_lb];
   
    
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, self.width - 50, 70)];
        _backView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
        _backView.layer.cornerRadius = 8;
    }
    return _backView;
}

- (UILabel *)pab_lb
{
    if (!_pab_lb) {
        _pab_lb = [UILabel z_frame:CGRectMake(15, 13, 60, 20)
                               Text:@"P1"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#121212"]
                             isbold:NO
                    ];
    }
    return _pab_lb;
}

- (UILabel *)type_lb
{
    if (!_type_lb) {
        _type_lb = [UILabel z_frame:CGRectMake(self.backView.width - 115, 13, 100, 20)
                               Text:@"AN_0_20mA"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#26C464"]
                             isbold:NO
                    ];
        _type_lb.textAlignment = NSTextAlignmentRight;
    }
    return _type_lb;
}

- (UILabel *)channel_lb
{
    if (!_channel_lb) {
        _channel_lb = [UILabel z_frame:CGRectMake(15, self.pab_lb.bottom + 5, 100, 20)
                               Text:@"channel_0"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
    }
    return _channel_lb;
}

- (UILabel *)title_lb
{
    if (!_title_lb) {
        _title_lb = [UILabel z_frame:CGRectMake(self.backView.width - 115, self.pab_lb.bottom + 5, 100, 20)
                               Text:@"channel_0"
                           fontSize:14
                              color:[UIColor colorWithHex:@"#808080"]
                             isbold:NO
                    ];
        _title_lb.textAlignment = NSTextAlignmentRight;
    }
    return _title_lb;
}


@end
