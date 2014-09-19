//
//  TransactionRecordsViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "TransactionRecordsViewController.h"
#import "TransactionRecordsTableViewCell.h"
@interface TransactionRecordsViewController ()

@end

@implementation TransactionRecordsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"全部";
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
//    NSDictionary* tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:_profitDate, @"profitDate", nil];
//    [super loadDataWithDic:tempDic withType:@"profitDatedetail.do" WithcompletionBlock:^(id jsonRes){
//        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
//    }failedBlock:^(NSError *error){
//        
//    }];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_pageNum],@"pageNum", nil] withApiType:@"tradeRecList" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] != 0) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            // 刷新表格
            if ([[jsonRes objectForKey:@"totalNum"] integerValue] <= _pageNum*20) {
//                [self.tableView removeFooter];
            }
            _infoArray = [[NSMutableArray alloc] initWithArray:[jsonRes objectForKey:@"recList"]];
            [self.tableView reloadData];
        }
        [self headerEndRefreshing];
        [self footerEndRefreshing];
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        [self headerEndRefreshing];
        [self footerEndRefreshing];
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *dailyIncomeTableViewCell = @"TransactionRecordsTableViewCell";
    TransactionRecordsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:dailyIncomeTableViewCell];
    if (cell == nil) {
        
        UINib *nib = [UINib nibWithNibName:@"TransactionRecordsTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:dailyIncomeTableViewCell];
        cell = (TransactionRecordsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dailyIncomeTableViewCell];
    }
//    cell.nameLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKey:@"name"];
    cell.timeLabel.text = [ManagerUtil timeFromtimeSp:[[[_infoArray objectAtIndex:indexPath.section] objectForKey:@"tradeTime"] stringValue]];
    cell.amountLabel.text = [NSString stringWithFormat:@"%.2f",[[[_infoArray objectAtIndex:indexPath.section] objectForKey:@"tradeMoney"] floatValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
