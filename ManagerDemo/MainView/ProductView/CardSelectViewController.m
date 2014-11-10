//
//  CardSelectViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14/11/9.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "CardSelectViewController.h"
#import "OrderPassWordViewController.h"
#import "CardAddViewController.h"
@interface CardSelectViewController ()
{
    NSArray* bankList;
}
@end

@implementation CardSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bankList = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的银行卡";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self initData];
}

-(void)initData
{
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"getBindBankList" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
            });
            
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            bankList = [jsonRes objectForKey:@"bankList"];
            [_tableView reloadData];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];

}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        if(bankList.count>0){
            return bankList.count;
        }
    }
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if(bankList.count == 0){
            cell.textLabel.text = @"还未绑定银行卡";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            NSString* cardNo = [[bankList objectAtIndex:indexPath.row] objectForKey:@"cardNo"];
            cell.textLabel.text = [NSString stringWithFormat:@"尾数后四位为%@的银行卡",[cardNo substringFromIndex:cardNo.length-4]];
            cell.textLabel.font = Font_Black(12);
        }
        
        cell.textLabel.textColor = [UIColor grayColor];
        cell.imageView.image = [UIImage imageNamed:@"daidaitong03"];
        
    }
    if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"daidaitong01"];
    }
    if (indexPath.section == 2) {
        cell.imageView.image = [UIImage imageNamed:@"daidaitong02"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(indexPath.section == 0){
        
        [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
        DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
        [daiDaiTongTestApi getApiWithParam:@{@"cardNo": [[bankList objectAtIndex:indexPath.row] objectForKey:@"cardNo"]} withApiType:@"bankCardCheck" completionBlock:^(id jsonRes) {
            if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
                [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0), dispatch_get_main_queue(), ^{
                });
                
            }else{
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                if([[jsonRes objectForKey:@"resultflag"] integerValue] == 2){
                    OrderPassWordViewController* orderPassWordViewController = [[OrderPassWordViewController alloc] init];
                    orderPassWordViewController.amount = _amount;
                    orderPassWordViewController.proId = _proId;
                    orderPassWordViewController.type = 1;
                    orderPassWordViewController.cardNo = [[bankList objectAtIndex:indexPath.row] objectForKey:@"cardNo"];
                    orderPassWordViewController.bindid = [[jsonRes objectForKey:@"bindid"] integerValue];
                    [self.navigationController pushViewController:orderPassWordViewController animated:YES];
                }

            }
        } failedBlock:^(NSError *error) {
            [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        }];


    }
    if (indexPath.section == 1) {
        CardAddViewController* cardAddViewController = [[CardAddViewController alloc] init];
        cardAddViewController.amount = _amount;
        cardAddViewController.proId = _proId;
        [self.navigationController pushViewController:cardAddViewController animated:YES];
    }
    if (indexPath.section == 2) {
        
        OrderPassWordViewController* orderPassWordViewController = [[OrderPassWordViewController alloc] init];
        orderPassWordViewController.amount = _amount;
        orderPassWordViewController.proId = _proId;
        [self.navigationController pushViewController:orderPassWordViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
