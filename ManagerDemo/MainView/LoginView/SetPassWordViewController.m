//
//  SetPassWordViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "SetPassWordViewController.h"
#import "MainOrderViewController.h"
@interface SetPassWordViewController ()

@end

@implementation SetPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _type = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_type == 0) {
        self.navigationItem.title = @"设置登录密码";
    }else{
        self.navigationItem.title = @"设置交易密码";
    }
    
    _passWordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passWordTextField.layer.masksToBounds=YES;
    _passWordTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _passWordTextField.layer.borderWidth= 1.0f;
    _passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_passWordTextField];
    _passWordTextField.delegate = self;
    
    _surePassWordTextField.leftViewMode = UITextFieldViewModeAlways;
    _surePassWordTextField.layer.masksToBounds=YES;
    _surePassWordTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _surePassWordTextField.layer.borderWidth= 1.0f;
    _surePassWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_surePassWordTextField];
    _surePassWordTextField.delegate = self;
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_completeBtn.frame] forState:UIControlStateDisabled];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_surePassWordTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    _surePassWordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    _passWordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _surePassWordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    _passWordTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location >= 12)
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    
    if ([_passWordTextField.text isEqualToString:@""] || [_surePassWordTextField.text isEqualToString:@""] ) {
        _completeBtn.enabled = NO;
        
    }else{
        _completeBtn.enabled = YES;
        
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

- (IBAction)completeBtnClick:(id)sender {
    
    if (![_passWordTextField.text isEqualToString:_surePassWordTextField.text]) {
        [MBProgressHUD errorHudWithView:self.view label:@"两次密码不同" hidesAfter:0.5];
    }
    if (_passWordTextField.text.length<6 || _passWordTextField.text.length>11) {
        [MBProgressHUD errorHudWithView:self.view label:@"密码不规范" hidesAfter:0.5];
    }
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    
    
    if (_type == 0 ) {
        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[ManagerUtil md5:_passWordTextField.text],@"loginPsw", nil] withApiType:@"setLoginPsw" completionBlock:^(id jsonRes) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (!([[jsonRes objectForKey:@"resultflag"] integerValue] == 0)) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
            }else{
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
                }];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failedBlock:^(NSError *error) {
            
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        }];

    }else{

        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[ManagerUtil md5:_passWordTextField.text],@"tradePsw", nil] withApiType:@"setTradePsw" completionBlock:^(id jsonRes) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (!([[jsonRes objectForKey:@"resultflag"] integerValue] == 0)) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
            }else{
                [[ManagerUser shareInstance] setTradePsw:_passWordTextField.text];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                }];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } failedBlock:^(NSError *error) {
            
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        }];

    }
    
}
@end
