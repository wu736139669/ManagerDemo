//
//  ListViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    __weak UITableView* _tableView;
    NSInteger _count;
    __weak UIViewController* _delegate;          //保存创建的UIViewControll
}
@property (weak, nonatomic) UIViewController* delegate;
@property (weak, nonatomic) UINavigationController* listNavigationController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic)NSInteger count;
- (void)headerRereshing;
- (void)footerRereshing;
- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)firstRefresh;
@end
