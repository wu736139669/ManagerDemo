//
//  HomeViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeViewController.h"
#import "MJRefresh.h"
#import "HomeAdView.h"
#import "HomeMainView.h"
@interface HomeViewController ()
{
    HomeAdView* _homeAdView;
    HomeMainView* _homeMainView;
}
@end

@implementation HomeViewController

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
    [self.navigationItem setTitle:@"首页"];
    [ManagerUtil SetSubViewExternNone:self];
    //左边按钮
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"贷贷我要" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    
    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarBtnClick:)]];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView headerBeginRefreshing];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if ([ManagerUser shareInstance].isLogin) {
        //左边按钮
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"贷贷我要" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    }else{
        //左边按钮
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    }
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    //广告条
    [daiDaiTongApi getBannerInfoWithcompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            NSMutableArray* bannerInfo = [jsonRes objectForKey:@"infos"];
            [_homeAdView setBannerInfo:bannerInfo];
        }
    } failedBlock:^(NSError *error) {
        DLog(@"失败");
        [MBProgressHUD errorHudWithView:nil label:@"网络出错" hidesAfter:1.0];
    }];
    _homeMainView.hidden = YES;
    [daiDaiTongApi getFundRecommendWithcompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] != 1) {
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }else{
            _homeMainView.hidden = NO;
            [_homeMainView setName:[jsonRes objectForKey:@"name"]];
            [_homeMainView setpercent:[[jsonRes objectForKey:@"percent"] floatValue]/100.0];
            [_homeMainView setExpect:[[jsonRes objectForKey:@"qrsy"] floatValue]];
            [_homeMainView setType:[jsonRes objectForKey:@"tip"]];
            [_homeMainView setInfo:[jsonRes objectForKey:@"activityDesc"]];
            [_homeMainView setSecurityDesc:[jsonRes objectForKey:@"securityDesc"]];
            [_homeMainView setTime:[jsonRes objectForKey:@"jjzq"] withStartBuy:[[jsonRes objectForKey:@"startBuy"] integerValue]];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
    } failedBlock:^(NSError *error) {
        DLog(@"失败");
        [MBProgressHUD errorHudWithView:nil label:@"网络出错" hidesAfter:1.0];
        [self.tableView headerEndRefreshing];
    }];
}

- (void)footerRereshing
{
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    switch (indexPath.row) {
        case 0:
            height = 160.0;
            break;
            case 1:
            height = 280.0;
            break;
        default:
            break;
    }
    return height;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        switch (indexPath.row) {
            case 0:{
                _homeAdView = [[HomeAdView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
                _homeAdView.superViewController = self;
                [cell addSubview:_homeAdView];
            }
                break;
            case 1:{

                
                _homeMainView = [HomeMainView instanceHomeMainView];
                CGRect frame = _homeMainView.frame;
                frame.origin.x = 20;
                _homeMainView.frame = frame;
                [cell addSubview:_homeMainView];
            }
            default:
                break;
        }

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - UIBarButtonClick   导航条两边按钮
-(void)leftBarBtnClick:(id)sender
{
    if (![ManagerUser shareInstance].isLogin) {
        [ManagerUtil presentLoginView];
    }
}
-(void)rightBarBtnClick:(id)sender
{
    [_tableView headerBeginRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
