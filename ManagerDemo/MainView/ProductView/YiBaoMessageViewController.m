//
//  YiBaoMessageViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14/11/10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "YiBaoMessageViewController.h"

@interface YiBaoMessageViewController ()

@end

@implementation YiBaoMessageViewController

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
    self.navigationItem.title = @"短信验证";
    
    _orderId.leftViewMode = UITextFieldViewModeAlways;
    _orderId.layer.masksToBounds=YES;
    _orderId.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _orderId.layer.borderWidth= 1.0f;
    _orderId.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_orderId];
    _orderId.delegate = self;
    
    _ybVerCode.leftViewMode = UITextFieldViewModeAlways;
    _ybVerCode.layer.masksToBounds=YES;
    _ybVerCode.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _ybVerCode.layer.borderWidth= 1.0f;
    _ybVerCode.clearButtonMode = UITextFieldViewModeWhileEditing;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_ybVerCode];
    _ybVerCode.delegate = self;
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_completeBtn.frame] forState:UIControlStateDisabled];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesMoved:touches withEvent:event];
    [_orderId resignFirstResponder];
    [_ybVerCode resignFirstResponder];
    _orderId.layer.borderColor = [[UIColor grayColor] CGColor];
    _ybVerCode.layer.borderColor = [[UIColor grayColor] CGColor];
    
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _orderId.layer.borderColor = [[UIColor grayColor] CGColor];
    _ybVerCode.layer.borderColor = [[UIColor grayColor] CGColor];
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
    
    if ([_orderId.text isEqualToString:@""] || [_ybVerCode.text isEqualToString:@""] ) {
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
    [daiDaiTongTestApi getApiWithParam:@{@"orderid": _orderId.text,@"ybVerCode":_ybVerCode.text} withApiType:@"ybConfirmPay" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];

        }else{
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];

}
@end
