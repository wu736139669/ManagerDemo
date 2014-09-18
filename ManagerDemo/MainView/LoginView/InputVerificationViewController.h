//
//  InputVerificationViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"

@interface InputVerificationViewController : ViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSString* _phone;
}
@property (strong, nonatomic)NSString* phone;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UITextField *verifiCode;

@property (weak, nonatomic) IBOutlet UIButton *reGetCodeBtn;
- (IBAction)reGetCodeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
- (IBAction)sureBtnClick:(id)sender;

@end
