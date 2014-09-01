//
//  AccountInfoViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-29.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "AccountInfoViewController.h"

@interface AccountInfoViewController ()

@end

@implementation AccountInfoViewController

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
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
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
    if (indexPath.section == 3) {
        return 90;
    }
    return 44;
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
            cell.textLabel.text = @"我的名字";
            cell.detailTextLabel.text = @"1356725***334";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 1:
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"icon_color_name"];
                cell.textLabel.text = @"我的名字";
                cell.detailTextLabel.text = @"*名字";
            }else{
                cell.imageView.image = [UIImage imageNamed:@"icon_color_idcard"];
                cell.textLabel.text = @"身份认证";
                cell.detailTextLabel.text = @"13123131313**13132";
            }
        }
            
            break;
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"icon_color_bank"];
            cell.textLabel.text = @"银行卡管理";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
            break;
        case 3:
        {
            _modifyInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            [_topBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_topBtn.frame] forState:UIControlStateHighlighted];
            [_bottomBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:[UIColor lightGrayColor] withFrame:_topBtn.frame] forState:UIControlStateHighlighted];
            
            return _modifyInfoCell;
        }
            break;
        case 4:
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
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)modifyPassword:(id)sender
{
    DLog(@"点击");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
