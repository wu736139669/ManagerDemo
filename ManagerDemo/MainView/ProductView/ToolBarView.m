//
//  ToolBarView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ToolBarView.h"
#import "ProFitCaculateViewController.h"
@implementation ToolBarView
{
    UIButton* _leftBtn;
    UIButton* _rightBtn;
    
}
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
    _leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _leftBtn.frame = CGRectMake(10, 7, 60, 30);
    [_leftBtn setTitle:@"预估收益" forState:UIControlStateNormal];
    [_leftBtn setTitle:@"预估收益" forState:UIControlStateHighlighted];
    _leftBtn.backgroundColor = [UIColor clearColor];
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    //右边按钮
    _rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _rightBtn.frame = CGRectMake(ScreenWidth-100, 7, 80, 30);
    _rightBtn.backgroundColor = [UIColor redColor];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_rightBtn setTitle:@"投标" forState:UIControlStateNormal];
    [_rightBtn setTitle:@"投标" forState:UIControlStateHighlighted];
    [_rightBtn addTarget:self action:@selector(rightBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
}

-(void)setEnable:(BOOL)enable
{
    if (enable) {
        _rightBtn.backgroundColor = [UIColor redColor];
        _rightBtn.enabled = YES;
    }else{
        _rightBtn.backgroundColor = [UIColor grayColor];
        _rightBtn.enabled = NO;
    }
}
-(void)leftBtnClick:(id)sender
{

    if ([self.delegate respondsToSelector:@selector(caculateProfit)]) {
        [self.delegate caculateProfit];
    }
}
-(void)rightBtnclick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(buyFund)]) {
        [self.delegate buyFund];
    }
}
@end
