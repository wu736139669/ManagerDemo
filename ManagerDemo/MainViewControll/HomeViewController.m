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
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"左边按钮" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClick:)]];
    
    //右边按钮。
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarBtnClick:)]];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
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
    static  NSString *homeViewCell = @"HomeViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:homeViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.row) {
            case 0:{
                HomeAdView* homeAdView = [[HomeAdView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
                [cell addSubview:homeAdView];
            }
                break;
            case 1:{
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"HomeMainView" owner:self options:nil];

                HomeMainView* homeMainView = (HomeMainView*)[nib objectAtIndex:0];
                CGRect frame = homeMainView.frame;
                frame.origin.x = 20;
                homeMainView.frame = frame;
                [cell addSubview:homeMainView];
            }
            default:
                break;
        }
    }

    return cell;
}
#pragma mark - UIBarButtonClick   导航条两边按钮
-(void)leftBarBtnClick:(id)sender
{
    DLog(@"首页左边按钮");
}
-(void)rightBarBtnClick:(id)sender
{
    DLog(@"首页右边按钮");
    [_tableView headerBeginRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
