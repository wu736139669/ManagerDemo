//
//  OtherProductInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-28.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
#import "TableCellLineView.h"
@interface OtherProductInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,TollBarViewDelegate>
{
    NSString* _productId;
}
@property (strong, nonatomic)NSString* productId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ToolBarView *toolBarView;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *stateInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *resultsInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *securityInfoCell;
@property (weak, nonatomic) IBOutlet UILabel *startBuyLabel;
@property (weak, nonatomic) IBOutlet UILabel *qrnhLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgrsLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *ygrsLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *gmbsLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *totalAmountLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *rjsgLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *jgaqInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *gsaqInfoLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *comPanyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *comPanyInfoLabel;

@end
