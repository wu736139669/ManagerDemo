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
@interface MyViewController ()

@end

@implementation MyViewController

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
    [self.navigationItem setTitle:@"第三页"];
    [ManagerUtil SetSubViewExternNone:self];
    
    //左边按钮
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"左边按钮" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    
    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarBtnClick:)]];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    

    
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

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
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

    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.text = @"吴盛华";
            cell.imageView.image = [UIImage imageNamed:@"icon_person_take_image"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"13212312313";
        }
            break;
        case 1:
        {
            cell.backgroundColor = [UIColor redColor];
            UILabel* timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 320, 30)];
            timeLabel.textColor = [UIColor whiteColor];
            timeLabel.font = Font_Black(15);
            timeLabel.textAlignment = NSTextAlignmentCenter;
            timeLabel.text = @"08月12日收益(元)";
            [cell addSubview:timeLabel];
            UILabel* profitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 100)];
            profitLabel.textColor = [UIColor whiteColor];
            profitLabel.font = Font_Black(50);
            profitLabel.textAlignment = NSTextAlignmentCenter;
            profitLabel.text = @"100.04";
            [cell addSubview:profitLabel];
        }
            break;
        case 2:
        {
            CGRect frmae = cell.frame;
            frmae.size.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            MyTotalProfitCellView* myTotalProfitCellView = [[MyTotalProfitCellView alloc] initWithFrame:frmae];
            [cell addSubview:myTotalProfitCellView];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"我是超人";
            cell.textLabel.textColor = [UIColor grayColor];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"我是超人";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"100分";
        }
            break;
        default:
            break;
    }

    cell.selectedBackgroundView = [ManagerUtil selectBackgroudViewWithFrame:CGRectMake(0, 0, 320, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
