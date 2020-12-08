//
//  IpCell.m
//  Spider67
//
//  Created by 宾哥 on 2020/6/19.
//  Copyright © 2020 apple. All rights reserved.
//

#import "IpCell.h"

@interface IpCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView* bView;
@property (nonatomic, strong) UIButton* bBtn;
@property (nonatomic, strong) UILabel* bLine;

@end
@implementation IpCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setupUI];

    }
    return self;
}

- (void)setIpW:(CGFloat)ipW
{
    _ipW = ipW;
    if (ipW == 48) {
        _bView.width = SPH(ipW);
        _bBtn.hidden = YES;
        _bLine.hidden = YES;
        _tf4.width = _bView.width;
        
    }
    
}

- (void)setupUI
{

    UITextField* tf1 = [UITextField z_frame:CGRectMake(0,0, SPH(48), SPH(48))
                                         bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                                    cornerRadius:4
                                borderWidth:0.5
                                     borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                                            text:nil
                                        textFont:[UIFont systemFontOfSize:SPH(17)]
                                       textColor:[UIColor colorWithHex:@"#121212"]
                                     placeholder:nil
                                 placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                     leftImgName:nil
                                     leftImgSize:CGSizeZero
                                    rightImgName:nil
                                    rightImgSize:CGSizeZero
                             ];

    tf1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tf1];
   
    
    UILabel* dianLb1 = [[UILabel alloc] init];
    dianLb1.backgroundColor = [UIColor blackColor];
    dianLb1.layer.cornerRadius = 2.5;
    dianLb1.layer.masksToBounds = YES;
    [self addSubview:dianLb1];
    dianLb1.width = 5;
    dianLb1.height = 5;
    dianLb1.centerY = tf1.centerY;
    dianLb1.x = tf1.right + 8;
    
    
    UITextField* tf2 = [UITextField z_frame:CGRectMake(dianLb1.right + SPW(8),0, SPH(48), SPH(48))
                                          bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                                     cornerRadius:4
                                 borderWidth:0.5
                                      borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                                             text:nil
                                         textFont:[UIFont systemFontOfSize:SPH(17)]
                                        textColor:[UIColor colorWithHex:@"#121212"]
                                      placeholder:nil
                                  placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                 placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                      leftImgName:nil
                                      leftImgSize:CGSizeZero
                                     rightImgName:nil
                                     rightImgSize:CGSizeZero
                              ];
  
    tf2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tf2];
      
    UILabel* dianLb2 = [[UILabel alloc] init];
    dianLb2.backgroundColor = [UIColor blackColor];
    dianLb2.layer.cornerRadius = 2.5;
    dianLb2.layer.masksToBounds = YES;
    [self addSubview:dianLb2];
    dianLb2.width = 5;
    dianLb2.height = 5;
    dianLb2.centerY = tf2.centerY;
    dianLb2.x = tf2.right + 8;
    
    UITextField* tf3 = [UITextField z_frame:CGRectMake(dianLb2.right + SPW(8),0, SPH(48), SPH(48))
                                             bgColor:[UIColor colorWithHex:@"#F6F8FA"]
                                        cornerRadius:4
                                    borderWidth:0.5
                                         borderColor:[UIColor colorWithHex:@"#000000" alpha:0.19]
                                                text:nil
                                            textFont:[UIFont systemFontOfSize:SPH(17)]
                                           textColor:[UIColor colorWithHex:@"#121212"]
                                         placeholder:nil
                                     placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                    placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                         leftImgName:nil
                                         leftImgSize:CGSizeZero
                                        rightImgName:nil
                                        rightImgSize:CGSizeZero
                                 ];

    tf3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tf3];
         
    UILabel* dianLb3 = [[UILabel alloc] init];
    dianLb3.backgroundColor = [UIColor blackColor];
    dianLb3.layer.cornerRadius = 2.5;
    dianLb3.layer.masksToBounds = YES;
    [self addSubview:dianLb3];
    dianLb3.width = 5;
    dianLb3.height = 5;
    dianLb3.centerY = tf3.centerY;
    dianLb3.x = tf3.right + 8;
    
    UIView* bView = [[UIView alloc] initWithFrame:CGRectMake(dianLb3.right + SPW(8), 0, SPH(96), SPH(48))];
    bView.backgroundColor = [UIColor colorWithHex:@"#F6F8FA"];
    bView.layer.borderColor = [UIColor colorWithHex:@"#000000" alpha:0.19].CGColor;
    bView.layer.borderWidth = 0.5;
    bView.layer.cornerRadius = 4;
    [self addSubview:bView];
    _bView = bView;

    UIButton* bBtn = [[UIButton alloc] initWithFrame:CGRectMake(bView.width - SPH(48), 0, SPH(48), SPH(48))];
    [bBtn setImage:[UIImage imageNamed:@"icon_server"] forState:UIControlStateNormal];
    [bView addSubview:bBtn];
    _bBtn = bBtn;
    [bBtn addTarget:self action:@selector(bBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UILabel* bLine = [[UILabel alloc] initWithFrame:CGRectMake(bBtn.x - 0.5, 0, 0.5, bView.height)];
    bLine.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.19];
    [bView addSubview:bLine];
    _bLine = bLine;

    UITextField* tf4 = [UITextField z_frame:CGRectMake(0, 0,bLine.x, bView.height)
                                             bgColor:nil
                                        cornerRadius:0
                                    borderWidth:0
                                         borderColor:nil
                                                text:nil
                                            textFont:[UIFont systemFontOfSize:SPH(17)]
                                           textColor:[UIColor colorWithHex:@"#121212"]
                                         placeholder:nil
                                     placeholderFont:[UIFont systemFontOfSize:SPH(17)]
                                    placeholderColor:[UIColor colorWithHex:@"#B5B5B50"]
                                         leftImgName:nil
                                         leftImgSize:CGSizeZero
                                        rightImgName:nil
                                        rightImgSize:CGSizeZero
                                 ];

    tf4.textAlignment = NSTextAlignmentCenter;
    [bView addSubview:tf4];
//    tf4.backgroundColor = [UIColor redColor];
    
    tf1.keyboardType = UIKeyboardTypeNumberPad;
    tf2.keyboardType = UIKeyboardTypeNumberPad;
    tf3.keyboardType = UIKeyboardTypeNumberPad;
    tf4.keyboardType = UIKeyboardTypeNumberPad;
    
//    tf1.delegate = self;
//    tf2.delegate = self;
//    tf3.delegate = self;
//    tf4.delegate = self;
    
    _tf1 = tf1;
    _tf2 = tf2;
    _tf3 = tf3;
    _tf4 = tf4;
    
    [self.tf1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.tf4 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
       
}


-(void)textFieldDidChange:(UITextField*)textField
{
CGFloat maxLength =3;
NSString*toBeString = textField.text;
//获取高亮部分
UITextRange*selectedRange = [textField markedTextRange];
UITextPosition*position = [textField positionFromPosition:selectedRange.start offset:0];
if(!position || !selectedRange)
{
if(toBeString.length > maxLength)
{NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLength];if(rangeIndex.length ==1)
{
textField.text = [toBeString substringToIndex:maxLength];
}else{
    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLength)];
textField.text = [toBeString substringWithRange:rangeRange];
}}}}


#pragma mark - UITextFieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//
////    if (textField == _tf1) {
////        if (textField.text.length > 2) return NO;
////    }else if (textField == _tf2) {
////        if (textField.text.length > 2) return NO;
////    }else if (textField == _tf3) {
////        if (textField.text.length > 2) return NO;
////    }else if (textField == _tf4) {
////        if (textField.text.length > 2) return NO;
////    }
//    return YES;
//}

- (void)bBtnClick
{
   if ([self.delegate respondsToSelector:@selector(ipshowServerList)]) {
        [self.delegate ipshowServerList];
    }
}


@end
