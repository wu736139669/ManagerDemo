//
//  MyHoldAmountViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MyHoldAmountViewController.h"

@interface MyHoldAmountViewController ()
{
    NSArray* _typeArray;
}
@end

@implementation MyHoldAmountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _typeArray = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.slideSwitchView.tabItemNormalColor = [QCSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [QCSlideSwitchView colorFromHexRGB:@"bb0b15"];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    [self initData];
}

#pragma mark - InitData
-(void)initData
{
    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
    [daiDaiTongApi getHoldAssetTypewithCompletionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
            _typeArray = [NSArray arrayWithArray:[jsonRes objectForKey:@"types"]];
        }else{
            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:0.5];
    }];
}
#pragma mark - 滑动tab视图代理方法
//- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
//{
//    // you can set the best you can do it ;
//    return listViewContrllerArray.count;
//}
//
//- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
//{
//    
//    return [listViewContrllerArray objectAtIndex:number];
//}
//
//
//- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
//{
//    _nowSelectTab = number;
//    //进行第一次刷新
//    [(ListViewController*)[listViewContrllerArray objectAtIndex:number] firstRefresh];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
