//
//  MyViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTotalProfitCellView.h"
@interface MyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MyTotalProfitCellViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
