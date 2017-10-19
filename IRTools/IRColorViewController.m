//
//  IRColorViewController.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/10/11.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRColorViewController.h"
#import "UIColor+Hex.h"
#import "NSString+Helper.h"

@interface IRColorViewController ()
// 16进制输入
@property (weak, nonatomic) IBOutlet UITextField *hexTextField;

// Red
@property (weak, nonatomic) IBOutlet UITextField *RTextField;

// Gree
@property (weak, nonatomic) IBOutlet UITextField *GTextField;

// Blue
@property (weak, nonatomic) IBOutlet UITextField *BTextField;

// Alpha
@property (weak, nonatomic) IBOutlet UITextField *ATextField;

// 转换按钮
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (weak, nonatomic) IBOutlet UIView *changeView;
@end

@implementation IRColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"UIColor+Helper";

}


// 转换按钮的点击
- (IBAction)changeButtonAction:(UIButton *)sender
{
    [self textFieldResignFirstResponder];
    
    NSString *hexString = _hexTextField.text;
    NSString *R = _RTextField.text;
    NSString *G = _GTextField.text;
    NSString *B = _BTextField.text;
    NSString *A = _ATextField.text;
    
    
    if (hexString && hexString.length > 0) {

        // 16进制转换成二维码
        UIColor *hexColor = [UIColor UIColorFormHexString:hexString];
            
        _changeView.backgroundColor = hexColor;
        
        _RTextField.text = [UIColor getRColorFromHex:hexString];
        _GTextField.text = [UIColor getGColorFromHex:hexString];
        _BTextField.text = [UIColor getBColorFromHex:hexString];
        _ATextField.text = @"1.0";
    }
    else if (R && R.length > 0 && [R isDigital] && G && G.length > 0 && [G isDigital] && B && B.length > 0 && [B isDigital])
    {
        UIColor *rgbColor = nil;
        if (A && A.length > 0 && [A isDigital]) {
            rgbColor = [UIColor colorWithRed:[R floatValue]/255.0 green:[G floatValue]/255.0 blue:[B floatValue]/255.0 alpha:[A floatValue]];
        }
        else
        {
            rgbColor = [UIColor colorWithRed:[R floatValue]/255.0  green:[G floatValue]/255.0  blue:[B floatValue]/255.0  alpha:1];
        }
        _changeView.backgroundColor = rgbColor;
        _hexTextField.text = [UIColor HexFromUIColor:rgbColor];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip" message:@"输入有误，请检查并重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)textFieldResignFirstResponder
{
    [_ATextField resignFirstResponder];
    [_BTextField resignFirstResponder];
    [_GTextField resignFirstResponder];
    [_RTextField resignFirstResponder];
    [_hexTextField resignFirstResponder];
}


@end
