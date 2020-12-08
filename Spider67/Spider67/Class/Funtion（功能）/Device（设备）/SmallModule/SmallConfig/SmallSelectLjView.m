//
//  SmallSelectLjView.m
//  Spider67
//
//  Created by 宾哥 on 2020/9/27.
//  Copyright © 2020 apple. All rights reserved.
//

#import "SmallSelectLjView.h"

@interface SmallSelectLjView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *datePickView;
@property (nonatomic, strong)NSArray *showData;
@property (nonatomic, copy) NSString* selectData;

@end
@implementation SmallSelectLjView

-(NSArray *)showData{
    if (!_showData) {
        _showData = @[@"<",
                      @">",
        ];
        
        self.selectData = _showData[0];
    }
    return _showData;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setDataStr:(NSString *)dataStr
{
    _dataStr = dataStr;
    if (dataStr.length > 0) {
        [self.showData enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([_dataStr isEqualToString:obj]) {
                [self.datePickView selectRow:idx inComponent:0 animated:NO];
                self.selectData = obj;
            }
        }];
    }
    
}

- (void)cancelBtnClick
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}
- (void)sureBtnClick
{
    if (self.selectSymbol) {
        self.selectSymbol(_selectData);
    }
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    
}

- (void)setupUI{
    
    UIButton* cancelBtn = [UIButton z_frame:CGRectMake(0, 5, 50, 40)
                                   fontSize:16
                               cornerRadius:0
                            backgroundColor:0
                                 titleColor:[UIColor colorWithHex:@"#808080"]
                                      title:NSLocalizedString(@"取消", nil)
                                     isbold:NO
                                     Target:self
                                     action:@selector(cancelBtnClick)
                           ];
    [self addSubview:cancelBtn];
    
    UIButton* sureBtn = [UIButton z_frame:CGRectMake(self.width - 50, 5, 50, 40)
                                     fontSize:16
                                 cornerRadius:0
                              backgroundColor:0
                                   titleColor:[UIColor colorWithHex:@"#26C464"]
                                        title:NSLocalizedString(@"确定", nil)
                                       isbold:NO
                                       Target:self
                                       action:@selector(sureBtnClick)
                             ];
      [self addSubview:sureBtn];
    
    self.datePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, sureBtn.bottom, self.width, self.height - sureBtn.height)];
    [self addSubview:self.datePickView];
    self.datePickView.delegate = self;
    self.datePickView.dataSource = self;
    

}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.showData.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.showData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectData = self.showData[row];
}

@end
