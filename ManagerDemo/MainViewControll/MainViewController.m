//
//  MainViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ProductListViewController.h"
#import "MyViewController.h"
#import "MoreViewController.h"
#import "LoginViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //首页
        _homeNavigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
        //第二页
        _produciListNavigationController = [[UINavigationController alloc] initWithRootViewController:[[ProductListViewController alloc] init]];
        //第三页
        _myNavigationController = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc] init]];
        
        //第四页
        _myMoreNavigationController = [[UINavigationController alloc] initWithRootViewController:[[MoreViewController alloc] init]];
        if (IOS7_OR_LATER) {
            [_homeNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_dock_home"] selectedImage:[UIImage imageNamed:@"icon_dock_home_actived"]]];
            
            [_produciListNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"产品列表" image:[UIImage imageNamed:@"icon_dock_session"] selectedImage:[UIImage imageNamed:@"icon_dock_session_actived"]]];
            
            [_myNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"我的贷贷" image:[UIImage imageNamed:@"icon_dock_mine"] selectedImage:[UIImage imageNamed:@"icon_dock_mine_actived"]]];
            
            [_myMoreNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"更多" image:[UIImage imageNamed:@"icon_dock_service"] selectedImage:[UIImage imageNamed:@"icon_dock_service_actived"]]];
        }
        
        self.viewControllers = @[_homeNavigationController, _produciListNavigationController, _myNavigationController, _myMoreNavigationController];
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
