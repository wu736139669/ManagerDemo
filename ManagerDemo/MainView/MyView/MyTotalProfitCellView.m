//
//  MyTotalProfitCellView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-13.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MyTotalProfitCellView.h"
@implementation MyTotalProfitCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        CGSize size = self.frame.size;
        
        //总收益标签
        _totalTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, size.width/2, 30)];
        _totalTitleLabel.textAlignment = NSTextAlignmentCenter;
        _totalTitleLabel.textColor = [UIColor grayColor];
        _totalTitleLabel.text = @"总资产(元)";
        [self addSubview:_totalTitleLabel];
        //总共的钱
        _totalMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, size.width/2, 30)];
        _totalMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _totalMoneyLabel.textColor = [UIColor darkGrayColor];
        [_totalMoneyLabel setFont:[UIFont systemFontOfSize:25.0]];
        _totalMoneyLabel.text = @"0.0";
        [self addSubview:_totalMoneyLabel];
        
        //中间的线
        UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(size.width/2, 10, 1, size.height-10*2)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        [self addSubview:lineView];
        //左边三角形
        UIImageView* leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray_select_arrow"]];
        leftImageView.frame = CGRectMake(size.width/2-20, size.height-22, 12, 12);
        [self addSubview:leftImageView];
        //右边三角形
        UIImageView* rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gray_select_arrow"]];
        rightImageView.frame = CGRectMake(size.width-20, size.height-22, 12, 12);
        [self addSubview:rightImageView];
        
        //累计收益标签
        _profitTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0+size.width/2, 10, size.width/2, 30)];
        _profitTitleLabel.textAlignment = NSTextAlignmentCenter;
        _profitTitleLabel.textColor = [UIColor grayColor];
        _profitTitleLabel.text = @"累计收益(元)";
        [self addSubview:_profitTitleLabel];
        
        //总共的收益
        _profitMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width/2, 40, size.width/2, 30)];
        _profitMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _profitMoneyLabel.textColor = [UIColor darkGrayColor];
        [_profitMoneyLabel setFont:[UIFont systemFontOfSize:25.0]];
        _profitMoneyLabel.text = @"0.0";
        [self addSubview:_profitMoneyLabel];
        
        //左边按钮。
        UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = [UIColor clearColor];
        leftBtn.frame = CGRectMake(0, 0, size.width/2, size.height);
        [leftBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:leftBtn.frame] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        //左边按钮。
        UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = [UIColor clearColor];
        rightBtn.frame = CGRectMake(size.width/2, 0, size.width/2, size.height);
        [rightBtn setBackgroundImage:[ManagerUtil buttonImageFromColor:Touch_BackGroudColor withFrame:rightBtn.frame] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}

-(void)leftBtnClick:(id)sender
{
    if ([_delegate respondsToSelector:@selector(totalMoneyClick)]) {
        [_delegate totalMoneyClick];
    }
}
-(void)rightBtnClick:(id)sender
{
    
}
@end
