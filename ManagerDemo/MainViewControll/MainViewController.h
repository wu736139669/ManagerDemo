//
//  MainViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MainViewController : UITabBarController
{
    UINavigationController* _homeNavigationController;
    UINavigationController* _produciListNavigationController;
    UINavigationController* _myNavigationController;
    UINavigationController* _moreNavigationController;
}
@property(nonatomic, strong)UINavigationController* homeNavigationController;
@property(nonatomic, strong)UINavigationController* produciListNavigationController;
@property(nonatomic, strong)UINavigationController* myNavigationController;
@property(nonatomic, strong)UINavigationController* moreNavigationController;
@end
