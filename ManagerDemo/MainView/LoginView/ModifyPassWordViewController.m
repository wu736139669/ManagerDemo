//
//  ModifyPassWordViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-25.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ModifyPassWordViewController.h"
#import "SetPassWordViewController.h"
@interface ModifyPassWordViewController ()
{
    BOOL _isRealName;//是否实名
    NSTimer *_timer;
    NSInteger _timeSecond;
}
@end

@implementation ModifyPassWordViewController

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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(popViewController)];
    self.navigationItem.title = @"身份验证";
    _isRealName = YES;
    _timeSecond = 60;
    _cmsBtn.enabled = NO;
    [_cmsBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_cmsBtn.frame] forState:UIControlStateDisabled];
    
    _nextBtn.enabled = NO;
    [_nextBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_nextBtn.frame] forState:UIControlStateDisabled];
    
    _nameTextFiel.layer.masksToBounds=YES;
    _nameTextFiel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _nameTextFiel.layer.borderWidth= 1.0f;
    _nameTextFiel.delegate = self;
    _nameTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_nameTextFiel];
    
    _idCardTextField.layer.masksToBounds=YES;
    _idCardTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _idCardTextField.layer.borderWidth= 1.0f;
    _idCardTextField.delegate = self;
    _idCardTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_idCardTextField];
    
    _cmsNumTextField.layer.masksToBounds=YES;
    _cmsNumTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _cmsNumTextField.layer.borderWidth= 1.0f;
    _cmsNumTextField.delegate = self;
    _cmsNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_cmsNumTextField];
    
    _phoneTextField.text = _phoneNum;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reGetCodeTime) userInfo:nil repeats:YES];
    [_timer invalidate];
    [self realNameCheck];
    
}

-(void)popViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)reGetCodeTime
{
    if (_timeSecond > 0 && !_cmsBtn.enabled) {
        if (![_timer isValid]) {
            [_timer fire];
        }
        [_cmsBtn setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",_timeSecond] forState:UIControlStateDisabled];
        _timeSecond--;
    }else{
        _cmsBtn.enabled = YES;
        _timeSecond = 60;
        [_timer invalidate];
    }
}

-(void)realNameCheck
{
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_phoneNum,@"phoneNum", nil] withApiType:@"realNameCheck" completionBlock:^(id jsonRes) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 0) {
        }else if([[jsonRes objectForKey:@"resultflag"] integerValue] == 1){
            _nameTextFiel.hidden = YES;
            _idCardTextField.hidden = YES;
            CGRect frame = _blackGroudView.frame;
            frame.origin.y -= 100;
            _blackGroudView.frame = frame;
            _isRealName = NO;
        }else{
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        
    }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_phoneTextField resignFirstResponder];
    [_nameTextFiel resignFirstResponder];
    [_idCardTextField resignFirstResponder];
    [_cmsNumTextField resignFirstResponder];
//    if (_phoneLabel.hidden == NO) {
//        _phoneLabel.hidden = YES;
//        CGRect frame = _infoView.frame;
//        frame.origin.y -= 40;
//        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
//            _infoView.frame = frame;
//        } completion:^(BOOL finished)
//         {
//             
//         }];
//    }
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _nameTextFiel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _idCardTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _cmsNumTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_idCardTextField.text.length>=18 && _idCardTextField == textField) {
        return NO;
    }
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    
    if (_isRealName) {
        if (_nameTextFiel.text.length>0 && _idCardTextField.text.length>0) {
            _cmsBtn.enabled = YES;
            if (_cmsNumTextField.text.length>0) {
                _nextBtn.enabled = YES;
            }else{
                _nextBtn.enabled = NO;
            }
        }else{
            _cmsBtn.enabled = NO;
            _nextBtn.enabled = NO;
        }
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

- (IBAction)cmsBtnClick:(id)sender {
    _cmsBtn.enabled = NO;
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    NSDictionary* dic;
    if (_isRealName) {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum,@"phoneNum",_idCardTextField.text,@"idcardNo", _nameTextFiel.text, @"realName", nil];
    }else{
        [NSDictionary dictionaryWithObjectsAndKeys:_phoneNum,@"phoneNum", nil];
    }
    [daiDaiTongTestApi getApiWithParam:dic withApiType:@"getVerCode" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_cmsNumTextField becomeFirstResponder];
            _nameTextFiel.enabled = NO;
            _idCardTextField.enabled = NO;
//            [ManagerUser shareInstance].token = [jsonRes objectForKey:@"token"];
        }
       _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reGetCodeTime) userInfo:nil repeats:YES];
        [_timer fire];
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reGetCodeTime) userInfo:nil repeats:YES];
        [_timer fire];
    }];

}
- (IBAction)nextBtnClick:(id)sender {
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];

    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_cmsNumTextField.text,@"verCode", nil] withApiType:@"getVerCode" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (_type == 0) {
                SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
                [self.navigationController pushViewController:setPassWordViewController animated:YES];
            }else{
                SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
                setPassWordViewController.type = 1;
                [self.navigationController pushViewController:setPassWordViewController animated:YES];
            }
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
}
@end
