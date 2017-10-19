//
//  ViewController.m
//  IRTools
//
//  Created by irisZL on 17/9/28.
//  Copyright © 2017年 IRISZL. All rights reserved.
//

#import "ViewController.h"
#import "IRTools.h"
#import "IRColorViewController.h"
#import "IRUIViewController.h"
#import "IRStringViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *cellData;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试测试";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [IRTools getScreenWidth], [IRTools getScreenHeight]) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
    _cellData = @[@"UIColor+Hex", @"UIView+Frame",@"NSString+Helper",@"NSAttributedString+Helpers", @"IRDateTools", @"IRDeviceTools", @"UIImage+helpers", @"UIView+Helpers", @"IRTools", @"IRFileTools"];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *identify = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _cellData[indexPath.row];
    
    
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellData.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger row = indexPath.row;
    UIViewController *viewController = nil;
    
    switch (row) {
        case 0: // UIColor + Helper
            
            viewController = [[IRColorViewController alloc] init];
            break;
        case 1: // UIView+Frame
        case 7: // UIView+Helpers
            viewController = [[IRUIViewController alloc] init];
            break;
        case 2: // NSString+Helper
            viewController = [[IRStringViewController alloc] init];
            break;
        default:
            break;
    }
    
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
