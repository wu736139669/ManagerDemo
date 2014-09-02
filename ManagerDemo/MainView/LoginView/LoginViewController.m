//
//  LoginViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "LoginViewController.h"
#import "InputPassWordViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.navigationItem.title = @"填写手机号码";
    
    //定制输入框
    UIView* leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView* phoneImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    phoneImgView.center = leftView.center;
    [leftView addSubview:phoneImgView];
    _phoneTextField.leftView = leftView;
    _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    _phoneTextField.layer.masksToBounds=YES;
    _phoneTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _phoneTextField.layer.borderWidth= 1.0f;
    _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_phoneTextField];
    _phoneTextField.delegate = self;
    
    _sureBtn.enabled = NO;
    [_sureBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_sureBtn.frame] forState:UIControlStateDisabled];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(popViewController)];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [_phoneTextField resignFirstResponder];
    if (_phoneLabel.hidden == NO) {
        _phoneLabel.hidden = YES;
        CGRect frame = _infoView.frame;
        frame.origin.y -= 40;
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
            _infoView.frame = frame;
        } completion:^(BOOL finished)
         {
             
         }];
    }
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _phoneTextField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if (range.location >= 11)
        return NO; // return NO to not change text

    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{

    UITextField* textField = [sender object];
    if ([textField.text isEqualToString:@""]) {
        if (_phoneLabel.hidden == NO) {
            CGRect frame = _infoView.frame;
            frame.origin.y -= 40;
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
                _infoView.frame = frame;
            } completion:^(BOOL finished)
             {

             }];
            _phoneLabel.hidden = YES;
            _sureBtn.enabled = NO;
        }
        
    }else{
        if (_phoneLabel.hidden == YES) {
            CGRect frame = _infoView.frame;
            frame.origin.y += 40;
            [UIView animateWithDuration:0.5 delay:0 options:0 animations:^(){
                _infoView.frame = frame;
            } completion:^(BOOL finished)
             {

             }];
            _phoneLabel.hidden = NO;
            _sureBtn.enabled = YES;
        }
        


    }
    
    NSMutableString* tempStr = [[NSMutableString alloc] initWithString:textField.text];
    if (tempStr.length > 7) {
        [tempStr insertString:@" " atIndex:7];
    }
    if (tempStr.length > 3) {
        [tempStr insertString:@" " atIndex:3];
    }

    _phoneLabel.text = tempStr;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}
-(void)popViewController
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sureBtnClick:(id)sender {
    InputPassWordViewController* inputPassWordViewController = [[InputPassWordViewController alloc] init];
    inputPassWordViewController.hidesBottomBarWhenPushed = YES;
    inputPassWordViewController.delegate = self;
    inputPassWordViewController.phoneNum = _phoneTextField.text;
    [self.navigationController pushViewController:inputPassWordViewController animated:YES];
}

#pragma mark InputPassWordViewControllerDelegate
-(void)loginSuccess
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
