//
//  AuthenticationViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-22.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "AuthenticationViewController.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

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
    self.navigationItem.title = @"身份信息确认";
    
    _nameTextFiel.leftViewMode = UITextFieldViewModeAlways;
    _nameTextFiel.layer.masksToBounds=YES;
    _nameTextFiel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _nameTextFiel.layer.borderWidth= 1.0f;
    _nameTextFiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_nameTextFiel];
    _nameTextFiel.delegate = self;
    
    _numTextField.leftViewMode = UITextFieldViewModeAlways;
    _numTextField.layer.masksToBounds=YES;
    _numTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _numTextField.layer.borderWidth= 1.0f;
    _numTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_numTextField];
    _numTextField.delegate = self;
    
    _sureBtn.enabled = NO;
    [_sureBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_sureBtn.frame] forState:UIControlStateDisabled];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_nameTextFiel resignFirstResponder];
    [_numTextField resignFirstResponder];
    _nameTextFiel.layer.borderColor = [[UIColor grayColor] CGColor];
    _numTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _nameTextFiel.layer.borderColor = [[UIColor grayColor] CGColor];
    _numTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location >= 18)
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    
    if (([_numTextField.text isEqualToString:@""] || [_nameTextFiel.text isEqualToString:@""] ) || _numTextField.text.length!=18) {
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

- (IBAction)sureBtnClick:(id)sender {
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_nameTextFiel.text,@"realName",_numTextField.text,@"idcardNo", nil] withApiType:@"checkRealName" completionBlock:^(id jsonRes) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
    }];
}
@end
