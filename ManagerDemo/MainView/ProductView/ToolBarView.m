//
//  ToolBarView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ToolBarView.h"

@implementation ToolBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    
    //上边线
    UIView* topLine = [ManagerUtil lineWithColor:Touch_BackGroudColor withAlpha:1.0 withFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    [self addSubview:topLine];
    //左边按钮
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(10, 7, 60, 30);
    leftBtn.backgroundColor = [UIColor redColor];
    [self addSubview:leftBtn];
    
    //右边按钮
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(ScreenWidth-100, 7, 80, 30);
    rightBtn.backgroundColor = [UIColor redColor];
    [self addSubview:rightBtn];
}


@end
