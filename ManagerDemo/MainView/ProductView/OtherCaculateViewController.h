//
//  OtherCaculateViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-24.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherCaculateViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    float _qrnh;
    float _extraPoint;
    NSString* _name;
    NSString* _productId;
}
@property (strong, nonatomic)NSString* name;
@property (strong, nonatomic)NSString* productId;
@property (assign, nonatomic)float qrnh;
@property (assign, nonatomic)float extraPoint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *profit1Label;
@property (weak, nonatomic) IBOutlet UILabel *profit3Label;
@property (weak, nonatomic) IBOutlet UILabel *profit5Label;
@property (weak, nonatomic) IBOutlet UILabel *profit7Label;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UILabel *ygsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *jfsyLabel;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *caculateBtn;
- (IBAction)caculateBtnClick:(id)sender;

@end
