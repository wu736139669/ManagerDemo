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
        _type = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _topCell = [DatailProfitTopTableViewCell instance];
    NSDate *  senddate= [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月dd日收益"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    if (_type == 0) {
        self.navigationItem.title = locationString;
    }else{
        self.navigationItem.title = @"累计收益";
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    [self headerBeginRefreshing];
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    NSString* tempTypeStr = @"userTotalProfit";
    if (_type == 0) {
        tempTypeStr = @"userLastDayProfit";
    }
    [super loadDataWithDic:nil withType:tempTypeStr WithcompletionBlock:^(id jsonRes){

        
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 0) {
            _topCell.profitLabel.text = [NSString stringWithFormat:@"%.2f",_totalProfit];
            
             NSDate *  senddate= [NSDate dateWithTimeIntervalSinceNow:-(24 * 60 * 60)];
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            [dateformatter setDateFormat:@"MM月dd日收益(元)"];
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            
            if (_type == 0) {
                _topCell.timeLabel.text = locationString;
            }else{
                _topCell.timeLabel.text = @"稳赢贷累计收益";
            }
            
            [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"userProfits"]];
        }else{
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }
    }failedBlock:^(NSError *error){
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
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
    cell.nameLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKeyWithoutNull:@"proName"];
    NSDate *  senddate= [NSDate dateWithTimeIntervalSince1970:[[[_infoArray objectAtIndex:indexPath.section-1] objectForKeyWithoutNull:@"profitDate"] doubleValue]/1000];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    cell.timeLabel.text = locationString;
    cell.profitLabel.text = [[_infoArray objectAtIndex:indexPath.section-1] objectForKeyWithoutNull:@"profitMoney"];
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
