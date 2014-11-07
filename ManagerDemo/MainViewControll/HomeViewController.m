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
    if ([ManagerUser shareInstance].isLogin && [ManagerUser shareInstance].isGesturePsw) {
        [ManagerUtil presentGesturePsw];
    }
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
    
    //广告
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"getBanner" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSMutableArray* bannerInfo = [jsonRes objectForKey:@"banners"];
            [_homeAdView setBannerInfo:bannerInfo];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
    }];
    _homeMainView.hidden = YES;
    
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:1],@"pageNum", nil] withApiType:@"proList" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 0) {
            NSDictionary* dic = [[jsonRes objectForKeyWithoutNull:@"proList"] objectAtIndex:0];
            _homeMainView.hidden = NO;
            _homeMainView.fundCode = [dic objectForKeyWithoutNull:@"id"];
            [_homeMainView setName:[dic objectForKeyWithoutNull:@"proName"]];
            [_homeMainView setpercent:[[dic objectForKeyWithoutNull:@"percent"] floatValue]/100.0];
            [_homeMainView setExpect:[[dic objectForKeyWithoutNull:@"nhsy"] floatValue]];
            [_homeMainView setType:[dic objectForKeyWithoutNull:@"tip"]];
            [_homeMainView setInfo:[dic objectForKeyWithoutNull:@"activityDesc"]];
            [_homeMainView setSecurityDesc:[dic objectForKeyWithoutNull:@"syms"]];
            [_homeMainView setTime:[dic objectForKeyWithoutNull:@"timeLimit"] withStartBuy:[[dic objectForKeyWithoutNull:@"startBuy"] integerValue]];
            [_homeMainView setTipColor:[dic objectForKeyWithoutNull:@"tipColor"]];

        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];

 
        
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
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
            height = 148.0;
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
    NSString* cellIdentifier = [NSString stringWithFormat:@"cell%ld",indexPath.row];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        switch (indexPath.row) {
            case 0:{
                _homeAdView = [[HomeAdView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 128)];
                _homeAdView.superViewController = self;
                [cell addSubview:_homeAdView];
            }
                break;
            case 1:{

                
                _homeMainView = [HomeMainView instanceHomeMainView];
                _homeMainView.delegate = self;
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
