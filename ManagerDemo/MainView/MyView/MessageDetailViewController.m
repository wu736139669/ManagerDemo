//
//  MessageDetailViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-3.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _msgId = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _msgDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _msgDetailLabel.numberOfLines = 0;
    CGRect frame = _msgDetailLabel.frame;
    frame.size.height += 100;
    _msgDetailLabel.frame = frame;
    [self loadData];
}
-(void)loadData
{
//    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
//    _tableView.hidden = YES;
//    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
//    [daiDaiTongApi getMsgDetailwithPageNum:_msgId withCompletionBlock:^(id jsonRes) {
//        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
//            _tableView.hidden = NO;
//            _msgNameLabel.text = [[jsonRes objectForKey:@"data"] objectForKey:@"title"];
//            _msgTimeLabel.text = [[jsonRes objectForKey:@"data"] objectForKey:@"date"];
//            _msgDetailLabel.text = [[jsonRes objectForKey:@"data"] objectForKey:@"content"];
//            CGSize maximumSize = CGSizeMake(280, CGFLOAT_MAX); // 第一个参数是label的宽度，第二个参数是固定的宏定义，CGFLOAT_MAX
//            CGSize expectedLabelSize = [[[jsonRes objectForKey:@"data"] objectForKey:@"content"] sizeWithFont:_msgDetailLabel.font
//                                        constrainedToSize:maximumSize
//                                            lineBreakMode:NSLineBreakByWordWrapping];
//            
//            CGRect newFrame = _msgDetailLabel.frame;
//            newFrame.size.height = expectedLabelSize.height;
//            
//            _msgDetailLabel.frame = newFrame;
//            CGRect frame = _msgTableCell.frame;
//            frame.size.height = 45 + _msgDetailLabel.frame.size.height;
//            _msgTableCell.frame = frame;
//            _msgDetailLabel.text = [[jsonRes objectForKey:@"data"] objectForKey:@"content"];
//
//            [_tableView reloadData];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//        }else{
//            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
//        }
//    } failedBlock:^(NSError *error) {
//        [MBProgressHUD errorHudWithView:self.view label:Net_Error_Str hidesAfter:0.5];
//    }];
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    _tableView.hidden = YES;
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:_msgId, @"msgId", nil] withApiType:@"msgDetail" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            _tableView.hidden = NO;
            _msgNameLabel.text = [[jsonRes objectForKey:@"message"] objectForKeyWithoutNull:@"msgTitle"];
            _msgTimeLabel.text = [ManagerUtil timeFromtimeSp:[NSString stringWithFormat:@"%f",[[[jsonRes objectForKey:@"message"] objectForKeyWithoutNull:@"msgTime"]doubleValue]/1000.0]];;
            _msgDetailLabel.text = [[jsonRes objectForKey:@"message"] objectForKeyWithoutNull:@"msgCont"];
            CGSize maximumSize = CGSizeMake(280, CGFLOAT_MAX); // 第一个参数是label的宽度，第二个参数是固定的宏定义，CGFLOAT_MAX
            CGSize expectedLabelSize = [[[jsonRes objectForKey:@"message"] objectForKeyWithoutNull:@"msgCont"] sizeWithFont:_msgDetailLabel.font
                                                                                            constrainedToSize:maximumSize
                                                                                                lineBreakMode:NSLineBreakByWordWrapping];
            
            CGRect newFrame = _msgDetailLabel.frame;
            newFrame.size.height = expectedLabelSize.height;
            
            _msgDetailLabel.frame = newFrame;
            CGRect frame = _msgTableCell.frame;
            frame.size.height = 45 + _msgDetailLabel.frame.size.height;
            _msgTableCell.frame = frame;
            _msgDetailLabel.text = [[jsonRes objectForKey:@"message"] objectForKeyWithoutNull:@"msgCont"];
            
            [_tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
    }];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _msgTableCell.frame.size.height;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _msgTableCell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
