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
#import "MainOrderViewController.h"
#import "OtherCaculateViewController.h"
@interface OtherProductInfoViewController ()
{
    NSDictionary* _infoDic;
}
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
    [self headerBeginRefreshing];
}

-(void)initData
{
    self.navigationItem.title = [[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"proName"];
    

    _startBuyLabel.text = [[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"startBuy"];
    _qrnhLabel.text = [NSString stringWithFormat:@"%@%%",[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"qrsy"]];
//    _sgrsLabel.text = [[_infoDic objectForKeyWithoutNull:@"detail"] objectForKeyWithoutNull:@"buyPerNum"];
    _wfsyLabel.text = [NSString stringWithFormat:@"%.4f%%",[[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"wfsy"] floatValue]];
    _detailLabel.text = [NSString stringWithFormat:@"额外%@%%积分奖励",[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"extraPoint"]];
    _ygrsLabel.leftTitleLabel.text = @"已申购人数:";
    _ygrsLabel.leftInfoLabel.hidden = YES;
    _ygrsLabel.rightTitleLabel.hidden = YES;
//    _ygrsLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 人",[[_infoDic objectForKeyWithoutNull:@"detail"] objectForKeyWithoutNull:@"buyPerNum"]];
    _gmbsLabel.leftTitleLabel.text = @"购买比数:";
    _gmbsLabel.leftInfoLabel.hidden = YES;
    _gmbsLabel.rightTitleLabel.hidden = YES;
//    _gmbsLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 笔",[[_infoDic objectForKeyWithoutNull:@"detail"] objectForKeyWithoutNull:@"buyNum"]];
    
    _totalAmountLabel.leftTitleLabel.text = @"总申购金额:";
    _totalAmountLabel.leftInfoLabel.hidden = YES;
    _totalAmountLabel.rightTitleLabel.hidden = YES;
    _totalAmountLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%.2f 元",[[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"totalMoney"] floatValue]];
    
    _rjsgLabel.leftTitleLabel.text = @"人均申购金额:";
    _rjsgLabel.leftInfoLabel.hidden = YES;
    _rjsgLabel.rightTitleLabel.hidden = YES;
//    _rjsgLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 元",[[_infoDic objectForKeyWithoutNull:@"detail"] objectForKeyWithoutNull:@"avgMoney"]];
    _profitLabel.leftTitleLabel.text = @"预期年化:";
    _profitLabel.leftInfoLabel.text = [NSString stringWithFormat:@"%@ %%",[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"nhsy"]];
    _profitLabel.rightTitleLabel.text = @"万份收益:";
    _profitLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@元",[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"wfsy"]];
  
    _comPanyNameLabel.leftTitleLabel.text = @"销售公司:";
    _comPanyNameLabel.leftInfoLabel.text = [[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"comName"];
    _comPanyNameLabel.rightTitleLabel.text = @"理财类型:";
    _comPanyNameLabel.rightInfoLabel.text = [[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"saleComName"];
    
}

#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_productId,@"proId", nil] withApiType:@"proDetail" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 0) {
            self.navigationItem.title = [jsonRes objectForKey:@"fundName"];
            _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
            if ([[[jsonRes objectForKey:@"proInfo"] objectForKey:@"state"] integerValue] == 1) {
                [_toolBarView setEnable:YES];
            }else{
                [_toolBarView setEnable:NO];
            }
        }else{
            
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
        [self.tableView reloadData];
        [self initData];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark ToolBarViewDelegate
-(void)caculateProfit
{
    OtherCaculateViewController* otherCaculateViewController = [[OtherCaculateViewController alloc] init];
    
    otherCaculateViewController.qrnh = [[[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"nhsy"] floatValue]/100.0;
    otherCaculateViewController.productId =[[_infoDic objectForKey:@"proInfo"] objectForKey:@"id"];
    otherCaculateViewController.extraPoint = [[[_infoDic objectForKey:@"proInfo"] objectForKey:@"extraPoint"] floatValue];
//    otherCaculateViewController.name = [[_infoDic objectForKeyWithoutNull:@"proInfo"] objectForKeyWithoutNull:@"comName"];
    [self.navigationController pushViewController:otherCaculateViewController animated:YES];
    
}
-(void)buyFund
{
    if (![ManagerUser shareInstance].isLogin) {
        [ManagerUtil presentLoginView];
    }else{
        MainOrderViewController* mainOrderViewController = [[MainOrderViewController alloc] init];
        mainOrderViewController.productId =[[_infoDic objectForKey:@"proInfo"] objectForKey:@"id"];
        mainOrderViewController.productName = [[_infoDic objectForKey:@"proInfo"] objectForKey:@"proName"];
        mainOrderViewController.timeLimitNum = [[[_infoDic objectForKey:@"proInfo"] objectForKey:@"timeLimit"] integerValue];
        mainOrderViewController.startBuy = [[[_infoDic objectForKey:@"proInfo"] objectForKey:@"startBuy"] integerValue];
        mainOrderViewController.type = 1;
        [self.navigationController pushViewController:mainOrderViewController animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
