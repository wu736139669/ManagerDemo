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
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\" color:break; \">%ld</span>元起",price];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentRight],DTDefaultTextAlignment,[UIColor grayColor],DTDefaultTextColor, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _lowestPriceDtLabel.attributedString = percentString;

}
@end
