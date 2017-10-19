//
//  IRUIViewController.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/10/17.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "IRUIViewController.h"
#import "UIView+Frame.h"
#import "UIView+Helper.h"
#import "UIAlertView+Blocks.h"
#import "NSString+Helper.h"


@interface IRUIViewController ()

@property (nonatomic, strong) UILabel *Aview;

@property (nonatomic, strong) UILabel *Bview;

@property (nonatomic, strong) UILabel *AX;
@property (nonatomic, strong) UILabel *AY;
@property (nonatomic, strong) UILabel *AWidth;
@property (nonatomic, strong) UILabel *AHeight;


@property (nonatomic, strong) UILabel *BX;
@property (nonatomic, strong) UILabel *BY;
@property (nonatomic, strong) UILabel *BWidth;
@property (nonatomic, strong) UILabel *BHeight;

// A与B的关系
@property (nonatomic, strong) UILabel *ABRelationship;


@end


typedef NS_ENUM(NSUInteger, IRPosition) {
    IRPositionH = 0,
    IRPositionX,
    IRPositionY,
    IRPositionW,
    IRPositionUnKonw,
};

@implementation IRUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"UIView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建一个修改按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 60);
    [button setTitle:@"我要修改" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(modifyRange) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    // 创建两个View
    
    //A
    _Aview = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 64, 30, 30)];
    _Aview.backgroundColor = [UIColor blueColor];
    _Aview.textAlignment = NSTextAlignmentCenter;
    _Aview.font = [UIFont systemFontOfSize:18.0];
    _Aview.textColor = [UIColor blackColor];
    _Aview.text = @"A";
    
    //B
    _Bview = [[UILabel alloc] initWithFrame:CGRectMake(50, 10 + 64, 30, 30)];
    _Bview.backgroundColor = [UIColor yellowColor];
    _Bview.textAlignment = NSTextAlignmentCenter;
    _Bview.font = [UIFont systemFontOfSize:18.0];
    _Bview.textColor = [UIColor blackColor];
    _Bview.text = @"B";
    
    // 165
    CGFloat bottomViewHeight = 165;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screenSize.height - bottomViewHeight, screenSize.width, bottomViewHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottomView];
    [self.view addSubview:_Aview];
    [self.view addSubview:_Bview];
    
    
    UIFont *textFont = [UIFont systemFontOfSize:15.0];
    
    UILabel *ALabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 15, 21)];
    ALabel.text = @"A:";
    ALabel.font = textFont;
    [bottomView addSubview:ALabel];
    _AX = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ALabel.frame) + 5, 10, 80, 21)];
    _AX.text = [NSString stringWithFormat:@"X:%.2f", _Aview.x];
    _AX.font = textFont;
    [bottomView addSubview:_AX];
    _AY = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_AX.frame) + 10, 10, 80, 21)];
    _AY.text = [NSString stringWithFormat:@"Y:%.2f", _Aview.y];
    _AY.font = textFont;
    [bottomView addSubview:_AY];
    _AWidth = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ALabel.frame) + 5, CGRectGetMaxY(_AX.frame), 80, 21)];
    _AWidth.text = [NSString stringWithFormat:@"W:%.2f",_Aview.width];
    _AWidth.font = textFont;
    [bottomView addSubview:_AWidth];
    _AHeight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_AWidth.frame) + 10, CGRectGetMaxY(_AY.frame), 80, 21)];
    _AHeight.text = [NSString stringWithFormat:@"H:%.2f", _Aview.height];
    _AHeight.font = textFont;
    [bottomView addSubview:_AHeight];
    
    
    UILabel *BLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_AWidth.frame) + 15, 15, 21)];
    BLabel.text = @"B:";
    BLabel.font = textFont;
    [bottomView addSubview:BLabel];
    _BX = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(BLabel.frame) + 5, CGRectGetMaxY(_AWidth.frame) + 15, 80, 21)];
    _BX.text = [NSString stringWithFormat:@"X:%.2f", _Bview.x];
    _BX.font = textFont;
    [bottomView addSubview:_BX];
    _BY = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_BX.frame) + 10, CGRectGetMaxY(_AWidth.frame) + 15, 80, 21)];
    _BY.text = [NSString stringWithFormat:@"Y:%.2f", _Bview.y];
    _BY.font = textFont;
    [bottomView addSubview:_BY];
    _BWidth = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(BLabel.frame) + 5, CGRectGetMaxY(_BX.frame), 80, 21)];
    _BWidth.text = [NSString stringWithFormat:@"W:%.2f",_Bview.width];
    _BWidth.font = textFont;
    [bottomView addSubview:_BWidth];
    _BHeight = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_BWidth.frame) + 5, CGRectGetMaxY(_BY.frame), 80, 21)];
    _BHeight.font = textFont;
    _BHeight.text = [NSString stringWithFormat:@"H:%.2f", _Bview.height];
    [bottomView addSubview:_BHeight];
    
    
    _ABRelationship = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_BWidth.frame) + 15, screenSize.width - 20, 21)];
    _ABRelationship.text = [NSString stringWithFormat:@"A与B的位置关系:%@", [self getABRelationship]];
    _ABRelationship.font = textFont;
    [bottomView addSubview:_ABRelationship];
}



- (void)modifyRange
{
   
    
    
    [UIAlertView showWithTitle:nil message:@"请选择需要修改的View" cancelButtonTitle:@"A" otherButtonTitles:@[@"B"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
    
        BOOL isSelectA = YES;
        
        switch (buttonIndex) {
            case 0: // 选择A
                break;
            case 1: // 选择B
                isSelectA = NO;
                break;
            default:
                break;
        }
     
        [UIAlertView showWithTitle:nil message:@"请选择想要修改的坐标" cancelButtonTitle:@"Height" otherButtonTitles:@[@"X", @"Y", @"Width"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            
            IRPosition postition = buttonIndex;
            
            [UIAlertView showWithTitle:nil message:@"请修改(一定要是数字)" style:UIAlertViewStylePlainTextInput cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
                if (buttonIndex == 1) {
                    
                    UITextField *textField = [alertView textFieldAtIndex:0];
                    
                    NSString *number = [textField text];
                    if ([number isDigital]) {
                        
                        [self modifyPositionWithISAview:isSelectA postion:postition number:number];
                    }
                    else
                    {
                        [UIAlertView showWithTitle:@"Tip" message:@"您输入的不是数字哦！！ 请重新操作" cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
                    }
                }
            }];
        }];

    }];
    
    

}

- (void)modifyPositionWithISAview:(BOOL)isAview postion:(IRPosition)position number:(NSString *)number
{
    CGFloat positionFloat = [number floatValue];
    
    if (isAview) {
       
        [UIView animateWithDuration:2.0 animations:^{
           
            switch (position) {
                case IRPositionX:
                    _Aview.x = positionFloat;
                    _AX.text = [NSString stringWithFormat:@"X:%.2f", _Aview.x];
                    break;
                case IRPositionY:
                    _Aview.y = positionFloat;
                    _AY.text = [NSString stringWithFormat:@"Y:%.2f", _Aview.y];
                    break;
                case IRPositionW:
                    _Aview.width = positionFloat;
                    _AWidth.text = [NSString stringWithFormat:@"W:%.2f", _Aview.width];
                    break;
                case IRPositionH:
                    _Aview.height = positionFloat;
                    _AHeight.text = [NSString stringWithFormat:@"H:%.2f", _Aview.height];
                    break;
                default:
                    break;
            }

        }];
   
    }
    else
    {
        [UIView animateWithDuration:2.0 animations:^{
            
            switch (position) {
                case IRPositionX:
                    _Bview.x = positionFloat;
                    _BX.text = [NSString stringWithFormat:@"X:%.2f", _Bview.x];
                    break;
                case IRPositionY:
                    _Bview.y = positionFloat;
                    _BY.text = [NSString stringWithFormat:@"Y:%.2f", _Bview.y];
                    break;
                case IRPositionW:
                    _Bview.width = positionFloat;
                    _BWidth.text = [NSString stringWithFormat:@"W:%.2f", _Bview.width];
                    break;
                case IRPositionH:
                    _Bview.height = positionFloat;
                    _BHeight.text = [NSString stringWithFormat:@"H:%.2f", _Bview.height];
                    break;
                default:
                    break;
            }
            
        }];
        
    }
    
    
    _ABRelationship.text  = [NSString stringWithFormat:@"A与B的位置关系:%@", [self getABRelationship]];
 
}



- (NSString *)getABRelationship
{
    NSString *relationship = @"unknow";
    IRPositionRelation position = [_Aview determineThePositionShipWithOtherView:_Bview];
    switch (position) {
        case IRPositionRelationOverLapper:
            relationship = @"重叠";
            break;
        case IRPositionRelationContain:
            relationship = @"包含（包括重合）";
            break;
        case IRPositionRelationSeparation:
            relationship = @"分离";
            break;
        default:
            break;
    }
    
    return relationship;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
