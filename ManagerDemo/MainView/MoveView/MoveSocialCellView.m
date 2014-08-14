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
    [_friendBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:_friendBtn.frame] forState:UIControlStateHighlighted];
    [_attentionBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:_attentionBtn.frame] forState:UIControlStateHighlighted];
    [_suggestBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:_suggestBtn.frame] forState:UIControlStateHighlighted];
    [_markBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:_markBtn.frame] forState:UIControlStateHighlighted];
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
