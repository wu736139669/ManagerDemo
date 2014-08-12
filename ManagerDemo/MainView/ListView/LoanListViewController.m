//
//  LoanListViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "LoanListViewController.h"
#import "AdjustableUILable.h"
@interface LoanListViewController ()

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
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat height = 100.0;
//    return height;
//    
//}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *homeViewCell = @"HomeViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:homeViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homeViewCell];
//        AdjustableUILable* label = [[AdjustableUILable alloc] initWithFrame:cell.frame];
//        label.text = @"nihao";
//        label.characterSpacing = 14.0;
//        [cell addSubview:label];
    }
    cell.textLabel.text = [NSString stringWithFormat:@" 第 %d 行",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
