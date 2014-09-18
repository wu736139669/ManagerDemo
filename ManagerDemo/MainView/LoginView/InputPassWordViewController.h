//
//  InputPassWordViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUnderlinedButton.h"

@interface InputPassWordViewController : UIViewController
{
    NSString* _phoneNum;
}

@property (strong, nonatomic)NSString* phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *forgetBtn;
- (IBAction)login:(id)sender;

@end
