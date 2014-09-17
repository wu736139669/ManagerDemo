//
//  MyHoldAmountViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MyHoldAmountViewController.h"
#import "WYDAmountViewController.h"
#import "FundAmountViewController.h"
@interface MyHoldAmountViewController ()
{
    NSArray* _typeArray;
    NSMutableArray* _listViewContrllerArray;  //界面列表
    UILabel* _titleLabel;
}
@end

@implementation MyHoldAmountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _typeArray = nil;
        _listViewContrllerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [ManagerUtil SetSubViewExternNone:self];
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 49)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.numberOfLines = 0;
    self.navigationItem.titleView = _titleLabel;
    [self initData];
    
}

-(void)setTotalAmount:(float)totalAmount
{
    _titleLabel.text = [NSString stringWithFormat:@"持有资产(元)\n%.2f",totalAmount];
}
#pragma mark - InitData
-(void)initData
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getHoldAssetTypewithCompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            _typeArray = [NSArray arrayWithArray:[jsonRes objectForKey:@"types"]];
            [self initSlideSwitchView];
        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
}
-(void)initSlideSwitchView
{
    [_listViewContrllerArray removeAllObjects];
    for (NSString* type in _typeArray) {
        if ([type isEqualToString:@"RYT"]) {
            WYDAmountViewController* wydAmountViewController = [[WYDAmountViewController alloc] init];
            wydAmountViewController.title = @"稳盈贷";
            [_listViewContrllerArray addObject:wydAmountViewController];
        }else{
            FundAmountViewController* fundAmountViewController = [[FundAmountViewController alloc] init];
            fundAmountViewController.title = @"货币基金";
            [_listViewContrllerArray addObject:fundAmountViewController];
        }
    }
    [self.slideSwitchView buildUI];
}
#pragma mark - 滑动tab视图代理方法
- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    // you can set the best you can do it ;
    return _listViewContrllerArray.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    
    return [_listViewContrllerArray objectAtIndex:number];
}


- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
