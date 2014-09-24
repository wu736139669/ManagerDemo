//
//  BaseListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "BaseListViewController.h"
#import "MJRefresh.h"
@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pageNum = 1;
        _infoArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.tableView headerBeginRefreshing];
}

#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    _pageNum = 1;
    [self loadDataWithDic:nil withType:nil WithcompletionBlock:^(id jsonRes) {
        
    } failedBlock:^(NSError *error) {
        
    }];
}

- (void)footerRereshing
{
    _pageNum++;
    [self loadDataWithDic:nil withType:nil WithcompletionBlock:^(id jsonRes) {
        
    } failedBlock:^(NSError *error) {
        
    }];
}
- (void)headerBeginRefreshing
{
    [self.tableView headerBeginRefreshing];
}
-(void)headerEndRefreshing
{
    [self.tableView headerEndRefreshing];
}
-(void)footerEndRefreshing
{
    [self.tableView footerEndRefreshing];
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_pageNum],@"pageNum", nil] withApiType:typeStr completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] != 0) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            // 刷新表格
            if (_pageNum == 1) {
                [_infoArray removeAllObjects];
                [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
            }

            if ([[jsonRes objectForKey:@"totalNum"] integerValue] <= _pageNum*20) {
                [self.tableView removeFooter];
            }
            completionBlock(jsonRes);
            [self.tableView reloadData];
        }
        [self headerEndRefreshing];
        [self footerEndRefreshing];
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
        [self headerEndRefreshing];
        [self footerEndRefreshing];
        failedBlock(error);
    }];
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
