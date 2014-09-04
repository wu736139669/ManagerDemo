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
}
@property(strong, nonatomic)NSString* profitDate;
@end
