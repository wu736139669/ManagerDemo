//
//  WYDProductViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-15.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "WYDProductViewController.h"
#import "WYDInfoHeadView.h"
#import "MJRefresh.h"
@interface WYDProductViewController ()

@end

@implementation WYDProductViewController

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
    [ManagerUtil SetSubViewExternNone:self];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"WYDInfoHeadView" owner:self options:nil];
    WYDInfoHeadView* wydInfoHedaView = (WYDInfoHeadView*)[nib objectAtIndex:0];
    _tableView.tableHeaderView = wydInfoHedaView;
    
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
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }
    switch (indexPath.section) {
        case 0:
            return 40;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 40;
            break;
        case 3:
            return 40;
            break;
        default:
            break;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIDentifier = [NSString stringWithFormat:@"CellIDentifier%d-%d",indexPath.section,indexPath.row];
    DTAttributedTextCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIDentifier];
    if (!cell) {
        cell = [[DTAttributedTextCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIDentifier];

    }
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            cell.textLabel.text = @"已投标人数:";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
            cell.detailTextLabel.text = @"255人";
        }
            break;
        case 1:
        {
            [cell setHTMLString:@"活动期间，新手首次申购，买50元及以上送20元现金红包。<br>注：新手特指从未申购过稳盈贷产品的用户；每个新手只享受一次20元现金红包奖励；红包奖励将在募集成功后下一个工作日发放到账户余额。"];
            cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
        }
            break;
        case 2:
        {
            [cell setHTMLString:@"上海**金属制品有限公司法定代表人为资金周转，以个人名义申请借款。"];
            cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
        }
            break;
        case 3:
        {
            [cell setHTMLString:@"浙江巨业担保有限公司全额本息保证"];
            cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(15, 15, 5, 15);
        }
            break;
        default:
            break;
    }
    return cell;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(0, 0, 320, 30)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.frame.size.width-10, view.frame.size.height)];
    label.font = [UIFont systemFontOfSize:13];
    switch (section) {
        case 0:
            label.text = @"投标情况";
            break;
        case 1:
            label.text = @"申购奖励";
            break;
        case 2:
            label.text = @"项目描述";
            break;
        case 3:
            label.text = @"资金保障";
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
    return 30.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
