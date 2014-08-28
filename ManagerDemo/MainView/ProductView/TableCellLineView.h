//
//  TableCellLineView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-28.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCellLineView : UIView
{
    UILabel* _leftTitleLabel;
    UILabel* _leftInfoLabel;
    UILabel* _rightTitleLabel;
    UILabel* _rightInfoLabel;
}

@property(strong, nonatomic)UILabel* leftTitleLabel;
@property(strong, nonatomic)UILabel* leftInfoLabel;
@property(strong, nonatomic)UILabel* rightTitleLabel;
@property(strong, nonatomic)UILabel* rightInfoLabel;

@end
