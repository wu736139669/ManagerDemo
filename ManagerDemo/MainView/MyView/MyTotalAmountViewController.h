//
//  MyTotalAmountViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCircularProgressView.h"
@interface MyTotalAmountViewController : UIViewController
{
    float _totalAmount;         //总资产
    float _holdAmount;          //持有资产
    float _accBalance;          //余额
}
- (IBAction)accBalanceClick:(id)sender;
- (IBAction)holdAmountClick:(id)sender;
@property (assign, nonatomic)float totalAmount;
@property (assign, nonatomic)float holdAmount;
@property (assign, nonatomic)float accBalance;

@property (weak, nonatomic) IBOutlet DTAttributedLabel *accBalanceLabel;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *holdAmountView;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *holdAmountLabel;

@property (weak, nonatomic) IBOutlet MRCircularProgressView *accBalanceView;

-(void)setTotalAmount:(float)totalAmount withHoldAmount:(float)holdAmount withAccBalance:(float)accBalance;
@end
