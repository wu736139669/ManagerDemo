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
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //首页
        UINavigationController* homeNavigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
        [homeNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"icon_dock_home"] selectedImage:[UIImage imageNamed:@"icon_dock_home_actived"]]];
        [homeNavigationController.tabBarItem setBadgeValue:@"新"];
        //第二页
        UINavigationController* produciListNavigationController = [[UINavigationController alloc] initWithRootViewController:[[ProductListViewController alloc] init]];
        [produciListNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"第二页" image:[UIImage imageNamed:@"icon_dock_session"] selectedImage:[UIImage imageNamed:@"icon_dock_session_actived"]]];
        //第三页
        UINavigationController* myNavigationController = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc] init]];
        [myNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"第三页" image:[UIImage imageNamed:@"icon_dock_mine"] selectedImage:[UIImage imageNamed:@"icon_dock_mine_actived"]]];
        //第四页
        UINavigationController* moreNavigationController = [[UINavigationController alloc] initWithRootViewController:[[MoreViewController alloc] init]];
        [moreNavigationController setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"第四页" image:[UIImage imageNamed:@"icon_dock_service"] selectedImage:[UIImage imageNamed:@"icon_dock_service_actived"]]];
        
        self.viewControllers = @[homeNavigationController, produciListNavigationController, myNavigationController, moreNavigationController];
        
        
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
