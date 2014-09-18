//
//  FundProductInfoViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundProductInfoViewController.h"
#import "MJRefresh.h"
#import "FundCaculateViewController.h"
@interface FundProductInfoViewController ()
{
    NSDictionary* _infoDic;
}
@end

@implementation FundProductInfoViewController

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
    [self headerRereshing];
}
-(void)initData
{
    self.navigationItem.title = [_infoDic objectForKey:@"jjmc"];
    _startBuyLabel.text = [_infoDic objectForKey:@"sgbz"];
    _qrnhLabel.text = [_infoDic objectForKey:@"qrsy"];
    _sgrsLabel.text = [_infoDic objectForKey:@"ygrs"];
    _wfsyLabel.text = [_infoDic objectForKey:@"wfsy"];
    _detailLabel.text = [NSString stringWithFormat:@"额外%@%%积分奖励",[_infoDic objectForKey:@"fd"]];
    [self setTypeLabelWithStr:[_infoDic objectForKey:@"jjzq"]];
    _ysgrsLabel.leftTitleLabel.text = @"已申购人数:";
    _ysgrsLabel.leftInfoLabel.hidden = YES;
    _ysgrsLabel.rightTitleLabel.hidden = YES;
    _ysgrsLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 人",[_infoDic objectForKey:@"ygrs"]];
    _gmbsLabel.leftTitleLabel.text = @"购买比数:";
    _gmbsLabel.leftInfoLabel.hidden = YES;
    _gmbsLabel.rightTitleLabel.hidden = YES;
    _gmbsLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 笔",[_infoDic objectForKey:@"zgmbs"]];
    
    _totalAmountLabel.leftTitleLabel.text = @"总申购金额:";
    _totalAmountLabel.leftInfoLabel.hidden = YES;
    _totalAmountLabel.rightTitleLabel.hidden = YES;
    _totalAmountLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%.2f 元",[[_infoDic objectForKey:@"zsgje"] floatValue]];
    
    _rjsgLabel.leftTitleLabel.text = @"人均申购金额:";
    _rjsgLabel.leftInfoLabel.hidden = YES;
    _rjsgLabel.rightTitleLabel.hidden = YES;
    _rjsgLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ 元",[_infoDic objectForKey:@"rjje"]];
    _qrnhwfsyLabel.leftTitleLabel.text = @"七日年化:";
    _qrnhwfsyLabel.leftInfoLabel.text = [NSString stringWithFormat:@"%@ %%",[_infoDic objectForKey:@"qrsy"]];
    _qrnhwfsyLabel.rightTitleLabel.text = @"万份收益:";
    _qrnhwfsyLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@元",[_infoDic objectForKey:@"wfsy"]];
    
    _zfLabel.leftTitleLabel.text = @"六个月涨幅:";
    _zfLabel.leftInfoLabel.text = [NSString stringWithFormat:@"%@ %%",[_infoDic objectForKey:@"hb6y"]];
    _zfLabel.rightTitleLabel.text = @"一年涨幅:";
    _zfLabel.rightInfoLabel.text = [NSString stringWithFormat:@"%@ %%",[_infoDic objectForKey:@"hb1n"]];
    
    _companyLabel.leftTitleLabel.text = @"基金公司:";
    _companyLabel.leftInfoLabel.text = [_infoDic objectForKey:@"jjgs"];
    _companyLabel.rightTitleLabel.text = @"销售公司:";
    _companyLabel.rightInfoLabel.text = [_infoDic objectForKey:@"ssgs"];
    
    _fundStateLabel.leftTitleLabel.text = @"基金规模:";
    _fundStateLabel.leftInfoLabel.text = [_infoDic objectForKey:@"jjgm"];
    _fundStateLabel.rightTitleLabel.text = @"销售类型:";
    _fundStateLabel.rightInfoLabel.text = [_infoDic objectForKey:@"fundTypeName"];
    
    _moreInfoTextView.text = [_infoDic objectForKey:@"fundIntroduce"];
    _moreInfoTextView.textColor = [UIColor redColor];

}
-(void)setTypeLabelWithStr:(NSString*)originStr
{
    NSMutableString* htmlStr = [[NSMutableString alloc] initWithString:originStr];
    [htmlStr insertString:@"</span>" atIndex:1];
    [htmlStr insertString:@"<span  style=\" color:green;\">" atIndex:0];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentLeft],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _typeLabel.attributedString = percentString;
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getFundDetailWithFundId:_productId withCompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            self.navigationItem.title = [jsonRes objectForKey:@"fundName"];
            _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
        [self initData];
        [self.tableView reloadData];
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
    return 4;
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
            height = _resultsCell.frame.size.height;
        }
            break;
        case 3:
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
            cell = _resultsCell;
        }
            break;
        case 3:
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
    FundCaculateViewController* fundCaculateViewController = [[FundCaculateViewController alloc] init];
    
    fundCaculateViewController.qrnh = [[_infoDic objectForKey:@"qrsy"] floatValue]/100.0;
//    fundCaculateViewController.name =
    [self.navigationController pushViewController:fundCaculateViewController animated:YES];

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
