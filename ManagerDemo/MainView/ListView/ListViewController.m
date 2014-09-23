//
//  ListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ListViewController.h"
#import "MJRefresh.h"
@interface ListViewController ()

@end

@implementation ListViewController

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
//    if (ScreenHeight <= 480) {
//        CGRect frame = _tableView.frame;
//        frame.size.height -= 88;
//        _tableView.frame = frame;
//    }
    _productInfoArray = [[NSMutableArray alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setUserInteractionEnabled:YES];
    self.tableView.allowsSelection = YES;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    _pageNum = 1;
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    _pageNum = 1;
    [self loadData];
}

- (void)footerRereshing
{
    _pageNum++;
    [self loadData];
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
-(void)firstRefresh
{
    if ([_productInfoArray count] <= 0) {
        [self headerBeginRefreshing];
    }
}
-(void)loadData
{
    
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 30.0;
    return height;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *homeViewCell = @"HomeViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:homeViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeViewCell];
    }
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    self.delegate = nil;
}
@end
