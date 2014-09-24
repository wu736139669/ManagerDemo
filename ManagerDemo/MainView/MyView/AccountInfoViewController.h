//
//  AccountInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-29.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"

@interface AccountInfoViewController : ViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSString* _phoneNum;
    NSString* _name;
    NSString* _idCard;
}
@property (strong, nonatomic)NSString* phoneNum;
@property (strong, nonatomic)NSString* name;
@property (strong, nonatomic)NSString* idCard;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property (strong, nonatomic) IBOutlet UITableViewCell *modifyInfoCell;
@end
