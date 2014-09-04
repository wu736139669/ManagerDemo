//
//  DailyIncomeTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyIncomeTableViewCell : UITableViewCell
{
    NSString* _profitId;
}
@property (strong, nonatomic)NSString* profitId;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
