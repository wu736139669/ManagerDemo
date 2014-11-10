//
//  CardAddViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14/11/9.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardAddViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *cardTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nextTableViewCell;
@property (assign, nonatomic)NSInteger amount;
@property (strong, nonatomic)NSString* proId;

- (IBAction)nextBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;

@end
