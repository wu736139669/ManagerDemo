//
//  WYDAmountViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "WYDAmountViewController.h"
#import "WYDAmountTableViewCell.h"
@interface WYDAmountViewController ()
{
    NSDictionary* _infoDic;
}
@end

@implementation WYDAmountViewController

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
    self.tableView.tableHeaderView = _topView;
    _infoDic = nil;
}

-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    [super loadDataWithDic:nil withType:@"investRepayingQuery.do" WithcompletionBlock:^(id jsonRes){
        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
        _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
        _totalLabel.text = [_infoDic objectForKey:@"rytFund"];
        [self.tableView reloadData];
    }failedBlock:^(NSError *error){
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_infoDic) {
        return _infoArray.count+1;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 0) {
        return 200.0;
    }
    return 44.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString* cellIdentifier = @"cellIdentifier";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"待收本金(元)";
                    cell.detailTextLabel.text = [_infoDic objectForKey:@"waitReturnMoney"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 1:
                    cell.textLabel.text = @"未结算收益(元)";
                    cell.detailTextLabel.text = [_infoDic objectForKey:@"unSettlementProfit"];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    break;
                case 2:
                    cell.textLabel.text = @"已还款";
                    cell.detailTextLabel.text = @"查看记录";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
        }
        return cell;

    }else{
        static  NSString *wydAmountTableViewCell = @"WYDAmountTableViewCell";
        WYDAmountTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:wydAmountTableViewCell];
        if (cell == nil) {
            
            UINib *nib = [UINib nibWithNibName:@"WYDAmountTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:wydAmountTableViewCell];
            cell = (WYDAmountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:wydAmountTableViewCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setInfoWithDic:[_infoArray objectAtIndex:indexPath.section-1]];
        return cell;

    }
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
