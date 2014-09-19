//
//  MoreViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MoreViewController.h"
#import "MoveSocialCellView.h"
#import "ActivityCenterViewController.h"
#import "HelpCenterViewController.h"
#import "MessageCenterViewController.h"
#import "AboutViewController.h"
#import "AppDelegate.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

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
    [self.navigationItem setTitle:@"更多"];
    [ManagerUtil SetSubViewExternNone:self];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;

//    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    [_tableView style] = UITableViewStyleGrouped;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_tableView) {
        [_tableView reloadData];
    }
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([ManagerUser shareInstance].isLogin) {
        return 4;
    }
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
            
        default:
            break;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 120.0;
    }
    return 44.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    switch (indexPath.section) {
        case 0:
        {
            //两边的线
            CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(0, 0, 1, cellHeight) ]];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(tableView.frame.size.width-1, 0, 1, cellHeight)]];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            switch (indexPath.row) {

                case 0:
                {
                    cell.textLabel.text = @"活动中心";
                    cell.imageView.image = [UIImage imageNamed:@"more_icon_1"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"消息中心";
                    cell.imageView.image = [UIImage imageNamed:@"more_icon_2"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"帮助中心";
                    cell.imageView.image = [UIImage imageNamed:@"more_icon_3"];
                    cell.detailTextLabel.text = @"有什么我能帮助你的嘛？";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MoveSocialCellView" owner:self options:nil];
            MoveSocialCellView* moveSocialCellView = [nib objectAtIndex:0];
            [cell addSubview:moveSocialCellView];
            //两边的线
            CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(0, 0, 1, cellHeight) ]];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(tableView.frame.size.width-1, 0, 1, cellHeight)]];
        }
            break;
        case 2:
        {
            //两边的线
            CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(0, 0, 1, cellHeight) ]];
            [cell addSubview:[ManagerUtil lineWithColor:[UIColor grayColor] withAlpha:0.3 withFrame:CGRectMake(tableView.frame.size.width-1, 0, 1, cellHeight)]];
            cell.textLabel.font = [UIFont systemFontOfSize:14.0];
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"检查更新";
                    cell.imageView.image = [UIImage imageNamed:@"more_icon_7"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.detailTextLabel.textColor = [UIColor grayColor];
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"当前版本v%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
                    
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"关于贷贷";
                    cell.imageView.image = [UIImage imageNamed:@"more_icon_8"];
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            UIButton* logoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            logoutBtn.backgroundColor = [UIColor clearColor];
            logoutBtn.frame = CGRectMake(0, 0, 280, 44);
            [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
            [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            logoutBtn.backgroundColor = [UIColor colorWithRed:200.0 green:0.0 blue:0.0 alpha:1.0];
            [logoutBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:logoutBtn.frame] forState:UIControlStateHighlighted];
            [logoutBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
            [cell addSubview:logoutBtn];
            cell.backgroundColor = [UIColor clearColor];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                ActivityCenterViewController* activityCenterViewController = [[ActivityCenterViewController alloc] initWithNibName:@"BaseListViewController" bundle:nil];
                activityCenterViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:activityCenterViewController animated:YES];
            }
            if (indexPath.row == 1) {
                MessageCenterViewController* messageCenterViewController = [[MessageCenterViewController alloc] init];
                messageCenterViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:messageCenterViewController animated:YES];
            }
            if (indexPath.row == 2) {
                HelpCenterViewController* helpCenterViewController = [[HelpCenterViewController alloc] initWithNibName:@"BaseListViewController" bundle:nil];
                helpCenterViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:helpCenterViewController animated:YES];
            }

        }
            break;
        case 2:
        {
            if (indexPath.row == 1) {
                AboutViewController* aboutViewController = [[AboutViewController alloc] init];
                aboutViewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:aboutViewController animated:YES];
            }
        }
            break;
        default:
            break;
    }
}
-(void)logout
{
    [ManagerUser shareInstance].isLogin = false;
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app.mainViewController setSelectedIndex:0];
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
