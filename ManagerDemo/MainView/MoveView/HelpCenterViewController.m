//
//  HelpCenterViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "HelpCenterTableViewCell.h"
#import "SVWebViewController.h"
@interface HelpCenterViewController ()

@end

@implementation HelpCenterViewController

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
    self.navigationItem.title = @"帮助中心";
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
-(void)loadDataWithDic:(NSDictionary *)dic withType:(NSString *)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    [super loadDataWithDic:nil withType:@"helpquery.do" WithcompletionBlock:^(id jsonRes){
        [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"datas"]];
        
    }failedBlock:^(NSError *error){
        
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    for (int i=0; i<_infoArray.count; i++) {
        if ([[[_infoArray objectAtIndex:i] objectForKey:@"top"]boolValue]) {
            count++;
        }
    }
    return count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == [self numberOfSectionsInTableView:tableView]-1) {
        
        return _infoArray.count-[self numberOfSectionsInTableView:tableView];
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == [self numberOfSectionsInTableView:tableView]-1) {
        return 10.0;
    }
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == [self numberOfSectionsInTableView:tableView]-1) {
        return 45;
    }
    return 90;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellIdentifier = @"HelpCenterTableViewCell";
    HelpCenterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:@"HelpCenterTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        cell = (HelpCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == [self numberOfSectionsInTableView:tableView]-1) {
        [((HelpCenterTableViewCell *)cell).infoTextView setHidden:YES];
    }else{
        [((HelpCenterTableViewCell *)cell).infoTextView setHidden:NO];
    }
    cell.helpTitle.text = [[_infoArray objectAtIndex:indexPath.section+indexPath.row] objectForKey:@"title"];
    cell.helpUrl = [[_infoArray objectAtIndex:indexPath.section+indexPath.row] objectForKey:@"url"];
    cell.infoTextView.text = [[_infoArray objectAtIndex:indexPath.section+indexPath.row] objectForKey:@"titleDesc"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SVWebViewController* svWebViewController = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:((HelpCenterTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath]).helpUrl]];
    [self.navigationController pushViewController:svWebViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
