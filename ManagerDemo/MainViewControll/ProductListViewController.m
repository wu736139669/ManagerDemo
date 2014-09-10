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
{
    NSArray* listViewContrllerArray;  //界面列表
    NSInteger _nowSelectTab;  //当前选择的界面。
    
}

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        LoanListViewController* loanListViewController = [[LoanListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        loanListViewController.delegate = self;
        loanListViewController.title = @"列表1";
        FundListViewController* fundListViewController = [[FundListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        fundListViewController.delegate = self;
        fundListViewController.title = @"列表2";
        OtherListViewController* otherListViewController = [[OtherListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        otherListViewController.delegate = self;
        otherListViewController.title = @"列表3";
        listViewContrllerArray = @[loanListViewController, fundListViewController, otherListViewController];
        _nowSelectTab = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ManagerUtil SetSubViewExternNone:self];
    

    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarBtnClick:)]];
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self.navigationItem setTitle:@"第二页"];
    [self.slideSwitchView buildUI];
    

}

#pragma mark method
-(void)rightBarBtnClick:(id)sender
{
    //刷新.
    [(ListViewController*)[listViewContrllerArray objectAtIndex:_nowSelectTab] headerBeginRefreshing];
}
#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return listViewContrllerArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{

    return [listViewContrllerArray objectAtIndex:number];
}


- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    _nowSelectTab = number;
    //进行第一次刷新
    [(ListViewController*)[listViewContrllerArray objectAtIndex:number] firstRefresh];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
