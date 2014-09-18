//
//  MainOrderViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MainOrderViewController.h"
#import "OrderPassWordViewController.h"
#import "SetPassWordViewController.h"
@interface MainOrderViewController ()

@end

@implementation MainOrderViewController

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
    self.navigationItem.title = @"投标";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_orderAmountTextField];
    _orderAmountTextField.delegate = self;
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_completeBtn.frame] forState:UIControlStateDisabled];
    
    _nameLabel.text = _productName;
    _startBuyLabel.text = [NSString stringWithFormat:@"%ld元",_startBuy];
    _timeLimit.text = [NSString stringWithFormat:@"限%ld个月",_timeLimitNum];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_orderAmountTextField resignFirstResponder];
 
        CGRect frame = _backgroudView.frame;
        frame.origin.y = 0;
        [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
            _backgroudView.frame = frame;
        } completion:^(BOOL finished)
         {
             
         }];
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect frame = _backgroudView.frame;
    frame.origin.y = -120;
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
        _backgroudView.frame = frame;
    } completion:^(BOOL finished)
     {
         
     }];
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
    if ([textField.text isEqualToString:@""] || [textField.text integerValue]%50 != 0) {
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
    if ([ManagerUser shareInstance].tradePsw.length>0) {
        OrderPassWordViewController* orderPassWordViewController = [[OrderPassWordViewController alloc] init];
        orderPassWordViewController.amount = [_orderAmountTextField.text integerValue];
        orderPassWordViewController.proId = _productId;
        [self.navigationController pushViewController:orderPassWordViewController animated:YES];
    }else{
        SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
        setPassWordViewController.type = 1;
        [self.navigationController pushViewController:setPassWordViewController animated:YES];
    }
}
@end
