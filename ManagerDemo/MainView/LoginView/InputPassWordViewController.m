//
//  InputPassWordViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "InputPassWordViewController.h"

@interface InputPassWordViewController ()

@end

@implementation InputPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"填写登录密码";
    _passwordTextField.layer.masksToBounds=YES;
    _passwordTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _passwordTextField.layer.borderWidth= 1.0f;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_passwordTextField];
    
    _sureBtn.enabled = NO;
    [_sureBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_sureBtn.frame] forState:UIControlStateDisabled];
    
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    UITextField* textField = [sender object];
    if (textField.text.length>0) {
        _sureBtn.enabled = YES;
    }else{
        _sureBtn.enabled = NO;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {
    if (_passwordTextField.text.length>0 && _phoneNum.length>0) {
        DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
        [daiDaiTongApi loginWithPhone:_phoneNum withPassWord:_passwordTextField.text withCompletionBlock:^(id jsonRes) {
            if ([[jsonRes objectForKey:@"succ"] integerValue] != 1) {
            }else{
            }
            [ManagerUser shareInstance].isLogin = YES;
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            
        } failedBlock:^(NSError *error) {
            DLog(@"失败");
            [MBProgressHUD errorHudWithView:nil label:@"网络出错" hidesAfter:1.0];
        }];
    }
}
@end
