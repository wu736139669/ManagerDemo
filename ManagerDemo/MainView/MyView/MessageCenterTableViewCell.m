//
//  MessageCenterTableViewCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-3.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MessageCenterTableViewCell.h"

@implementation MessageCenterTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _msgId = @"";
    _msgState = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
