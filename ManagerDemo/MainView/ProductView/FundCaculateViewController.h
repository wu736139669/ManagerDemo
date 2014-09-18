//
//  FundCaculateViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundCaculateViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
{
    float _qrnh;
    NSString* _name;
}
@property (strong, nonatomic)NSString* name;
@property (assign, nonatomic)float qrnh;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgqeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ygsy1Label;
@property (weak, nonatomic) IBOutlet UILabel *ygsy7Label;
@property (weak, nonatomic) IBOutlet UILabel *ygsy30Label;
@property (weak, nonatomic) IBOutlet UILabel *ygsy90Label;
@property (weak, nonatomic) IBOutlet UILabel *ygsy365Label;
@property (weak, nonatomic) IBOutlet UILabel *ygsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *jfsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yhhqsyLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *caculateBtn;
- (IBAction)caculateBtnClick:(id)sender;

@end
