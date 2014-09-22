//
//  FundProductInfoViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
#import "TableCellLineView.h"
@interface FundProductInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,TollBarViewDelegate>
{
    NSString* _productId;
}
@property (strong, nonatomic)NSString* productId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ToolBarView *toolBarView;
@property (strong, nonatomic) IBOutlet UITableViewCell *headCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *stateInfoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *resultsCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutCell;
@property (weak, nonatomic) IBOutlet UILabel *startBuyLabel;
@property (weak, nonatomic) IBOutlet UILabel *qrnhLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgrsLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *typeLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *ysgrsLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *gmbsLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *totalAmountLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *rjsgLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *qrnhwfsyLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *zfLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *companyLabel;
@property (weak, nonatomic) IBOutlet TableCellLineView *fundStateLabel;
@property (weak, nonatomic) IBOutlet UITextView *moreInfoTextView;
@property (weak, nonatomic) IBOutlet TableCellLineView *topTimeLabel;

@end
