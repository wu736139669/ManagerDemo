//
//  DailyProfitViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@interface DailyProfitViewController : BaseListViewController
{
    NSString* _profitDate;
    float _totalProfit;
    NSInteger _type;
}
@property(assign, nonatomic)NSInteger type;
@property(assign, nonatomic)float totalProfit;
@property(strong, nonatomic)NSString* profitDate;
@end
