//
//  FundAmountTableViewCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundAmountTableViewCell.h"

@implementation FundAmountTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfoWithDic:(NSDictionary *)dic
{
    _nameLabel.text = [dic objectForKey:@"fundName"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起息日:%@",[dic objectForKey:@"dataDate"]];
    _qrnhLabel.text = [NSString stringWithFormat:@"%@ %%",[dic objectForKey:@"qrsy"]];
    _unSettlementProfitLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"unConfirmPurchaseAmt"]];
    _wfsyLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"wfsy"]];
    _holdAmountLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"totalAmt"]];
    _totalDateProfitLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"dateProfit"]];
    _todayLabel.text = [NSString stringWithFormat:@"%@收益",[dic objectForKey:@"profitDate"]];
}
@end
