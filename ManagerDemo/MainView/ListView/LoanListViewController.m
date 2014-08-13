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
    return 10;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loanListCell];
        NSArray *LoanListCellObjects = [[NSBundle mainBundle] loadNibNamed:@"LoanListCell" owner:self options:nil];
        cell = [LoanListCellObjects objectAtIndex:0];

    }
    [(LoanListCell*)cell setPercent:40];
    NSString* htmlStr = @"<span style=\"text-align:center; color:green;\">限</span>12个月";
    [(LoanListCell*)cell setTimeWithString:htmlStr];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
