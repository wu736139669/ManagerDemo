//
//  LoanListCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCircularProgressView.h"

@interface LoanListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *timeDtLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *percentDtlabel;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *percentView;

-(void)setPercent:(NSInteger) percent;
-(void)setTimeWithString:(NSString*)htmlString;
@end
