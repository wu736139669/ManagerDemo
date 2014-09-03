//
//  MessageDetailViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-3.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSString* _msgId;
}
@property (strong, nonatomic) NSString* msgId;
@property (strong, nonatomic) IBOutlet UITableViewCell *msgTableCell;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *msgNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgDetailLabel;

@end
