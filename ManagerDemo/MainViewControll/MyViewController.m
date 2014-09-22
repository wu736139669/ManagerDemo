//
//  MyViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MyViewController.h"
#import "MyTotalProfitCellView.h"
#import "MJRefresh.h"
#import "AccountInfoViewController.h"
#import "DailyProfitViewController.h"
#import "MessageCenterViewController.h"
#import "MyTotalAmountViewController.h"
#import "HelpCenterViewController.h"
#import "TransactionRecordsViewController.h"
@interface MyViewController ()
{
    NSDictionary* _myInfoDic;
    MyTotalProfitCellView* _myTotalProfitCellView;
    UILabel* _timeLabel;
    UILabel* _profitLabel;
    float _todayProfit;
}
@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _myInfoDic = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationItem setTitle:@"我的"];
    [ManagerUtil SetSubViewExternNone:self];
    
    _todayProfit = 0.0;
    //左边按钮
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"帮助" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    
    //右边按钮。

    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_email"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarBtnClick:)]];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self headerRereshing];

    
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
//    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
//    [daiDaiTongApi getAccountInfoWithcompletionBlock:^(id jsonRes) {
//        
//        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
//            _myInfoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
//        }
//        [_tableView reloadData];
//        [_tableView headerEndRefreshing];
//    } failedBlock:^(NSError *error) {
//        [MBProgressHUD errorHudWithView:self.view label:Net_Error_Str hidesAfter:0.5];
//        [_tableView reloadData];
//        [_tableView headerEndRefreshing];
//    }];
    
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"userMsg" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] != 0) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
            [ManagerUtil presentLoginView];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            _myInfoDic = [NSDictionary dictionaryWithDictionary:jsonRes];

        }
        [_tableView reloadData];
    } failedBlock:^(NSError *error) {
    }];
    

    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"todayProfit" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] != 0) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            _todayProfit = [[jsonRes objectForKey:@"todayProfit"] floatValue];
            
        }
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_myInfoDic) {
        return 5;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        case 3:
        case 4:
            return 44.0;
            break;
        case 1:
            return 140;
            break;
            case 2:
        return 80;
            break;
        default:
            break;
    }
    return 44.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* cellIdentifier = [NSString stringWithFormat:@"cell%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        switch (indexPath.section) {

            case 1:
            {
                cell.backgroundColor = [UIColor redColor];
                _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 320, 30)];
                _timeLabel.textColor = [UIColor whiteColor];
                _timeLabel.font = Font_Black(15);
                _timeLabel.textAlignment = NSTextAlignmentCenter;
                [cell addSubview:_timeLabel];
                _profitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 100)];
                _profitLabel.textColor = [UIColor whiteColor];
                _profitLabel.font = Font_Black(50);
                _profitLabel.textAlignment = NSTextAlignmentCenter;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:_profitLabel];
            }
                break;
            case 2:
            {
                CGRect frmae = cell.frame;
                frmae.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
                cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
                _myTotalProfitCellView = [[MyTotalProfitCellView alloc] initWithFrame:frmae];
                _myTotalProfitCellView.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:_myTotalProfitCellView];
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"交易记录";
                cell.detailTextLabel.text = @"查看记录";
                cell.textLabel.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView.backgroundColor = Touch_BackGroudColor;
            }
                break;
            case 4:
            {
                cell.textLabel.text = @"总积分";
                cell.textLabel.textColor = [UIColor grayColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectedBackgroundView.backgroundColor = Touch_BackGroudColor;
            }
                break;
            default:
                break;
        }

    }
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = [[_myInfoDic objectForKey:@"userMsg"] objectForKey:@"userName"];
            cell.imageView.image = [UIImage imageNamed:@"icon_person_take_image"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.detailTextLabel.text = [[_myInfoDic objectForKey:@"info"] objectForKey:@"cell"];
            cell.selectedBackgroundView.backgroundColor = Touch_BackGroudColor;
        }
            break;
        case 1:
        {
            NSDate *  senddate=[NSDate date];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"MM月dd日"];
            
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            _timeLabel.text = [NSString stringWithFormat:@"%@收益(元)",locationString];
            _profitLabel.text = [NSString stringWithFormat:@"%.2f",_todayProfit];
        }
            break;
        case 2:
        {
            _myTotalProfitCellView.totalMoneyLabel.text = [[[_myInfoDic objectForKey:@"userMsg"] objectForKey:@"totalAssets"] stringValue];
            _myTotalProfitCellView.profitMoneyLabel.text = [[[_myInfoDic objectForKey:@"userMsg"] objectForKey:@"totalProfit"] stringValue];
        }
            break;
        case 4:
        {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分",[[[_myInfoDic objectForKey:@"userMsg"] objectForKey:@"totalIntegral"] stringValue]];

        }
            break;
        default:
            break;
    }

    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:
        {
            AccountInfoViewController* accountInfoViewController = [[AccountInfoViewController alloc] init];
            accountInfoViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:accountInfoViewController animated:YES];
        }
            break;
        case 1:
        {
            DailyProfitViewController* dailyProfitViewController = [[DailyProfitViewController alloc] initWithNibName:@"BaseListViewController" bundle:nil];
            dailyProfitViewController.hidesBottomBarWhenPushed = YES;
            dailyProfitViewController.profitDate = [_myInfoDic objectForKey:@"profitDate"];
            [self.navigationController pushViewController:dailyProfitViewController animated:YES];
        }
            break;
        case 3:
        {
            TransactionRecordsViewController* transactionRecordsViewController = [[TransactionRecordsViewController alloc] init];
            transactionRecordsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:transactionRecordsViewController animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - MyTotalProfitCellViewDelegate
-(void)totalMoneyClick
{
    MyTotalAmountViewController* myTotalAmountViewController = [[MyTotalAmountViewController alloc] init];
    myTotalAmountViewController.hidesBottomBarWhenPushed = YES;
    [myTotalAmountViewController setTotalAmount:[[_myInfoDic objectForKey:@"totalAmount"] floatValue] withHoldAmount:[[_myInfoDic objectForKey:@"holdAmount"] floatValue] withAccBalance:[[_myInfoDic objectForKey:@"accBalance"] floatValue]];
    [self.navigationController pushViewController:myTotalAmountViewController animated:YES];
}
#pragma mark - UIBarButtonClick   导航条两边按钮
-(void)leftBarBtnClick:(id)sender
{
    HelpCenterViewController* helpCenterViewController = [[HelpCenterViewController alloc] initWithNibName:@"BaseListViewController" bundle:nil];
    helpCenterViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:helpCenterViewController animated:YES];
    
}
-(void)rightBarBtnClick:(id)sender
{
    MessageCenterViewController* messageCenterViewController = [[MessageCenterViewController alloc] init];

    messageCenterViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageCenterViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
