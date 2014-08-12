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
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)headerRereshing;
- (void)footerRereshing;
@end
