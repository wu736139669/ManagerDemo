//
//  HelpCenterViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
