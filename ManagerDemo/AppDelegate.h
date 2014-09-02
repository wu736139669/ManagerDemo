//
//  AppDelegate.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    MainViewController* _mainViewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController* mainViewController;
@end
