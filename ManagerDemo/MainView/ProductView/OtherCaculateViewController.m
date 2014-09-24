//
//  OtherCaculateViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-24.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "OtherCaculateViewController.h"

@interface OtherCaculateViewController ()

@end

@implementation OtherCaculateViewController

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
    self.navigationItem.title = @"预估收益";
    _tableView.tableHeaderView = _headView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _amountTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_amountTextField];
    _timeTextField.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_timeTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _caculateBtn.enabled = NO;
    _caculateBtn.backgroundColor = [UIColor grayColor];
    [self initData];
    [self caculateBtnClick:nil];
}
-(void)initData
{
    //    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    //    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    //    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:@"10000",@"money", @"365", @"days", _productId, @"proId",nil] withApiType:@"estimateJjProfit" completionBlock:^(id jsonRes) {
    //        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
    //            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
    //        }else{
    //
    //        }
    //    } failedBlock:^(NSError *error) {
    //        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    //    }];
    
    _nameLabel.text = _name;
    _profit1Label.text = [NSString stringWithFormat:@"%.2f元",[self caculateProfit:10000 withDay:365]];
    _profit3Label.text = [NSString stringWithFormat:@"%.2f元",[self caculateProfit:10000 withDay:365*3]];
    _profit5Label.text = [NSString stringWithFormat:@"%.2f元",[self caculateProfit:10000 withDay:365*5]];
    _profit7Label.text = [NSString stringWithFormat:@"%.2f元",[self caculateProfit:10000 withDay:365*7]];
    
}
-(float)caculateProfit:(NSInteger)amount withDay:(NSInteger)dayTotal
{
    NSInteger tempDay = dayTotal;
    float proFit = 0.0;
    while (tempDay>0) {
        if (tempDay>=365) {
            proFit += _qrnh*(amount+proFit);
        }else{
            proFit += _qrnh*(amount+proFit)*(tempDay/365.0);
        }
        tempDay -= 365;
    }
    return proFit;
}
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
        CGRect frame = _tableView.frame;
        frame.origin.y -= 120;
        _tableView.frame = frame;
    } completion:^(BOOL finished)
     {
         
     }];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 delay:0 options:0 animations:^(){
        CGRect frame = _tableView.frame;
        frame.origin.y += 120;
        _tableView.frame = frame;
    } completion:^(BOOL finished)
     {
         
     }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_timeTextField resignFirstResponder];
    [_amountTextField resignFirstResponder];
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([textField.text length] >= 7)
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    if ([_amountTextField.text isEqualToString:@""] || [_timeTextField.text isEqualToString:@""]) {
        _caculateBtn.enabled = NO;
        _caculateBtn.backgroundColor = [UIColor grayColor];
    }else{
        _caculateBtn.enabled = YES;
        _caculateBtn.backgroundColor = [UIColor redColor];
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
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

- (IBAction)caculateBtnClick:(id)sender {
    if ([_amountTextField.text isEqualToString:@""] && [_timeTextField.text isEqualToString:@""]) {
        _ygsyLabel.text = [NSString stringWithFormat:@"%.2f 元",_qrnh*10000];
        _jfsyLabel.text = [NSString stringWithFormat:@"%.0f 分",10000*_extraPoint];
    }else{
        NSInteger amount = [_amountTextField.text intValue];
        NSInteger time = [_timeTextField.text intValue];
        _ygsyLabel.text = [NSString stringWithFormat:@"%.2f 元",[self caculateProfit:amount withDay:time]];
        _jfsyLabel.text = [NSString stringWithFormat:@"%.0f 分",_extraPoint * amount * (time/365.0)];
    }
}
@end
