//
//  ActivityCenterViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ActivityCenterViewController.h"
#import "ActivityCenterTableViewCell.h"
#import "SVWebViewController.h"
@interface ActivityCenterViewController ()

@end

@implementation ActivityCenterViewController

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
    self.navigationItem.title = @"活动中心";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{

    [super loadDataWithDic:nil withType:@"activeInfoQuery.do" WithcompletionBlock:^(id jsonRes){
        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
        
    }failedBlock:^(NSError *error){
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _infoArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == _infoArray.count-1) {
        return 10.0;
    }
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *activityCenterTableViewCell = @"ActivityCenterTableViewCell";
    ActivityCenterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:activityCenterTableViewCell];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"ActivityCenterTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:activityCenterTableViewCell];
        cell = (ActivityCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:activityCenterTableViewCell];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.activeUrl = [[_infoArray objectAtIndex:indexPath.section] objectForKey:@"activeUrl"];
    [cell.infoImageView sd_setImageWithURL:[NSURL URLWithString:[[_infoArray objectAtIndex:indexPath.section] objectForKey:@"activePoster"]]];
    cell.infoLabel.text = [[_infoArray objectAtIndex:indexPath.section] objectForKey:@"activeDesc"];
    cell.state = [[_infoArray objectAtIndex:indexPath.section] objectForKey:@"state"];
    cell.activeType = [[[_infoArray objectAtIndex:indexPath.section] objectForKey:@"activeType"] integerValue];
    cell.activeTitle = [[_infoArray objectAtIndex:indexPath.section] objectForKey:@"activeTitle"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVWebViewController* svWebViewController = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:((ActivityCenterTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath]).activeUrl]];
    [self.navigationController pushViewController:svWebViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
