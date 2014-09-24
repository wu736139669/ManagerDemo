//
//  ComPanyAboutViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-24.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ComPanyAboutViewController.h"

@interface ComPanyAboutViewController ()

@end

@implementation ComPanyAboutViewController

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
    self.navigationItem.title = @"关于";
    _tableView.tableHeaderView = _headView;
    [self initData];
}

-(void)initData
{
    self.nameLabel.text = _comPanyName;
    self.jjComPanyName.text = _jjComPanyNameStr;
    self.xsComPanyName.text = _xsComPanyNameStr;
    self.fundState.text = _fundStateStr;
    self.fundType.text = _fundTypeStr;
    self.infoLabel1.text = _detailInfo1;
    self.infoLabel2.text = _detailInfo2;
    self.infoLabel3.text = _detailInfo3;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
