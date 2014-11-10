//
//  CardBindViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14/11/10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardBindViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic)NSInteger amount;
@property (strong, nonatomic)NSString* proId;
@property (strong, nonatomic)NSString* cardNo;
@property (assign, nonatomic)NSInteger type;

- (IBAction)nextBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *firstTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *secondTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *thirdTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nextTableViewCell;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
@property (strong, nonatomic) IBOutlet UITableViewCell *pwdTableViewCell;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextField *thirdTextField;

@end
