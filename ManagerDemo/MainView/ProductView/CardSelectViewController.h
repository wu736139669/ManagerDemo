//
//  CardSelectViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14/11/9.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic)NSInteger amount;
@property (strong, nonatomic)NSString* proId;
@end
