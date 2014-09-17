//
//  FundAmountTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundAmountTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *qrnhLabel;
@property (weak, nonatomic) IBOutlet UILabel *wfsyLabel;
@property (weak, nonatomic) IBOutlet UILabel *holdAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *unSettlementProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDateProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;


-(void)setInfoWithDic:(NSDictionary *)dic;
@end
