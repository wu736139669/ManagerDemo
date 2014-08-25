//
//  LoanListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "LoanListViewController.h"
#import "AdjustableUILable.h"
#import "LoanListCell.h"
#import "WYDProductViewController.h"
@interface LoanListViewController ()
{
}
@end

@implementation LoanListViewController

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
    [self headerBeginRefreshing];
    
}
#pragma mark MJRefreshDelegate
-(void)headerRereshing
{
    _count = 10;
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
    static  NSString *loanListCell = @"LoanListCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:loanListCell];
        if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"LoanListCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:loanListCell];
        cell = (LoanListCell *)[tableView dequeueReusableCellWithIdentifier:loanListCell];

    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    [(LoanListCell*)cell setPercent:40];
    NSString* htmlStr = @"<span style=\"text-align:center; color:green;\">限</span>12个月";
    [(LoanListCell*)cell setTimeWithString:htmlStr];
    cell.selectedBackgroundView = [ManagerUtil selectBackgroudViewWithFrame:CGRectMake(0, 0, 320, [self tableView:tableView heightForRowAtIndexPath:indexPath])];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WYDProductViewController*  wydProductViewController = [[WYDProductViewController alloc] init];
    wydProductViewController.hidesBottomBarWhenPushed = YES;
    [self.delegate.navigationController pushViewController:wydProductViewController animated:YES];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
