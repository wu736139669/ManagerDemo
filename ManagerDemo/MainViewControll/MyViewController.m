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
#import "DailyIncomeViewController.h"
@interface MyViewController ()
{
    NSDictionary* _myInfoDic;
    MyTotalProfitCellView* _myTotalProfitCellView;
    UILabel* _timeLabel;
    UILabel* _profitLabel;
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
    [self.navigationItem setTitle:@"第三页"];
    [ManagerUtil SetSubViewExternNone:self];
    
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
    

    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getAccountInfoWithcompletionBlock:^(id jsonRes) {
        
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            _myInfoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
        }
        [_tableView reloadData];
        [_tableView headerEndRefreshing];
    } failedBlock:^(NSError *error) {
        
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
                MyTotalProfitCellView* myTotalProfitCellView = [[MyTotalProfitCellView alloc] initWithFrame:frmae];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                [cell addSubview:myTotalProfitCellView];
                myTotalProfitCellView.totalMoneyLabel.text = [_myInfoDic objectForKey:@"totalAmount"];
                myTotalProfitCellView.profitMoneyLabel.text = [_myInfoDic objectForKey:@"totalProfit"];
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
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分",[_myInfoDic objectForKey:@"point"]];
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
            cell.textLabel.text = [[_myInfoDic objectForKey:@"info"] objectForKey:@"realShowName"];
            cell.imageView.image = [UIImage imageNamed:@"icon_person_take_image"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [[_myInfoDic objectForKey:@"info"] objectForKey:@"cell"];
            cell.selectedBackgroundView.backgroundColor = Touch_BackGroudColor;
        }
            break;
        case 1:
        {
            _timeLabel.text = [NSString stringWithFormat:@"%@收益(元)",[_myInfoDic objectForKey:@"profitShowDate"]];
            _profitLabel.text = [_myInfoDic objectForKey:@"datePofit"];
        }
            break;
        case 2:
        {
            CGRect frmae = cell.frame;
            frmae.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            MyTotalProfitCellView* myTotalProfitCellView = [[MyTotalProfitCellView alloc] initWithFrame:frmae];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:myTotalProfitCellView];
            myTotalProfitCellView.totalMoneyLabel.text = [_myInfoDic objectForKey:@"totalAmount"];
            myTotalProfitCellView.profitMoneyLabel.text = [_myInfoDic objectForKey:@"totalProfit"];
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
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分",[_myInfoDic objectForKey:@"point"]];
            cell.selectedBackgroundView.backgroundColor = Touch_BackGroudColor;
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
            [self.navigationController pushViewController:accountInfoViewController animated:YES];
        }
            break;
        case 1:
        {
            DailyIncomeViewController* dailyIncomeViewController = [[DailyIncomeViewController alloc] init];
            [self.navigationController pushViewController:dailyIncomeViewController animated:YES];
        }
            break;
        default:
            break;
    }
}
#pragma mark - UIBarButtonClick   导航条两边按钮
-(void)leftBarBtnClick:(id)sender
{
    DLog(@"首页左边按钮");
}
-(void)rightBarBtnClick:(id)sender
{
    DLog(@"首页右边按钮");
    [_tableView headerBeginRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
