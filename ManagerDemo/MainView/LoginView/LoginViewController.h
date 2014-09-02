//
//  LoginViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputPassWordViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate, InputPassWordViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtnClick:(id)sender;

@end
