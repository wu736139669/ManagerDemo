//
//  FundListCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-13.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundListCell : UITableViewCell
{
    NSString* _productId;
}
@property (strong, nonatomic) NSString* productId;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *numProfitLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet DTAttributedLabel *buyTypeDtLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *lowestPriceDtLabel;


-(void)setBuyTypeWithString:(NSString*)htmlStr;
-(void)setLowestPriceWtihCount:(NSInteger)price;

-(void)setInfoDic:(NSDictionary*)dic;
@end
