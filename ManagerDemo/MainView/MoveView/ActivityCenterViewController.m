//
//  ActivityCenterViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ActivityCenterViewController.h"
#import "ActivityCenterTableViewCell.h"
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:activityCenterTableViewCell];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"ActivityCenterTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:activityCenterTableViewCell];
        cell = (ActivityCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:activityCenterTableViewCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
