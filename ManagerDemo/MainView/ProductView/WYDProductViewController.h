//
//  WYDProductViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-15.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolBarView.h"
@interface WYDProductViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, TollBarViewDelegate>
{
    NSString* _productId;
}
@property (strong, nonatomic)NSString* productId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet ToolBarView *toolBarView;

@end
