//
//  MessageCenterViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-3.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterTableViewCell.h"
#import "MessageDetailViewController.h"
#import "MJRefresh.h"
@interface MessageCenterViewController ()
{
    NSMutableArray* _infoArray;
    NSInteger _pageNum;
}
@end

@implementation MessageCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _infoArray = [[NSMutableArray alloc] init];
        _pageNum = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"消息中心";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    //右边按钮
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"已读" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarBtnClick:)]];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
    [self headerRereshing];
}
#pragma mark UIBarButtonItem
-(void)rightBarBtnClick:(id)sender
{
//    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
//    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
//    [daiDaiTongApi readMsgWithcompletionBlock:^(id jsonRes) {
//        
//        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
//            [MBProgressHUD checkHudWithView:self.view label:@"已全部标记为已读" hidesAfter:0.5];
//        }else{
//            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5]; 
//        }
//    } failedBlock:^(NSError *error) {
//        [MBProgressHUD errorHudWithView:self.view label:Net_Error_Str hidesAfter:0.5];
//    }];
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:nil withApiType:@"setAllMsgRead" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:1.0];
        }else{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD checkHudWithView:self.view label:@"已全部标记为已读" hidesAfter:1.0];
        }
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
    }];
}
#pragma mark MJRefreshDelegate
- (void)headerRereshing
{
    _pageNum = 1;
    [self loadData];
}
- (void)footerRereshing
{
    
    ++_pageNum;
    [self loadData];
}
-(void)loadData
{
    if (_infoArray.count == 0) {
        _tableView.hidden = YES;
    }
    
//    DaiDaiTongApi* daiDaiTongApi = [DaiDaiTongApi shareInstance];
//    [daiDaiTongApi getMsgwithPageNum:_pageNum withCompletionBlock:^(id jsonRes) {
//        if ([[jsonRes objectForKey:@"succ"] integerValue] == 1) {
//            
//            if (_pageNum == 1) {
//                [_infoArray removeAllObjects];
//                [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
//            }
//            if ([[jsonRes objectForKey:@"totalPages"] integerValue] <= [[jsonRes objectForKey:@"pageNum"] integerValue]) {
//                [self.tableView removeFooter];
//            }
//            [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"infos"]];
//            _tableView.hidden = NO;
//        }else{
//            [MBProgressHUD errorHudWithView:nil label:[jsonRes objectForKey:@"err_msg"] hidesAfter:0.5];
//
//        }
//        [self.tableView reloadData];
//        [self.tableView footerEndRefreshing];
//        [self.tableView headerEndRefreshing];
//    } failedBlock:^(NSError *error) {
//        [MBProgressHUD errorHudWithView:self.view label:Net_Error_Str hidesAfter:0.5];
//        [self.tableView footerEndRefreshing];
//        [self.tableView headerEndRefreshing];
//    }];
    
    [MBProgressHUD hudWithView:self.view label:@"安全加载中"];
    DaiDaiTongTestApi* daiDaiTongTestApi = [DaiDaiTongTestApi shareInstance];
    [daiDaiTongTestApi getApiWithParam:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:_pageNum],@"pageNum", nil] withApiType:@"msgList" completionBlock:^(id jsonRes) {
        if ([[jsonRes objectForKey:@"resultflag"] integerValue] == 1) {
            [MBProgressHUD errorHudWithView:self.view label:[jsonRes objectForKey:@"resultMsg"] hidesAfter:0.5];
        }else{
            // 刷新表格
            if (_pageNum == 1) {
                [_infoArray removeAllObjects];
                [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
            }
            
            if ([[jsonRes objectForKey:@"totalNum"] integerValue] <= _pageNum*20) {
                [self.tableView removeFooter];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [_infoArray addObjectsFromArray:[jsonRes objectForKey:@"msgList"]];
            _tableView.hidden = NO;

        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    } failedBlock:^(NSError *error) {
        [MBProgressHUD errorHudWithView:self.view label:@"网络出错" hidesAfter:1.0];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cell";
    MessageCenterTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        UINib *nib = [UINib nibWithNibName:@"MessageCenterTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        cell = (MessageCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.msgId = [[_infoArray objectAtIndex:indexPath.row] objectForKeyWithoutNull:@"msgId"];
    cell.msgState = [[[_infoArray objectAtIndex:indexPath.row] objectForKeyWithoutNull:@"isRead"] integerValue];
    cell.nameLabel.text = [[_infoArray objectAtIndex:indexPath.row] objectForKeyWithoutNull:@"msgTitle"];
    cell.timeLabel.text = [ManagerUtil timeFromtimeSp:[NSString stringWithFormat:@"%f",[[[_infoArray objectAtIndex:indexPath.row] objectForKeyWithoutNull:@"msgTime"] doubleValue]/1000.0]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MessageDetailViewController* messageDetailViewController = [[MessageDetailViewController alloc] init];
    messageDetailViewController.msgId = [[_infoArray objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:messageDetailViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
