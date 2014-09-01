//
//  AccountInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-29.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"

@interface AccountInfoViewController : ViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property (strong, nonatomic) IBOutlet UITableViewCell *modifyInfoCell;
@end
