//
//  BaseListViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _pageNum;
    NSMutableArray* _infoArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSMutableArray* infoArray;
@property (assign, nonatomic)NSInteger pageNum;

- (void)headerRereshing;
- (void)footerRereshing;
- (void)headerBeginRefreshing;
- (void)headerEndRefreshing;
- (void)footerEndRefreshing;
- (void)loadDataWithDic:(NSDictionary*)dic withType:(NSString*)typeStr WithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;;
@end
