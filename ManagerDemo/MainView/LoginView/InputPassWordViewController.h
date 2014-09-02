//
//  InputPassWordViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIUnderlinedButton.h"

@protocol InputPassWordViewControllerDelegate <NSObject>
-(void)loginSuccess;
@end
@interface InputPassWordViewController : UIViewController
{
    NSString* _phoneNum;
    __weak id<InputPassWordViewControllerDelegate> _delegate;
    
}
@property (weak, nonatomic)id<InputPassWordViewControllerDelegate> delegate;
@property (strong, nonatomic)NSString* phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *forgetBtn;
- (IBAction)login:(id)sender;

@end
