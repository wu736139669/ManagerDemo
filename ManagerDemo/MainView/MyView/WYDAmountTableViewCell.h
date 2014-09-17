//
//  WYDAmountTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYDAmountTableViewCell : UITableViewCell
{
    NSString* _state;
    NSString* _fundCode;
    NSString* _investNo;
}
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* fundCode;
@property (strong, nonatomic) NSString* investNo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exceptLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *waitReturnLabel;
@property (weak, nonatomic) IBOutlet UILabel *recentReturnDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *unSettlementProfitLabel;

-(void)setInfoWithDic:(NSDictionary*)dic;
@end
