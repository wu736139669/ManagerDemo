//
//  ProFitCaculateViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ProFitCaculateViewController.h"

@interface ProFitCaculateViewController ()
@end

@implementation ProFitCaculateViewController

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
    _amountLabel.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:_amountLabel];

    _caculateBtn.enabled = NO;
    _caculateBtn.backgroundColor = [UIColor grayColor];
    [self initData];
    [self cacluteBtnClick:nil];
}



-(void)initWithTotal:(NSString *)total withCode:(NSString *)productCode withTime:(NSString *)time withName:(NSString *)name
{
    _productCode = productCode;
    _total = total;
    _name = name;
    _time = time;

}
-(void)initData;
{
    _nameLabel.text = _name;
    _timeLabel.text = _time;
    _totalAmount.text = [NSString stringWithFormat:@"%.2f元",[_total floatValue]];
}
- (IBAction)cacluteBtnClick:(id)sender
{
    if ( _productCode==nil) {
        return;
    }
    NSString* amount = _amountLabel.text;
    if ([amount isEqualToString:@""]) {
        amount = @"10000";
    }
//    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
//    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:_productCode,@"productCode",amount,@"amount", nil];
//    [daiDaiTongApi postApiWithParam:dic withApiType:@"calcProfit.do" completionBlock:^(id jsonRes) {
//        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
//            _infoLabel.text = [jsonRes objectForKey:@"desc"];
//            _exceptLabel.text = [NSString stringWithFormat:@"%.2f元",[[jsonRes objectForKey:@"pre_profit"] floatValue]];
//            if (_caculateBtn.enabled) {
//                _exceptLabel.textColor = [UIColor redColor];
//            }else{
//                _exceptLabel.textColor = [UIColor grayColor];
//            }
//        }
//    } failedBlock:^(NSError *error) {
//        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
//    }];
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_productCode,@"proId",amount, @"money", nil] withApiType:@"estimateProfit" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];

        }
        else{
            _exceptLabel.text = [NSString stringWithFormat:@"%.2f元",[[jsonRes objectForKey:@"estimateProfit"] floatValue]];
            if (_caculateBtn.enabled) {
                _exceptLabel.textColor = [UIColor redColor];
            }else{
                _exceptLabel.textColor = [UIColor grayColor];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
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
    [_amountLabel resignFirstResponder];
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = [[UIColor orangeColor]CGColor];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([textField.text integerValue] >= [_total integerValue])
        return NO; // return NO to not change text
    
    return YES;
}
-(void)textFieldTextDidChange:(NSNotification *)sender
{
    if ([_amountLabel.text isEqualToString:@""]) {
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

@end
