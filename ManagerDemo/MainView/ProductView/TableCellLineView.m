//
//  TableCellLineView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-28.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "TableCellLineView.h"

@implementation TableCellLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height-20, 100, 20)];
    _leftTitleLabel.font = Font_Black(12);
    _leftTitleLabel.textColor = [UIColor grayColor];
    _leftTitleLabel.text = @"左边名字";
    _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_leftTitleLabel];
    
    _leftInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.bounds.size.height-20, 100, 20)];
    _leftInfoLabel.font = Font_Black(12);
    _leftInfoLabel.text = @"左边内容";
    _leftInfoLabel.textColor = [UIColor grayColor];
    _leftInfoLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_leftInfoLabel];
    
    _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, self.bounds.size.height-20, 100, 20)];
    _rightTitleLabel.font = Font_Black(12);
    _rightTitleLabel.textColor = [UIColor grayColor];
    _rightTitleLabel.text = @"右边名字";
    _rightTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_rightTitleLabel];
    
    _rightInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, self.bounds.size.height-20, 100, 20)];
    _rightInfoLabel.font = Font_Black(12);
    _rightInfoLabel.textColor = [UIColor grayColor];
    _rightInfoLabel.text = @"右边内容";
    _rightInfoLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_rightInfoLabel];
    
    [self addSubview:[ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(10, self.bounds.size.height-1, self.bounds.size.width-20, 1.0)]];
}


@end
