//
//  MyHoldAmountViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"
@interface MyHoldAmountViewController : UIViewController<QCSlideSwitchViewDelegate>
@property (weak, nonatomic) IBOutlet QCSlideSwitchView *slideSwitchView;

@end
