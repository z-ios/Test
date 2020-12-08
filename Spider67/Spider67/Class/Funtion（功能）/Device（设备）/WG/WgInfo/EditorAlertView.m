//
//  EditorAlertView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "EditorAlertView.h"

@interface EditorAlertView ()<UITextFieldDelegate,LDYSelectivityAlertViewDelegate>

@property (nonatomic,strong) UILabel* t_lb;
@property (nonatomic,strong) UILabel* name_t_lb;
@property (nonatomic,strong) UILabel* group_t_lb;

@property (nonatomic,strong) UITextField* name_tf;
@property (nonatomic,strong) UITextField* group_tf;

@property (nonatomic,strong) UIButton* sureBtn;
@property (nonatomic,strong) UIButton* cancelBtn;


@property (nonatomic, strong) NSMutableArray* groupList;
@property (nonatomic, copy) NSString* group_id;


@end
@implementation EditorAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)groupList
{
    if (!_groupList) {
        _groupList = [NSMutableArray array];
    }
    return _groupList;
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    self.name_tf.text = _dataDict[@"devicename"];
    self.group_tf.text = _dataDict[@"groupname"];
    _group_id = _dataDict[@"group_id"];
}

- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 18;
    self.layer.masksToBounds = YES;
    [self addSubview:self.t_lb];
    [self addSubview:self.name_t_lb];
    [self addSubview:self.name_tf];
    [self addSubview:self.group_t_lb];
    [self addSubview:self.group_tf];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancelBtn];
}

- (void)sureClick
{
    NSDictionary* dict = @{
        @"id": _dataDict[@"id"],
        @"devicename": self.name_tf.text,
        @"group_id": self.group_id,
        @"remarks": @""
    };
    [CenterNet.shared DeviceGroupParm:dict completion:^(BOOL success) {
        if (success) {
            if (self.editorSuccess) {
                self.editorSuccess(self.name_tf.text, self.group_tf.text);
            }
            
            NKAlertView *alertView = (NKAlertView *)self.superview;
            [alertView hide];
        }
    }];
    
}

- (void)cancelClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}


#pragma mark - textfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _group_tf) {
        
        if ([CenterManager.shared.role_id integerValue] == 1) {
            // 选择群组
            [CenterNet.shared groupCheckDataCompletion:^(BOOL success, NSArray * _Nullable dataList) {
                [self.groupList removeAllObjects];
                [self.groupList addObjectsFromArray:dataList];
                [self.groupList addObject:@{@"groupname":@"未分组",@"id":@"00000000-0000-0000-0000-000000000000"}];
                NSMutableArray* arrM = [NSMutableArray array];
                [self.groupList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    [arrM addObject:dict[@"groupname"]];
                }];
                [self selectdatatitle:@"选择群组" datas:arrM.copy];
            }];
        }else{
            [MBhud showText:@"不可选择群组" addView:zAppWindow];
        }
        
        return NO;
    }
    return YES;
}

#pragma mark - 选择群组的代理方法
-  (void)selectdatatitle:(NSString *)title datas:(NSArray *)datas
{
    LDYSelectivityAlertView *ldySAV = [[LDYSelectivityAlertView alloc]initWithTitle:title datas:datas ifSupportMultiple:NO];
    ldySAV.delegate = self;
    [ldySAV show];
}
- (void)singleChoiceBlockData:(NSString *)data
{
    
    
    [self.groupList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dict[@"groupname"] isEqualToString:data]) {
            self.group_id = dict[@"id"];
            self.group_tf.text = data;
        }
    }];
}

#pragma mark - lazy
- (UILabel *)t_lb
{
    if (!_t_lb) {
        _t_lb = [UILabel z_frame:CGRectMake(20, 25, 150, 33)
                            Text:NSLocalizedString(@"属性", nil)
                        fontSize:24
                           color:[UIColor colorWithHex:@"#121212"]
                          isbold:NO
                 ];
    }
    
    return _t_lb;
}

- (UILabel *)name_t_lb
{
    if (!_name_t_lb) {
        _name_t_lb = [UILabel z_frame:CGRectMake(20,self.t_lb.bottom + 25, self.width - 40, 20)
                            Text:NSLocalizedString(@"设备名称", nil)
                        fontSize:14
                           color:[UIColor colorWithHex:@"#808080"]
                          isbold:NO
                 ];
    }
    
    return _name_t_lb;
}

- (UITextField *)name_tf
{
    if (!_name_tf) {
        _name_tf = [UITextField  z_frame:CGRectMake(20, _name_t_lb.bottom + 3, self.width - 40, 48)
                                 bgColor:nil
                            cornerRadius:0
                             borderWidth:0
                             borderColor:nil
                                    text:nil
                                textFont:[UIFont systemFontOfSize:17]
                               textColor:[UIColor colorWithHex:@"#121212"]
                             placeholder:nil
                         placeholderFont:nil
                        placeholderColor:nil
                             leftImgName:nil
                             leftImgSize:CGSizeZero
                            rightImgName:nil
                            rightImgSize:CGSizeZero
                    ];
        _name_tf.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    
    return _name_tf;
}

- (UILabel *)group_t_lb
{
    if (!_group_t_lb) {
        _group_t_lb = [UILabel z_frame:CGRectMake(20,self.name_tf.bottom + 15, self.width - 40, 20)
                                  Text:NSLocalizedString(@"所属群组", nil)
                              fontSize:14
                                 color:[UIColor colorWithHex:@"#808080"]
                                isbold:NO
                       ];
    }
    
    return _group_t_lb;
}

- (UITextField *)group_tf
{
    if (!_group_tf) {
        _group_tf = [UITextField  z_frame:CGRectMake(20, _group_t_lb.bottom + 3, self.width - 40, 48)
                                             bgColor:nil
                                        cornerRadius:0
                                         borderWidth:0
                                         borderColor:nil
                                                text:nil
                                            textFont:[UIFont systemFontOfSize:17]
                                           textColor:[UIColor colorWithHex:@"#121212"]
                                         placeholder:nil
                                     placeholderFont:nil
                                    placeholderColor:nil
                                         leftImgName:nil
                                         leftImgSize:CGSizeZero
                                        rightImgName:@"icon_arrow_dropdown"
                                        rightImgSize:CGSizeMake(40, 24)
                                ];
        _group_tf.borderStyle = UITextBorderStyleRoundedRect;
        _group_tf.delegate = self;

    }
    
    return _group_tf;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton z_frame:CGRectMake(self.width*0.5-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                        norImageName:nil
                        selImageName:nil
                              Target:self
                              action:@selector(sureClick)
                               title:NSLocalizedString(@"确定", nil)
                            selTitle:nil
                                font:[UIFont boldSystemFontOfSize:SPFont(17)]
                       norTitleColor:[UIColor colorWithHex:@"#26C464"]
                       selTitleColor:nil
                             bgColor:nil
                        cornerRadius:0
                         borderWidth:0.5
                         borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                    ];
    }
    
    return _sureBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton z_frame:CGRectMake(-0.5, self.height - SPH(63), self.width*0.5+0.5, SPH(64))
                          norImageName:nil
                          selImageName:nil
                                Target:self
                                action:@selector(cancelClick)
                                 title:NSLocalizedString(@"取消", nil)
                              selTitle:nil
                                  font:[UIFont boldSystemFontOfSize:SPFont(17)]
                         norTitleColor:[UIColor colorWithHex:@"#808080"]
                         selTitleColor:nil
                               bgColor:nil
                          cornerRadius:0
                           borderWidth:0.5
                           borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                      ];
    }
    
    return _cancelBtn;
}

@end
