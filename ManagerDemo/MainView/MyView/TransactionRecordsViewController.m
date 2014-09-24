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

    [super loadDataWithDic:nil withType:@"tradeRecList" WithcompletionBlock:^(id jsonRes){
        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"recList"]];
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
    cell.nameLabel.text = [[_infoArray objectAtIndex:indexPath.section] objectForKey:@"proName"];
    cell.timeLabel.text = [ManagerUtil timeFromtimeSp:[NSString stringWithFormat:@"%f",[[[_infoArray objectAtIndex:indexPath.section] objectForKey:@"tradeTime"] doubleValue]/1000.0]];
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
