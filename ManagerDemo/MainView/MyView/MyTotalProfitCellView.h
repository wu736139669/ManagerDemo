//
//  MyTotalProfitCellView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-13.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTotalProfitCellView : UIView
{
    UILabel* _totalTitleLabel;
    UILabel* _totalMoneyLabel;
    UILabel* _profitTitleLabel;
    UILabel* _profitMoneyLabel;
}
@property(strong, nonatomic) UILabel* totalTitleLabel;
@property(strong, nonatomic) UILabel* totalMoneyLabel;
@property(strong, nonatomic) UILabel* profitTitleLabel;
@property(strong, nonatomic) UILabel* profitMoneyLabel;
@end
