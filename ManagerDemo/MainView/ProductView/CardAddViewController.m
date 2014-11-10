//
//  CardAddViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14/11/9.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "CardAddViewController.h"
#import "OrderPassWordViewController.h"
#import "CardBindViewController.h"
@interface CardAddViewController ()

@end

@implementation CardAddViewController

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
    self.navigationItem.title = @"输入银行卡";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    switch (indexPath.section) {
        case 0:
            _cardTableViewCell.textLabel.text = @"卡号";
            return _cardTableViewCell;
            break;
            case 1:
            return _nextTableViewCell;
            break;
        default:
            return cell;
            break;
    }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextBtnClick:(id)sender {
    if ([_cardTextField.text isEqualToString:@""]) {
        [MBProgressHUD errorHudWithView:self.view label:@"请输入卡号" hidesAfter:1.0];
        return;
    }
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:@{@"cardNo": _cardTextField.text} withApiType:@"bankCardCheck" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
            });
            
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if([[jsonRes objectForKey:@"resultflag"] integerValue] == 2){
                CardBindViewController* cardBindViewController = [[CardBindViewController alloc] init];
                cardBindViewController.amount = _amount;
                cardBindViewController.proId = _proId;
                cardBindViewController.cardNo = _cardTextField.text;
                cardBindViewController.type = [[jsonRes objectForKey:@"cardtype"] integerValue];
                [self.navigationController pushViewController:cardBindViewController animated:YES];
            }else{
                OrderPassWordViewController* orderPassWordViewController = [[OrderPassWordViewController alloc] init];
                orderPassWordViewController.amount = _amount;
                orderPassWordViewController.proId = _proId;
                orderPassWordViewController.type = 1;
                orderPassWordViewController.cardNo = _cardTextField.text;
                orderPassWordViewController.bindid = [[jsonRes objectForKey:@"bindid"] integerValue];
                [self.navigationController pushViewController:orderPassWordViewController animated:YES];
            }
           
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
}
@end
