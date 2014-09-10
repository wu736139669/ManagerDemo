//
//  DailyProfitViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "DailyProfitViewController.h"
#import "DailyIncomeTableViewCell.h"
#import "DatailProfitTopTableViewCell.h"
@interface DailyProfitViewController ()
{
    DatailProfitTopTableViewCell* _topCell;
}
@end

@implementation DailyProfitViewController

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
    // Do any additional setup after loading the view.
    _topCell = [DatailProfitTopTableViewCell instance];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self headerBeginRefreshing];
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    NSDictionary* tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:_profitDate, @"profitDate", nil];
    [super loadDataWithDic:tempDic withType:@"profitDatedetail.do" WithcompletionBlock:^(id jsonRes){
        _topCell.profitLabel.text = [jsonRes objectForKey:@"dateProfit"];
        _topCell.timeLabel.text = [NSString stringWithFormat:@"%@收益(元)",[jsonRes objectForKey:@"profitShowDate"]];
        self.navigationItem.title = [NSString stringWithFormat:@"%@收益",[jsonRes objectForKey:@"profitShowDate"]];
        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
    }failedBlock:^(NSError *error){
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
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
    static  NSString *dailyIncomeTableViewCell = @"DailyIncomeTableViewCell";
    DailyIncomeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:dailyIncomeTableViewCell];
    if (cell == nil) {
        
        UINib *nib = [UINib nibWithNibName:@"DailyIncomeTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:dailyIncomeTableViewCell];
        cell = (DailyIncomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:dailyIncomeTableViewCell];
    }
    if (indexPath.section == 0) {
        return _topCell;
    }
    cell.nameLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKey:@"name"];
    cell.timeLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKey:@"date"];
    cell.profitLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKey:@"profit"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
