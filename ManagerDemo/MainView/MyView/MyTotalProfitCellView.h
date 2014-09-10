//
//  MyTotalProfitCellView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-13.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTotalProfitCellViewDelegate <NSObject>

-(void)totalMoneyClick;

@end
@interface MyTotalProfitCellView : UIView
{
    UILabel* _totalTitleLabel;
    UILabel* _totalMoneyLabel;
    UILabel* _profitTitleLabel;
    UILabel* _profitMoneyLabel;
    __weak id<MyTotalProfitCellViewDelegate> _delegate;
}
@property(weak, nonatomic) id<MyTotalProfitCellViewDelegate> delegate;
@property(strong, nonatomic) UILabel* totalTitleLabel;
@property(strong, nonatomic) UILabel* totalMoneyLabel;
@property(strong, nonatomic) UILabel* profitTitleLabel;
@property(strong, nonatomic) UILabel* profitMoneyLabel;
@end
