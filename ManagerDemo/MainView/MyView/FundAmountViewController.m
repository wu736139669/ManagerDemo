//
//  FundAmountViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundAmountViewController.h"
#import "FundAmountTableViewCell.h"
@interface FundAmountViewController ()
{
    NSDictionary* _infoDic;
}
@end

@implementation FundAmountViewController

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
    self.tableView.tableHeaderView = _headView;
    _infoDic = nil;
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    [super loadDataWithDic:[NSDictionary dictionaryWithObject:@"HW" forKey:@"type"] withType:@"accWealthForType.do" WithcompletionBlock:^(id jsonRes){
        [_infoArray addObjectsFromArray:[[jsonRes objectForKey:@"acc"] objectForKey:@"infos"]];
        _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
        _headTotalLabel.text = [[_infoDic objectForKey:@"acc"] objectForKey:@"totalAmount"];
        [self.tableView reloadData];
    }failedBlock:^(NSError *error){
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_infoDic) {
        return _infoArray.count;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static  NSString *wydAmountTableViewCell = @"FundAmountTableViewCell";
    FundAmountTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:wydAmountTableViewCell];
    if (cell == nil) {
            
        UINib *nib = [UINib nibWithNibName:@"FundAmountTableViewCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:wydAmountTableViewCell];
        cell = (FundAmountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:wydAmountTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setInfoWithDic:[_infoArray objectAtIndex:indexPath.section]];
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
