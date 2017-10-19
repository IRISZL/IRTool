//
//  IRStringViewController.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/10/17.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRStringViewController.h"
#import "NSString+Helper.h"
#import "UIAlertView+Blocks.h"

@interface IRStringViewController ()<UIActionSheetDelegate>

// 开始的string输入框
@property (weak, nonatomic) IBOutlet UITextField *beiginTextField;

// 结果展示的label
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;



@end

@implementation IRStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"NSString+Helper";
}



- (IBAction)changeButtonAction:(UIButton *)sender {
    
    [_beiginTextField resignFirstResponder];
    
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"是否为纯数字", @"是否为纯字母", @"是否为空", @"是否有空格", @"比较两个数字串的大小",@"删除字符",@"字符串反转",@"计算高度",@"计算宽度",@"计算宽高",@"复制",nil];
        [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *beginText = _beiginTextField.text;
    
    switch (buttonIndex) {
        case 0: // 是否为纯数字
        {
            BOOL isDigtal = [beginText isDigital];
            _resultLabel.text = [NSString stringWithFormat:@"%@ %@纯数字",beginText, (isDigtal ? @"是": @"不是")];
            
        } break;
        case 1: // 是否为纯字母
        {
            BOOL isletter = [beginText isLetter];
            _resultLabel.text = [NSString stringWithFormat:@"%@ %@纯字母",beginText, (isletter ? @"是": @"不是")];
            
        }
            break;
        case 2: // 是否为空
        {
            BOOL isempty = [beginText isEmpty];
            _resultLabel.text = [NSString stringWithFormat:@"%@ %@空",beginText, (isempty ? @"为": @"不为")];
        }
            break;
        case 3: // 是否有空格
        {
            BOOL isContain = [beginText isContainsSpaces];
            _resultLabel.text = [NSString stringWithFormat:@"%@ %@空格",beginText, (isContain ? @"包含": @"不包含")];
        }
            break;
        case 4: // 比较两个数字串的大小
        {
            [UIAlertView showWithTitle:nil message:@"please input Other String" style:UIAlertViewStylePlainTextInput cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
               
                if (buttonIndex == 1) {

                    UITextField *textField = [alertView textFieldAtIndex:0];
                    NSString *otherString = textField.text;
                    
                    if (otherString && otherString.length > 0) {
                      
                        NSComparisonResult result = [beginText compareWithOtherNumberString:otherString];
                        
                        NSString *compar = nil;
                        
                        switch (result) {
                            case NSOrderedAscending: // 升序
                                compar = @"<";
                                break;
                            case NSOrderedDescending: // 降序
                                compar = @">";
                                break;
                            case NSOrderedSame: // 相等
                                compar = @"=";
                                break;
                            default:
                                break;
                        }
                        _resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@ ",beginText, compar, otherString];
                        
                    }
                    else
                    {
                        _resultLabel.text = @"其他字符串为空，不能进行比较";
                    }
 
                }
            }];
        }
            break;
        case 5: //删除字符
        {
            [UIAlertView showWithTitle:nil message:@"please input you want delete string" style:UIAlertViewStylePlainTextInput cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    UITextField *textField = [alertView textFieldAtIndex:0];
                    NSString *deleteString = textField.text;
                    _resultLabel.text = [NSString stringWithFormat:@"原串：%@， 删除后的字符串：%@",beginText, [beginText deleteCharacters:@[deleteString]]];
                }
            }];
            
            
        } break;
        case 6: //字符串反转
        {
            
            _resultLabel.text = [NSString stringWithFormat:@"原串：%@，反转之后的串:%@", beginText, [beginText reversal]];
            
            
        } break;
        case 7: //计算高度
        {
            [UIAlertView showWithTitle:nil message:@"please input you want Max width" style:UIAlertViewStylePlainTextInput cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    UITextField *textField = [alertView textFieldAtIndex:0];
                    NSString *maxWidthString = textField.text;
                    
                    if ([maxWidthString isDigital]) {
                        
                        _resultLabel.text = [NSString stringWithFormat:@"%@ 的高度为 %.2f",beginText, [beginText calculateHeightWithMaxWidth:[maxWidthString floatValue] font:_beiginTextField.font]];
                        
                    }
                    else
                    {
                        _resultLabel.text = @"最大宽度必须为纯数字";
                    }
                }
            }];
        } break;
        case 8: //计算宽度
        {
            [UIAlertView showWithTitle:nil message:@"please input you want Max height" style:UIAlertViewStylePlainTextInput cancelButtonTitle:@"cancel" otherButtonTitles:@[@"OK"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    UITextField *textField = [alertView textFieldAtIndex:0];
                    NSString *maxHeightString = textField.text;
                    
                    if ([maxHeightString isDigital]) {
                        
                        _resultLabel.text = [NSString stringWithFormat:@"%@ 的宽度为 %.2f",beginText, [beginText calculateHeightWithMaxWidth:[maxHeightString floatValue] font:_beiginTextField.font]];
                    }
                    else
                    {
                        _resultLabel.text = @"最大高度必须为纯数字";
                    }
                }
            }];
        } break;
        case 9: //计算宽高
        {
            CGSize textSize = [beginText calculateSizeWithFont:_beiginTextField.font];
            _resultLabel.text = [NSString stringWithFormat:@"%@ 的宽高为为 %.2f * %.2f",beginText,textSize.width,textSize.height];
        } break;
        case 10: //复制
        {
            [beginText paster];
            _resultLabel.text = @"复制成功";
        } break;
        default:
            break;
    }
}
@end
