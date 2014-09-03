//
//  FundListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundListViewController.h"
#import "FundListCell.h"
#import "FundProductInfoViewController.h"
#import "MJRefresh.h"
@interface FundListViewController ()

@end

@implementation FundListViewController

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
-(void)loadData
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi productListForType:@"HW" withPageNum:_pageNum withCompletionBlock:^(id jsonRes) {
        if (_pageNum == 1) {
            [_productInfoArray removeAllObjects];
            [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
        }
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            [_productInfoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
            // 刷新表格
            if ([[jsonRes objectForKey:@"totalPages"] integerValue] <= [[jsonRes objectForKey:@"pageNum"] integerValue]) {
                [self.tableView removeFooter];
            }
            [self.tableView reloadData];
        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
        [self headerEndRefreshing];
        [self footerEndRefreshing];
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productInfoArray.count;
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
    [(FundListCell*)cell setInfoDic:[_productInfoArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FundProductInfoViewController* fundProductInfoViewController = [[FundProductInfoViewController alloc] init];
    [self.delegate.navigationController pushViewController:fundProductInfoViewController animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
