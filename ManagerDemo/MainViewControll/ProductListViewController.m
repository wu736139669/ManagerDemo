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
    LoanListViewController* _loanListViewController;
    FundListViewController* _fundListViewController;
    OtherListViewController* _otherListViewController;
    
    NSInteger _nowSelectTab;  //当前选择的界面。
    
}

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _loanListViewController = [[LoanListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        _loanListViewController.title = @"列表1";
        _fundListViewController = [[FundListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        _fundListViewController.title = @"列表2";
        _otherListViewController = [[OtherListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        _otherListViewController.title = @"列表3";
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
    switch (_nowSelectTab) {
        case 0:
            [_loanListViewController headerBeginRefreshing];
            break;
        case 1:
            [_fundListViewController headerBeginRefreshing];
            break;
        case 2:
            [_otherListViewController headerBeginRefreshing];
            break;
        default:
            break;
    }
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
            viewController = _loanListViewController;
            
        }
            break;
        case 1:
        {
            viewController = _fundListViewController;
        }
            break;
        case 2:
        {
            viewController = _otherListViewController;
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
    _nowSelectTab = number;
    switch (number) {
        case 0:
            if (_loanListViewController.count <= 0) {
                [_loanListViewController headerBeginRefreshing];
            }
            break;
        case 1:
            if (_fundListViewController.count <= 0) {
                [_fundListViewController headerBeginRefreshing];
            }
            break;
        case 2:
            if (_otherListViewController.count <= 0) {
                [_otherListViewController headerBeginRefreshing];
            }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
