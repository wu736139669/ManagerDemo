//
//  MoreViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
