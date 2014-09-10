//
//  WYDInfoHeadView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-15.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYDInfoHeadView : UIView
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *hasPercent;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *leftMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *expectLabel;
@property (weak, nonatomic) IBOutlet UILabel *startBuyLabel;
@property (weak, nonatomic) IBOutlet UILabel *benxiLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundPeriodDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialBlackDescLabel;
@property (weak, nonatomic) IBOutlet UILabel *securityTipLabel;


-(void)setProgress:(CGFloat)progress;
-(void)setLeftMoneyAccount:(NSInteger)money;
-(void)setInfoWithDic:(NSDictionary*)dic;
@end
