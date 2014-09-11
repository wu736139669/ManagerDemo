//
//  WYDAmountViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewController.h"
@interface WYDAmountViewController : BaseListViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end
