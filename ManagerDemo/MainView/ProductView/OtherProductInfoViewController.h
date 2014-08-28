//
//  OtherProductInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-28.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
@interface OtherProductInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ToolBarView *toolBarView;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *stateInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *resultsInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *securityInfoCell;

@end
