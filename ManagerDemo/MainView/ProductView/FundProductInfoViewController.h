//
//  FundProductInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
@interface FundProductInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ToolBarView *toolBarView;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *stateInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *resultsCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;

@end
