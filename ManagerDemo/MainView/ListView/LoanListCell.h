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
{
    NSString* _productId;
}
@property (strong, nonatomic) NSString* productId;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *timeDtLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *percentDtlabel;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *percentView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pieImage;

-(void)setInfoDic:(NSDictionary *)dic;
@end
