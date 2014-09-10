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
{
    NSDictionary* _infoDic;
    WYDInfoHeadView* _wydInfoHedaView;
}
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"WYDInfoHeadView" owner:self options:nil];
    _wydInfoHedaView = (WYDInfoHeadView*)[nib objectAtIndex:0];
    _tableView.tableHeaderView = _wydInfoHedaView;
    
    //加入刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(headerBeginRefreshing)]];
    [self headerBeginRefreshing];
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getFundDetailWithFundId:_productId withCompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            self.navigationItem.title = [jsonRes objectForKey:@"fundName"];
            [_wydInfoHedaView setInfoWithDic:jsonRes];
            _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
            [self.tableView reloadData];
        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }

        [self.tableView headerEndRefreshing];
    } failedBlock:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];

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
    if (_infoDic) {
        return ((NSArray*)[_infoDic objectForKey:@"items"]).count + 1;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }else{
        DTAttributedTextCell* cell = [[DTAttributedTextCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        [cell setHTMLString:[[((NSArray*)[_infoDic objectForKey:@"items"]) objectAtIndex:indexPath.section-1] objectForKey:@"itemDesc"]];
        cell.hasFixedRowHeight = YES;
        cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(10, 15, 0, 15);
        return [cell.attributedTextContextView suggestedFrameSizeToFitEntireStringConstraintedToWidth:300].height+15;
    }

    return 40;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIDentifier = [NSString stringWithFormat:@"CellIDentifier%ld-%ld",indexPath.section,indexPath.row];
    DTAttributedTextCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIDentifier];
    if (!cell) {
        cell = [[DTAttributedTextCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIDentifier];

    }
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.text = @"已投标人数:";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@人",[_infoDic objectForKey:@"ygrs"]];
    }else{
        [cell setHTMLString:[[((NSArray*)[_infoDic objectForKey:@"items"]) objectAtIndex:indexPath.section-1] objectForKey:@"itemDesc"]];
        cell.hasFixedRowHeight = YES;
        cell.attributedTextContextView.edgeInsets = UIEdgeInsetsMake(10, 15, 0, 15);
    }
      return cell;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(0, 0, 320, 30)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, view.frame.size.width-10, view.frame.size.height)];
    label.font = [UIFont systemFontOfSize:13];
    if (section == 0) {
        label.text = @"投标情况";
    }else{
        label.text = [[((NSArray*)[_infoDic objectForKey:@"items"]) objectAtIndex:section-1] objectForKey:@"itemName"];
    }
    [view addSubview:label];
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = [ManagerUtil lineWithColor:[UIColor clearColor] withAlpha:1.0 withFrame:CGRectMake(0, 0, 320, 1)];
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
