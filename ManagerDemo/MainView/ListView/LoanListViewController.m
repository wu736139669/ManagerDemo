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
#import "MJRefresh.h"
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
-(void)loadData
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi productListForType:@"RYT" withPageNum:_pageNum withCompletionBlock:^(id jsonRes) {

        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            if (_pageNum == 1) {
                [_productInfoArray removeAllObjects];
                [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
            }
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
    static  NSString *CellIdentifier = @"LoanListCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"LoanListCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        cell = (LoanListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    [(LoanListCell*)cell setInfoDic:[_productInfoArray objectAtIndex:indexPath.row]];
    
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
