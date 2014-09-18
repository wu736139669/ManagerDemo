//
//  FundCaculateViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundCaculateViewController.h"

@interface FundCaculateViewController ()

@end

@implementation FundCaculateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _qrnh = 0.0;
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
    _nameLabel.text = _name;
    _ygsy1Label.text = [NSString stringWithFormat:@"%.2f元",_qrnh*10000*1/365];
    _ygsy7Label.text = [NSString stringWithFormat:@"%.2f元",_qrnh*10000*7/365];
    _ygsy30Label.text = [NSString stringWithFormat:@"%.2f元",_qrnh*10000*30/365];
    _ygsy90Label.text = [NSString stringWithFormat:@"%.2f元",_qrnh*10000*90/365];
    _ygsy365Label.text = [NSString stringWithFormat:@"%.2f元",_qrnh*10000*365/365];
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
        _yhhqsyLabel.text = [NSString stringWithFormat:@"%.2f 元",0.0035*10000];
    }else{
        NSInteger amount = [_amountTextField.text intValue];
        NSInteger time = [_timeTextField.text intValue];
        _ygsyLabel.text = [NSString stringWithFormat:@"%.2f 元",_qrnh*amount*time/365];
        _yhhqsyLabel.text = [NSString stringWithFormat:@"%.2f 元",0.0035*amount*time/365];
    }
}
@end
