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
        [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_phoneNum,@"phoneNum",[ManagerUtil md5:_passwordTextField.text], @"loginPsw", nil] withApiType:@"loginByPsw" completionBlock:^(id jsonRes) {
            if (!([[jsonRes objectForKey:@"resultflag"] integerValue] == 0)) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];

            }else{
                [ManagerUser shareInstance].isLogin = YES;
                [ManagerUser shareInstance].userId = [jsonRes objectForKeyWithoutNull:@"userid"];
                [ManagerUser shareInstance].token = [jsonRes objectForKeyWithoutNull:@"token"];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            }
        } failedBlock:^(NSError *error) {
            
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        }];
    }
}
@end
