//
//  DatailProfitTopTableViewCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-4.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "DatailProfitTopTableViewCell.h"

@implementation DatailProfitTopTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}
+(DatailProfitTopTableViewCell*)instance
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"DatailProfitTopTableViewCell" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
