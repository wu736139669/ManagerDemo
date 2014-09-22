//
//  AuthenticationViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-22.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthenticationViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtnClick:(id)sender;

@end
