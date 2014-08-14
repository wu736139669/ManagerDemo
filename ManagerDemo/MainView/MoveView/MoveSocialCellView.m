//
//  MoveSocialCellView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-14.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MoveSocialCellView.h"

@implementation MoveSocialCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    _friendBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _attentionBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _suggestBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    _markBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)friendBtnClick:(id)sender {
}

- (IBAction)attentionBtnClick:(id)sender {
}

- (IBAction)suggestBtnClick:(id)sender {
}

- (IBAction)markBtnClick:(id)sender {
}
@end
