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
#import "CardSelectViewController.h"
@interface MainOrderViewController ()

@end

@implementation MainOrderViewController

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
    self.navigationItem.title = @"投标";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_orderAmountTextField];
    _orderAmountTextField.delegate = self;
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_completeBtn.frame] forState:UIControlStateDisabled];
    
    _nameLabel.text = _productName;
    _startBuyLabel.text = [NSString stringWithFormat:@"%ld元",_startBuy];
    if (_type == 0) {
        _timeLimit.text = [NSString stringWithFormat:@"限%ld个月",_timeLimitNum];
        _infoLabel.hidden = NO;
        _infoLabel.text = [NSString stringWithFormat:@"投标金额:%ld的整数倍",_startBuy];
        _orderAmountTextField.placeholder = [NSString stringWithFormat:@"投标金额≥%ld",_startBuy];
    }else{
        _timeLimit.text = @"随买随卖";
        _orderAmountTextField.placeholder = @"建议100元以上，以便收益计算";
        _infoLabel.hidden = YES;
    }

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
    if ([textField.text isEqualToString:@""] || [textField.text integerValue]%_startBuy != 0) {
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
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"hasTradePsw" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
                SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
                setPassWordViewController.type = 1;
                [self.navigationController pushViewController:setPassWordViewController animated:YES];
            });
            
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            CardSelectViewController* cardSelectViewController = [[CardSelectViewController alloc] init];
            cardSelectViewController.amount = [_orderAmountTextField.text integerValue];
            cardSelectViewController.proId = _productId;
            [self.navigationController pushViewController:cardSelectViewController animated:YES];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
    
}
@end
