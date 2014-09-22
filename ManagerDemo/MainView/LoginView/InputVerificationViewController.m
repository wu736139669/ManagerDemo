//
//  InputVerificationViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "InputVerificationViewController.h"
#import "SetPassWordViewController.h"
#import "AppDelegate.h"
@interface InputVerificationViewController ()
{
    NSTimer *_timer;
    NSInteger _timeSecond;
}
@end

@implementation InputVerificationViewController

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
    self.navigationItem.title = @"填写验证码";
    
    

    _verifiCode.leftViewMode = UITextFieldViewModeAlways;
    _verifiCode.layer.masksToBounds=YES;
    _verifiCode.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _verifiCode.layer.borderWidth= 1.0f;
    _verifiCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_verifiCode];
    _verifiCode.delegate = self;
    
    _timeSecond = 60;
    _sureBtn.enabled = NO;
    [_sureBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_sureBtn.frame] forState:UIControlStateDisabled];
    _reGetCodeBtn.enabled = NO;
    [_reGetCodeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_sureBtn.frame] forState:UIControlStateDisabled];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reGetCodeTime) userInfo:nil repeats:YES];
    
    NSString* temp = _phone;
    if (temp.length == 11) {
        temp = [NSString stringWithFormat:@"%@****%@",[_phone substringToIndex:3],[temp substringWithRange:NSMakeRange(7, 4)]];
    }
    
    _infoLabel.text = [NSString stringWithFormat:@"已向%@发送短信，请在输入框中填写验证码完成注册",temp];
}

-(void)reGetCodeTime
{
    if (_timeSecond > 0 && !_reGetCodeBtn.enabled) {
        if (![_timer isValid]) {
            [_timer fire];
        }
        [_reGetCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",_timeSecond] forState:UIControlStateDisabled];
        _timeSecond--;
    }else{
        _reGetCodeBtn.enabled = YES;
        _timeSecond = 60;
        [_timer invalidate];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_verifiCode resignFirstResponder];

}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _verifiCode.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location >= 10)
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    
    UITextField* textField = [sender object];
    if ([textField.text isEqualToString:@""]) {
        _sureBtn.enabled = NO;
        
    }else{
        _sureBtn.enabled = YES;
        
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reGetCodeBtnClick:(id)sender {
    _reGetCodeBtn.enabled = NO;
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_phone,@"phoneNum", nil] withApiType:@"loginFirst" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [_timer fire];
        }
    } failedBlock:^(NSError *error) {
        
    }];


}
- (IBAction)sureBtnClick:(id)sender {
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_phone,@"phoneNum",_verifiCode.text, @"verCode", nil] withApiType:@"registerOrLoginByMsg" completionBlock:^(id jsonRes) {
        if (!([[jsonRes objectForKey:@"resultflag"] integerValue] == 0)) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [ManagerUser shareInstance].isLogin = YES;
            [ManagerUser shareInstance].userId = [jsonRes objectForKeyWithoutNull:@"userid"];
            [ManagerUser shareInstance].token = [jsonRes objectForKeyWithoutNull:@"token"];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"设置登录密码可以方便登录" delegate:self cancelButtonTitle:@"下一次设置" otherButtonTitles:@"设置", nil];
            [alertView show];
        }
    } failedBlock:^(NSError *error) {
        
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
}

#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
        [self.navigationController pushViewController:setPassWordViewController animated:YES];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
