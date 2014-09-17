//
//  FundAmountViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@interface FundAmountViewController : BaseListViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *headTotalLabel;

@end
