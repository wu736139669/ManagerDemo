//
//  FundListCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-13.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "FundListCell.h"

@implementation FundListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    _buyTypeDtLabel.backgroundColor = [UIColor clearColor];
    _lowestPriceDtLabel.backgroundColor = [UIColor clearColor];
    
    [self setBuyTypeWithString:@"<font color=\"green\">随</font>买随卖"];
    [self setLowestPriceWtihCount:1000];
    //旋转
    _typeLabel.transform = CGAffineTransformMakeRotation( M_PI/4);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setBuyTypeWithString:(NSString *)htmlStr
{
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentRight],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _buyTypeDtLabel.attributedString = percentString;
}
-(void)setLowestPriceWtihCount:(NSInteger)price
{
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\" color:black; \">%ld</span>元起",price];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentRight],DTDefaultTextAlignment,[UIColor grayColor],DTDefaultTextColor, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _lowestPriceDtLabel.attributedString = percentString;

}
-(void)setInfoDic:(NSDictionary *)dic
{
    self.productId = [dic objectForKey:@"jjdm"];
    self.nameLabel.text = [dic objectForKey:@"jjmc"];
    self.profitLabel.text = [NSString stringWithFormat:@"%@ + %@%%",[dic objectForKey:@"nhsy"],[dic objectForKey:@"fd"]];
    self.totalLabel.text = [NSString stringWithFormat:@"已申购%@人",[dic objectForKey:@"ygrs"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",[dic objectForKey:@"wfsy"]];
    [self setLowestPriceWtihCount:[[dic objectForKey:@"startBuy"] integerValue]];
    NSMutableString* timeStr = [[NSMutableString alloc] initWithString:[dic objectForKey:@"jjzq"]];
    [timeStr insertString:@"</span>" atIndex:1];
    [timeStr insertString:@"<span  style=\" color:green;\">" atIndex:0];
    [self setBuyTypeWithString:timeStr];
    if ([[dic objectForKey:@"tip"] isKindOfClass:[NSString class]]) {
        _typeImg.hidden = NO;
        _typeLabel.text = [dic objectForKey:@"tip"];
    }else{
        _typeImg.hidden = YES;
    }
}
@end
