//
//  OtherListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "OtherListViewController.h"
#import "FundListCell.h"
#import "OtherProductInfoViewController.h"
@interface OtherListViewController ()

@end

@implementation OtherListViewController

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
}

#pragma mark MJRefreshDelegate
-(void)headerRereshing
{
    _count = 6;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        [self headerEndRefreshing];
    });
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 108.0;
    return height;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *loanListCell = @"FundListCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:loanListCell];
    if (cell == nil) {
        
        UINib *nib = [UINib nibWithNibName:@"FundListCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:loanListCell];
        cell = (FundListCell *)[tableView dequeueReusableCellWithIdentifier:loanListCell];
        
    }
    [((FundListCell*)cell).totalLabel setText:@"已经有6783234人"];
    cell.selectedBackgroundView = [ManagerUtil selectBackgroudViewWithFrame:CGRectMake(0, 0, 320, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    OtherProductInfoViewController* otherProductInfoViewController =[[OtherProductInfoViewController alloc] init];
    [self.delegate.navigationController pushViewController:otherProductInfoViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
