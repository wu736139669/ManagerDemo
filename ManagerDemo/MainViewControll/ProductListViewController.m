//
//  ProductListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ProductListViewController.h"
#import "LoanListViewController.h"
#import "FundListViewController.h"
#import "OtherListViewController.h"
@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ManagerUtil SetSubViewExternNone:self];
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.navigationItem setTitle:@"第二页"];
    [self.slideSwitchView buildUI];
}

#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return 3;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{

    UIViewController* viewController = nil;
    switch (number) {
        case 0:
        {
            viewController = [[LoanListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            viewController.title = @"列表1";
            
        }
            break;
        case 1:
        {
            viewController = [[FundListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            viewController.title = @"列表2";
        }
            break;
        case 2:
        {
            viewController = [[OtherListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
            viewController.title = @"列表3";
        }
            break;
            
        default:
            break;
    }
    return viewController;

}


- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    DLog(@"%ld",number);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
