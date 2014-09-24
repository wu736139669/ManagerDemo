//
//  AccountInfoViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-29.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "AccountInfoViewController.h"
#import "SetPassWordViewController.h"
#import "ModifyPassWordViewController.h"
#import "AuthenticationViewController.h"
@interface AccountInfoViewController ()
{
    NSDictionary* _infoDic;
}
@end

@implementation AccountInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _infoDic = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"账户中心";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_topBtn addTarget:self action:@selector(modifyLoginPassword:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn addTarget:self action:@selector(modifyTransactionsPassword:) forControlEvents:UIControlEventTouchUpInside];
//    [self loadData];
}
-(void)loadData
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getPersonDetailWithcompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            _infoDic = [NSDictionary dictionaryWithDictionary:jsonRes];
            [_tableView reloadData];
        }
        else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:Net_Error_Str hidesAfter:0.5];
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 90;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cellidentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.font = Font_Black(12.0);
    }
    switch (indexPath.section) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_person_take_image"];
            cell.textLabel.text = @"账户";
            cell.detailTextLabel.text = _phoneNum;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 1:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"icon_color_name"];
                cell.textLabel.text = @"实名认证";
                cell.detailTextLabel.text = _name;
            }else{
                cell.imageView.image = [UIImage imageNamed:@"icon_color_idcard"];
                cell.textLabel.text = @"身份认证";
                cell.detailTextLabel.text = _idCard;
            }
        }
            
            break;

        case 2:
        {
            _modifyInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [_topBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_topBtn.frame] forState:UIControlStateHighlighted];
            [_bottomBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_topBtn.frame] forState:UIControlStateHighlighted];
            
            return _modifyInfoCell;
        }
            break;
        case 3:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imageView.image = [UIImage imageNamed:@"hw_verifycard_info_icon"];
            cell.textLabel.text = @"开启手势";
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 20, 10)];
            [switchButton setOn:YES];
//            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchButton;
            
        }
            break;
        case 4:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_color_bank"];
            cell.textLabel.text = @"银行卡管理";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"(%@)",[_infoDic objectForKey:@"cardNum"]];
            
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
}
-(void)modifyLoginPassword:(id)sender
{
    ModifyPassWordViewController* modifyPassWordViewController = [[ModifyPassWordViewController alloc] init];
    modifyPassWordViewController.type = 0;
    modifyPassWordViewController.phoneNum = _phoneNum;
    [self.navigationController pushViewController:modifyPassWordViewController animated:YES];
//    SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
//    [self.navigationController pushViewController:setPassWordViewController animated:YES];
}
-(void)modifyTransactionsPassword:(id)sender
{
    ModifyPassWordViewController* modifyPassWordViewController = [[ModifyPassWordViewController alloc] init];
    modifyPassWordViewController.type = 1;
    modifyPassWordViewController.phoneNum = _phoneNum;
    [self.navigationController pushViewController:modifyPassWordViewController animated:YES];
//    AuthenticationViewController* authenticationViewController = [[AuthenticationViewController alloc] init];
//    [self.navigationController pushViewController:authenticationViewController animated:YES];
//    SetPassWordViewController* setPassWordViewController = [[SetPassWordViewController alloc] init];
//    setPassWordViewController.type = 1;
//    [self.navigationController pushViewController:setPassWordViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
