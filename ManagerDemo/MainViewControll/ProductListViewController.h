//
//  ProductListViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCSlideSwitchView.h"

@interface ProductListViewController : UIViewController<QCSlideSwitchViewDelegate>
@property (weak, nonatomic) IBOutlet QCSlideSwitchView *slideSwitchView;

@end
