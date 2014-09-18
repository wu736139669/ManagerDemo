//
//  OtherProductInfoViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-28.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "OtherProductInfoViewController.h"
#import "MJRefresh.h"
#import "FundCaculateViewController.h"
@interface OtherProductInfoViewController ()

@end

@implementation OtherProductInfoViewController

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
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _toolBarView.delegate = self;
    //加入刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(headerBeginRefreshing)]];

}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}
- (void)headerBeginRefreshing
{
    [self.tableView headerBeginRefreshing];
}
-(void)headerEndRefreshing
{
    [self.tableView headerEndRefreshing];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(0, 0, 320, 30)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.frame.size.width-10, view.frame.size.height)];
    label.font = [UIFont systemFontOfSize:13];
    switch (section) {
        case 0:
            return nil;
            break;
        case 1:
            label.text = @"申购情况";
            break;
        case 2:
            label.text = @"业绩";
            break;
        case 3:
            label.text = @"安全";
            break;
        case 4:
            label.text = @"关于";
            break;
        default:
            break;
    }
    [view addSubview:label];
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(0, 0, 320, 1)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1.0;
    }
    return 30.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.section) {
        case 0:
        {
            height = _headCell.frame.size.height;
        }
            break;
        case 1:
        {
            height = _stateInfoCell.frame.size.height;
        }
            break;
        case 2:
        {
            height = _resultsInfoCell.frame.size.height;
        }
            break;
        case 3:
        {
            height = _securityInfoCell.frame.size.height;
        }
            break;
        case 4:
        {
            height = _aboutCell.frame.size.height;
        }
            break;
        default:
            height = 0.0;
            break;
    }
    return height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell;
    switch (indexPath.section) {
        case 0:
        {
            cell = _headCell;
        }
            break;
        case 1:
        {
            cell = _stateInfoCell;
        }
            break;
        case 2:
        {
            cell = _resultsInfoCell;
        }
            break;
        case 3:
        {
            cell = _securityInfoCell;
        }
            break;
        case 4:
        {
            cell = _aboutCell;
        }
            break;
        default:
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
            
            break;
    }
    return cell;
}
#pragma mark ToolBarViewDelegate
-(void)caculateProfit
{
//    FundCaculateViewController* fundCaculateViewController = [[FundCaculateViewController alloc] init];
//    
//    fundCaculateViewController.qrnh = _infoDic;
//    [self.navigationController pushViewController:proFitCaculateViewController animated:YES];
    
}
-(void)buyFund
{
    if (![ManagerUser shareInstance].isLogin) {
        [ManagerUtil presentLoginView];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
