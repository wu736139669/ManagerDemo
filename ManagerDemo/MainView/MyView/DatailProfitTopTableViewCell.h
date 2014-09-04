//
//  DatailProfitTopTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatailProfitTopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;

+(DatailProfitTopTableViewCell*)instance;
@end
