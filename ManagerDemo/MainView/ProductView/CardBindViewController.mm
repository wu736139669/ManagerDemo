//
//  CardBindViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14/11/10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "CardBindViewController.h"
#import "IPGet.h"
#import "OpenUDID.h"
#import "YiBaoMessageViewController.h"
@interface CardBindViewController ()

@end

@implementation CardBindViewController

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
    self.navigationItem.title = @"银行卡信息";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pwdTextField.delegate = self;
    
    if (_type == 1) {
        self.navigationItem.title = @"银行卡信息";
        _firstTableViewCell.textLabel.text = @"身份证";
        _secondTableViewCell.textLabel.text = @"姓名";
        _thirdTableViewCell.textLabel.text = @"手机号";
    }
    else if(_type==2){
        self.navigationItem.title = @"信用卡信息";
        _firstTableViewCell.textLabel.text = @"有效期";
        _secondTableViewCell.textLabel.text = @"cvv2";
        _thirdTableViewCell.textLabel.text = @"手机号";
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section == 2) {
        return _nextTableViewCell;
    }else if (indexPath.section == 1) {
        return _pwdTableViewCell;
    }else if(indexPath.section == 0){
        if (indexPath.row == 0) {
            
            return _firstTableViewCell;
        }
        if (indexPath.row == 1) {
            
            return _secondTableViewCell;
        }
        if (indexPath.row == 2) {
            
            return _thirdTableViewCell;
        }
    }
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (_type == 1) {
            return @"输入银行卡信息";
        }else if(_type == 2)
        {
           return @"输入信用卡信息";
        }
        
    }
    return @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGRect frame = _tableView.frame;
    frame.origin.y = -120;
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
        _tableView.frame = frame;
    } completion:^(BOOL finished)
     {
         
     }];
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = _tableView.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
        _tableView.frame = frame;
    } completion:^(BOOL finished)
     {
         
     }];

    [_firstTextField resignFirstResponder];
    [_secondTextField resignFirstResponder];
    [_thirdTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}
- (IBAction)nextBtnClick:(id)sender {
    
    if (_firstTextField.text.length<=0 || _secondTextField.text.length<=0 || _thirdTextField.text.length<=0 ||
        _pwdTextField.text.length<=0) {
        [MBProgressHUD errorHudWithView:self.view label:@"请输入完整信息" hidesAfter:1.0];
    }
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_amount],@"amount", [ManagerUtil md5:_pwdTextField.text],@"tradePsw",_proId, @"proId",  _thirdTextField.text,@"phone",_cardNo, @"cardNo",_firstTextField.text,@"idcard",_secondTextField.text,@"name",[NSNumber numberWithInteger:3],@"terminaltype",@"192.168.1.1",@"userip",[OpenUDID value],@"terminalid",[NSString stringWithFormat:@"%ld",_type],@"payType",_firstTextField.text,@"validthru",_secondTextField.text,@"cvv2",@"",@"bankName",nil] withApiType:@"buyProductYb" completionBlock:^(id jsonRes) {
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
    [self getIPAddress];

}
- (void)getIPAddress
{
    InitAddresses();
    GetIPAddresses();
    GetIPAddresses();
    
    int i;
    NSString *deviceIP = nil;
    for (i=0; i<MAXADDRS; ++i)
    {
        static unsigned long localHost = 0x7F000001;            // 127.0.0.1
        unsigned long theAddr;
        
        theAddr = ip_addrs[i];
        
        if (theAddr == 0) break;
        if (theAddr == localHost) continue;
        
        NSLog(@"Name: %s MAC: %s IP: %s\n", if_names[i], hw_addrs[i], ip_names[i]);
    }
}
@end
