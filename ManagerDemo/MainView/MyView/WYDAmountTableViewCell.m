//
//  WYDAmountTableViewCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "WYDAmountTableViewCell.h"

@implementation WYDAmountTableViewCell

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
    _nameLabel.text = [dic objectForKey:@"prodTitle"];
    _startTimeLabel.text = [NSString stringWithFormat:@"起息日:%@",[dic objectForKey:@"effectStartTime"]];
    _exceptLabel.text = [NSString stringWithFormat:@"%@ %%",[dic objectForKey:@"prodYearRate"]];
    _unSettlementProfitLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"unSettlementProfit"]];
    _waitReturnLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"waitReturn"]];
    _amountLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"amount"]];
    _recentReturnDateLabel.text = [NSString stringWithFormat:@"%@ 元",[dic objectForKey:@"recentReturnDate"]];
    _stateLabel.text = [dic objectForKey:@"stateStr"];
}
@end
