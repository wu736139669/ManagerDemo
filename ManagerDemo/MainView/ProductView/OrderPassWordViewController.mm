//
//  OrderPassWordViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "OrderPassWordViewController.h"
#import "UPPayPlugin.h"
#import "AuthenticationViewController.h"
#import "OpenUDID.h"
#import "YiBaoMessageViewController.h"
@interface OrderPassWordViewController ()

@end

@implementation OrderPassWordViewController

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
    
    _passwordTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_passwordTextField];
    
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_completeBtn.frame] forState:UIControlStateDisabled];
    
    if(_type == 1){
        _cardNoLabel.hidden = NO;
        _cardNoLabel.text = [NSString stringWithFormat:@"尾数后四位为%@的银行卡",[_cardNo substringFromIndex:_cardNo.length-4]];
        
    }else{
        _cardNoLabel.hidden = YES;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_passwordTextField resignFirstResponder];
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (range.location > 15)
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    
    if ([_passwordTextField.text isEqualToString:@""]) {
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
    
    if(_type == 1){
        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_amount],@"amount", [ManagerUtil md5:_passwordTextField.text],@"tradePsw",_proId, @"proId",  _cardNo, @"cardNo",[NSNumber numberWithInteger:3],@"terminaltype",@"192.168.1.1",@"userip",[OpenUDID value],@"terminalid",[NSString stringWithFormat:@"%d",3],@"payType",@"",@"bankName",[NSNumber numberWithInteger:_bindid],@"bindid",nil] withApiType:@"buyProductYb" completionBlock:^(id jsonRes) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            }else if([[jsonRes objectForKey:@"resultflag"] integerValue] == 3){
                YiBaoMessageViewController* yibaoMessageViewController = [[YiBaoMessageViewController alloc] init];
                [self.navigationController pushViewController:yibaoMessageViewController animated:YES];
            }else if([[jsonRes objectForKey:@"resultflag"] integerValue] == 0){
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
                
            }
        } failedBlock:^(NSError *error) {
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
        }];
    }else{
        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_amount],@"amount", [ManagerUtil md5:_passwordTextField.text],@"tradePsw",_proId, @"proId", nil] withApiType:@"buyProduct" completionBlock:^(id jsonRes) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            }else if([[jsonRes objectForKey:@"resultflag"] integerValue] == 2){
                AuthenticationViewController* authenticationViewController = [[AuthenticationViewController alloc] init];
                [self.navigationController pushViewController:authenticationViewController animated:YES];
            }else if([[jsonRes objectForKey:@"resultflag"] integerValue] == 0){
                NSString* tn = [jsonRes objectForKey:@"tn"];
                if (tn) {
                    [UPPayPlugin startPay:tn mode:@"00" viewController:self delegate:self];
                }
                
                
            }
        } failedBlock:^(NSError *error) {
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
        }];
    }

}
#pragma mark UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    if ([result isEqualToString:@"success"]) {
        [MBProgressHUD errorHudWithView:self.view label:@"投标成功" hidesAfter:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0),
                       dispatch_get_main_queue(), ^(){
                           [self.navigationController popToRootViewControllerAnimated:YES];
                       });
        
    }else if([result isEqualToString:@"cancel"]){
        [MBProgressHUD errorHudWithView:self.view label:@"取消支付" hidesAfter:1.0];
    }else{
        [MBProgressHUD errorHudWithView:self.view label:result hidesAfter:1.0];
    }
    
}
@end
